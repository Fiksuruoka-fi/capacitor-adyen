import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import path from 'path';
import { defineConfig, loadEnv, type UserConfig } from 'vite';

// https://vite.dev/config/
export default defineConfig(({ mode }): UserConfig => {
  const env = loadEnv(mode, process.cwd(), '');

  const host = env.VITE_ADYEN_TEST_DOMAIN || 'localhost';
  const port = env.VITE_ADYEN_TEST_PORT ? parseInt(env.VITE_ADYEN_TEST_PORT, 10) : 5173;

  return {
    plugins: [react(), tailwindcss()],
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './src'),
        react: 'preact/compat',
        'react-dom/test-utils': 'preact/test-utils',
        'react-dom': 'preact/compat', // Must be below test-utils
        'react/jsx-runtime': 'preact/jsx-runtime',
      },
      dedupe: ['preact'], // ensure a single instance
    },
    optimizeDeps: {
      include: ['preact', 'preact/hooks'],
    },
    server: {
      host,
      port,
      strictPort: true,
    },
  };
});
