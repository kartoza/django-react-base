import { expect, test } from '@playwright/test';

let url = '/';


test.describe('Check page', () => {
  test.beforeEach(async ({ page }) => {
    // Go to the starting url before each test.
    await page.goto(url);
  });

  test('has navbar', async ({ page }) => {
    await expect(page.locator('.chakra-heading')).toContainText('Kartoza Django React Base');
  })
});
