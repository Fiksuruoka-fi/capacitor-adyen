import consola from 'consola';
import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

const README = 'README.md';
const DOCS_DIR = 'docs';
const start = '<!-- API-REF:START -->';
const end = '<!-- API-REF:END -->';

const generateGroupedTOC = (sections) => {
  const groups = {
    'Plugin Interface': [],
    'Card Component': [],
    Styling: [],
    Configuration: [],
    Events: [],
  };

  // Group sections by their type
  sections.forEach((section) => {
    if (section.title.includes('Interface')) {
      const interfaceName = section.title.replace('Interface: ', '');
      if (interfaceName.includes('Plugin')) groups['Plugin Interface'].push(section);
      else if (interfaceName.includes('Card')) groups['Card Component'].push(section);
      else if (interfaceName.includes('Style')) groups['Styling'].push(section);
      else groups['Configuration'].push(section);
    } else if (section.title.includes('Type')) {
      groups['Configuration'].push(section);
    }
  });

  const tocSections = Object.entries(groups)
    .filter(([, items]) => items.length > 0)
    .map(([groupName, items]) => {
      const groupItems = items.map((item) => {
        const anchor = item.title
          .toLowerCase()
          .replace(/[^a-z0-9\s]/g, '')
          .replace(/\s+/g, '-');
        return `  - [${item.title}](#${anchor})`;
      });
      return `- **${groupName}**\n${groupItems.join('\n')}`;
    });

  return tocSections.length > 0 ? `## API Reference\n\n### Table of Contents\n\n${tocSections.join('\n\n')}\n\n` : '';
};

const flattenDocumentation = () => {
  const docsPath = path.join(process.cwd(), DOCS_DIR);

  if (!fs.existsSync(docsPath)) {
    consola.error('Docs directory not found');
    return '';
  }

  const sections = [];
  let flattenedContent = '';

  // Helper to read and process markdown files
  const processMarkdownFile = (filePath, title) => {
    if (!fs.existsSync(filePath)) return { content: '', hasContent: false };

    const fileContent = fs.readFileSync(filePath, 'utf8');

    // Remove the main title and process content
    const processedContent = fileContent
      .replace(/^# .*\n/, '') // Remove main title
      .replace(/^## /gm, '### ') // Demote headings by one level
      .replace(/^### /gm, '#### ') // Demote headings by one level
      .replace(/\]\((?!https?:\/\/)/g, '](#') // Convert relative links to anchors
      .trim();

    const hasContent = processedContent.length > 0;
    const content = hasContent ? `## ${title}\n\n${processedContent}\n\n` : '';

    return { content, hasContent };
  };

  // Process different documentation types
  const documentationTypes = [
    { dir: 'interfaces', prefix: 'Interface' },
    { dir: 'type-aliases', prefix: 'Type' },
    { dir: 'variables', prefix: 'Variable' },
    { dir: 'classes', prefix: 'Class' },
    { dir: 'enums', prefix: 'Enum' },
  ];

  for (const { dir, prefix } of documentationTypes) {
    const typeDir = path.join(docsPath, dir);

    if (fs.existsSync(typeDir)) {
      const files = fs
        .readdirSync(typeDir)
        .filter((file) => file.endsWith('.md'))
        .sort();

      for (const file of files) {
        const name = path.basename(file, '.md');
        const title = `${prefix}: ${name}`;
        const { content, hasContent } = processMarkdownFile(path.join(typeDir, file), title);

        sections.push({ title, hasContent });
        flattenedContent += content;
      }
    }
  }

  // Generate TOC and combine with content
  const toc = generateGroupedTOC(sections);
  return toc + flattenedContent.trim();
};

const injectFlattenedDocs = () => {
  const readme = fs.readFileSync(README, 'utf8');
  const flattenedDocs = flattenDocumentation();

  if (!flattenedDocs) {
    consola.warn('No documentation content found to inject');
    return;
  }

  const next = readme.replace(new RegExp(`${start}[\\s\\S]*${end}`), `${start}\n\n${flattenedDocs}\n\n${end}`);

  fs.writeFileSync(README, next);
  consola.success('README.md updated with API documentation and table of contents');
};

injectFlattenedDocs();
