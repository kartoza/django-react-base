import type { StorybookConfig } from '@storybook/react-webpack5';
import path from 'path';

const config: StorybookConfig = {
  "stories": [
    "../src/**/*.mdx",
    "../src/**/*.stories.@(js|jsx|mjs|ts|tsx)"
  ],
  "addons": [
    "@storybook/addon-webpack5-compiler-babel",
    "@storybook/addon-docs",
    "@storybook/addon-onboarding"
  ],
  "framework": {
    "name": "@storybook/react-webpack5",
    "options": {}
  },
  staticDirs: ['../public'],
  webpackFinal: async (cfg) => {
    cfg.resolve = cfg.resolve || {};
    cfg.resolve.alias = {
      ...(cfg.resolve.alias || {}),
      '@': path.resolve(__dirname, '../src'),
    };

    // --- SCSS support for Storybook ---
    cfg.module = cfg.module || { rules: [] };
    cfg.module.rules = cfg.module.rules || [];
    cfg.module.rules.push({
      test: /\.s[ac]ss$/i,
      oneOf: [
        // If you use CSS Modules like *.module.scss, enable this branch
        {
          test: /\.module\.s[ac]ss$/i,
          use: [
            require.resolve('style-loader'),
            {
              loader: require.resolve('css-loader'),
              options: { modules: { auto: true, localIdentName: '[name]__[local]--[hash:base64:5]' } },
            },
            require.resolve('sass-loader'),
          ],
        },
        // Global SCSS
        {
          use: [
            require.resolve('style-loader'),
            require.resolve('css-loader'),
            require.resolve('sass-loader'),
          ],
        },
      ],
    });

    return cfg;
  },
};
export default config;