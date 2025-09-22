import React from 'react';
import { screen, fireEvent } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { ChakraProvider } from '@chakra-ui/react';
import '@testing-library/jest-dom';
import {render } from "../../testing/render";
import Navbar from './index'; // Adjust path as needed

// Mock console.error to avoid error logs during testing
const originalConsoleError = console.error;
beforeAll(() => {
  console.error = jest.fn();
});

afterAll(() => {
  console.error = originalConsoleError;
});

// Helper function to render component with providers
const renderNavbar = () => {
  return render(
      <Navbar />
  );
};

describe('Navbar Component', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('Rendering', () => {
    test('renders navbar with correct structure', () => {
      renderNavbar();
      
      // Check if main header element exists
      const header = screen.getByRole('banner');
      expect(header).toBeInTheDocument();
      expect(header).toHaveStyle({ background: 'var(--chakra-colors-primary-main)' });
    });

    test('renders heading with correct text and link', () => {
      renderNavbar();
      
      const heading = screen.getByRole('heading', { name: /kartoza django react base/i });
      expect(heading).toBeInTheDocument();
      
      const homeLink = screen.getByRole('link', { name: /kartoza django react base/i });
      expect(homeLink).toBeInTheDocument();
      expect(homeLink).toHaveAttribute('href', '/');
    });

    test('renders all navigation links', () => {
      renderNavbar();
      
      const mapLink = screen.getByRole('link', { name: /map/i });
      const aboutLink = screen.getByRole('link', { name: /about/i });
      
      expect(mapLink).toBeInTheDocument();
      expect(mapLink).toHaveAttribute('href', '/map');
      
      expect(aboutLink).toBeInTheDocument();
      expect(aboutLink).toHaveAttribute('href', '/about');
    });

    test('renders login button', () => {
      renderNavbar();
      
      const loginButton = screen.getByRole('button', { name: /login/i });
      expect(loginButton).toBeInTheDocument();
    });
  });
});