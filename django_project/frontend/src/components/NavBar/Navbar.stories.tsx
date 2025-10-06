import type { Meta, StoryObj } from '@storybook/react';
import { Box } from '@chakra-ui/react';
import Navbar from './index';
import React from "react";

const meta = {
  title: 'Layout/Navbar',
  component: Navbar,
  parameters: {
    layout: 'fullscreen', // navbar usually spans full width
  },
  decorators: [
    // Give the story a little vertical room if needed
    (Story) => (
      <Box w="100%">
        <Story />
      </Box>
    ),
  ],
} satisfies Meta<typeof Navbar>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {
  render: () => <Navbar />,
};

export const OnMapRoute: Story = {
  name: 'On /map route',
  render: () => <Navbar />,
  parameters: {
    // If your preview wraps with MemoryRouter, you can set initial route there.
    // If not, add a decorator here that wraps with MemoryRouter({ initialEntries: ['/map'] }).
  },
};

export const LongPage: Story = {
  render: () => (
    <>
      <Navbar />
      <Box p={6}>
        <Box h="200vh" />
      </Box>
    </>
  ),
};