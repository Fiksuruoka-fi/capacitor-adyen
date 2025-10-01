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
      },
    },
    server: {
      host,
      port,
      strictPort: true,
    },
  };
});
