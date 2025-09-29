import path from 'path';
import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import { defineConfig, loadEnv } from 'vite';

// https://vite.dev/config/
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');

  const host = env.VITE_ADYEN_TEST_DOMAIN || 'localhost';
  const port = env.VITE_ADYEN_TEST_PORT ? parseInt(env.VITE_ADYEN_TEST_PORT, 10) : 5173;

  return {
    plugins: [react(), tailwindcss()],
    resolve: {
      alias: {
        '@': path.resolve(__dirname, './src'),
      },
    },
    server: {
      host,
      port,
      strictPort: true,
    },
  };
});
