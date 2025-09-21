import React from 'react';
import { screen, waitFor } from '@testing-library/react';
import MapLibre from './index';
import maplibregl from 'maplibre-gl';
import {render } from "../../testing/render";

// Mock the CSS imports
jest.mock('maplibre-gl/dist/maplibre-gl.css', () => {});
jest.mock('./style.scss', () => {});

// Mock the data imports
jest.mock('./data', () => ({
  layers: [
    {
      id: 'test-layer',
      type: 'background',
      paint: {
        'background-color': '#ffffff'
      }
    }
  ],
  sources: {
    'test-source': {
      type: 'vector',
      url: 'test-url'
    }
  }
}));

// Mock maplibre-gl
const mockAddControl = jest.fn();
const mockMap = {
  addControl: mockAddControl,
  remove: jest.fn(),
  getContainer: jest.fn(),
  isStyleLoaded: jest.fn(() => true),
  on: jest.fn(),
  off: jest.fn(),
};

const mockNavigationControl = {
  onAdd: jest.fn(),
  onRemove: jest.fn(),
};

jest.mock('maplibre-gl', () => ({
  Map: jest.fn(() => mockMap),
  NavigationControl: jest.fn(() => mockNavigationControl),
}));

// Type the mocked maplibre-gl
const mockedMaplibregl = maplibregl as jest.Mocked<typeof maplibregl>;

describe('MapLibre Component', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  describe('rendering', () => {
    it('should render a Box component with id "map"', () => {
      render(
          <MapLibre />
      );

      const mapContainer = document.getElementById('map');
      expect(mapContainer).toBeInTheDocument();
    });

    it('should render without crashing', () => {
      expect(() => {
        render(
            <MapLibre />
        );
      }).not.toThrow();
    });
  });

  describe('map initialization', () => {
    it('should create a new maplibre-gl Map instance on mount', async () => {
      render(
          <MapLibre />
      );

      await waitFor(() => {
        expect(mockedMaplibregl.Map).toHaveBeenCalledTimes(1);
      });
    });

    it('should initialize map with correct configuration', async () => {
      render(
          <MapLibre />
      );

      await waitFor(() => {
        expect(mockedMaplibregl.Map).toHaveBeenCalledWith({
          container: 'map',
          style: {
            version: 8,
            sources: {
              'test-source': {
                type: 'vector',
                url: 'test-url'
              }
            },
            layers: [
              {
                id: 'test-layer',
                type: 'background',
                paint: {
                  'background-color': '#ffffff'
                }
              }
            ],
            glyphs: '/static/fonts/{fontstack}/{range}.pbf',
          },
          center: [0, 0],
          zoom: 1,
          attributionControl: false,
        });
      });
    });

    it('should add NavigationControl to the map', async () => {
      render(
          <MapLibre />
      );

      await waitFor(() => {
        expect(mockedMaplibregl.NavigationControl).toHaveBeenCalledTimes(1);
        expect(mockAddControl).toHaveBeenCalledWith(
          mockNavigationControl,
          'bottom-left'
        );
      });
    });
  });


  describe('component cleanup', () => {
    it('should handle component unmounting gracefully', () => {
      const { unmount } = render(
          <MapLibre />
      );

      expect(() => {
        unmount();
      }).not.toThrow();
    });
  });

  describe('accessibility', () => {
    it('should have proper container element for screen readers', () => {
      render(
          <MapLibre />
      );

      const mapContainer = document.getElementById('map');
      expect(mapContainer).toBeInTheDocument();
      expect(mapContainer).toHaveAttribute('id', 'map');
    });
  });

  describe('data integration', () => {
    it('should use imported sources and layers in map style', async () => {
      render(
          <MapLibre />
      );

      await waitFor(() => {
        const mapCall = (mockedMaplibregl.Map as jest.Mock).mock.calls[0][0];
        expect(mapCall.style.sources).toEqual({
          'test-source': {
            type: 'vector',
            url: 'test-url'
          }
        });
        expect(mapCall.style.layers).toEqual([
          {
            id: 'test-layer',
            type: 'background',
            paint: {
              'background-color': '#ffffff'
            }
          }
        ]);
      });
    });
  });
});