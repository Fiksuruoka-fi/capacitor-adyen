// rollup.config.mjs
import commonjs from '@rollup/plugin-commonjs';
import { nodeResolve } from '@rollup/plugin-node-resolve';
import replace from '@rollup/plugin-replace';
import terser from '@rollup/plugin-terser';
import typescript from '@rollup/plugin-typescript';
import autoprefixer from 'autoprefixer';
import cssnano from 'cssnano';
import postcss from 'rollup-plugin-postcss';
import * as sass from 'sass-embedded';

export default {
  input: 'src/index.ts', // build from source (not dist/esm)
  output: [
    {
      dir: 'dist/esm',
      format: 'esm',
      sourcemap: true,
      preserveModules: true,
      preserveModulesRoot: 'src',
    },
    // Script-tag build (optional)
    {
      file: 'dist/plugin.js',
      format: 'iife',
      name: 'capacitorAdyen',
      globals: {
        '@capacitor/core': 'capacitorExports',
        '@adyen/adyen-web': 'adyenWeb',
        preact: 'preact',
        'preact/hooks': 'preactHooks',
      },
      sourcemap: true,
      inlineDynamicImports: true,
    },
    // CJS build (optional)
    {
      file: 'dist/plugin.cjs.js',
      format: 'cjs',
      sourcemap: true,
      inlineDynamicImports: true,
    },
  ],
  external: ['@capacitor/core', '@adyen/adyen-web', 'preact', 'preact/hooks'],
  plugins: [
    nodeResolve({ browser: true }),
    commonjs(),
    typescript({
      tsconfig: './tsconfig.build.json', // emit types to dist/esm
      declaration: true,
      declarationDir: 'dist/esm',
      rootDir: 'src',
    }),
    postcss({
      extract: 'styles.css',
      sourceMap: true,
      plugins: [autoprefixer(), cssnano()],
      // Use a *preprocessor* so we call the modern API ourselves:
      preprocessor: async (content, id) => {
        if (id.endsWith('.scss') || id.endsWith('.sass')) {
          const result = await sass.compileAsync(id, { style: 'expanded', sourceMap: true });
          return { code: result.css, map: result.sourceMap };
        }
        return { code: content };
      },
    }),
    replace({
      preventAssignment: true,
      // (optional) any shims you used earlier
    }),
    terser(),
  ],
};
