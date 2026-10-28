import { defineConfig, devices } from '@playwright/test';

/**
 * Playwright E2E Configuration.
 */
export default defineConfig({
  testDir: './e2e',
  fullyParallel: false,
  forbidOnly: !!process.env.CI,
  retries: 0,
  workers: 1,
  reporter: 'list',
  use: {
    baseURL: 'http://localhost:5173',
    trace: 'on-first-retry'
  },
  webServer: [
    {
      command: 'npm run start --workspace=server',
      port: 3001,
      reuseExistingServer: !process.env.CI,
      timeout: 15000
    },
    {
      command: 'npm run dev --workspace=client',
      port: 5173,
      reuseExistingServer: !process.env.CI,
      timeout: 15000
    }
  ],
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] }
    }
  ]
});
