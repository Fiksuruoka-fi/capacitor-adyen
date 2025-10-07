import commonjs from '@rollup/plugin-commonjs';
import { nodeResolve } from '@rollup/plugin-node-resolve';
import replace from '@rollup/plugin-replace';
import terser from '@rollup/plugin-terser';
import typescript from '@rollup/plugin-typescript';
import autoprefixer from 'autoprefixer';
import cssnano from 'cssnano';
import postcss from 'rollup-plugin-postcss';
import * as sass from 'sass-embedded';

const external = ['@capacitor/core', '@adyen/adyen-web', 'preact', 'preact/hooks'];

const basePluginsTS = typescript({
  tsconfig: './tsconfig.build.json',
  declaration: true,
  declarationDir: 'dist/esm',
  rootDir: 'src',
});

const basePlugins = [nodeResolve({ browser: true }), commonjs(), replace({ preventAssignment: true }), terser()];

export default [
  // 1) ESM build: the only one that extracts CSS (+ small map)
  {
    input: 'src/index.ts',
    external,
    output: {
      dir: 'dist/esm',
      format: 'esm',
      sourcemap: true,
      sourcemapExcludeSources: true,
      preserveModules: true,
      preserveModulesRoot: 'src',
    },
    plugins: [
      basePluginsTS,
      postcss({
        extract: 'styles.css',
        sourceMap: { inline: false, annotation: false },
        map: { inline: false, annotation: false, sourcesContent: false },
        plugins: [autoprefixer(), cssnano()],
        use: { sass },
      }),
      ...basePlugins,
    ],
  },
  {
    input: 'src/index.ts',
    external,
    output: [
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
        sourcemapExcludeSources: true,
        inlineDynamicImports: true,
      },
      {
        file: 'dist/plugin.cjs.js',
        format: 'cjs',
        sourcemap: true,
        sourcemapExcludeSources: true,
        inlineDynamicImports: true,
      },
    ],
    plugins: [
      basePluginsTS,
      postcss({
        extract: false,
        sourceMap: false,
        use: { sass },
      }),
      ...basePlugins,
    ],
  },
];
