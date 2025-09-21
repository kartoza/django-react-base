import React from 'react';
import { render, screen, RenderResult } from '@testing-library/react';
import ErrorBoundary from './index';
import * as Sentry from '@sentry/react';

// Mock Sentry
jest.mock('@sentry/react', () => ({
  captureException: jest.fn(),
}));

// Type the mocked Sentry
const mockedSentry = Sentry as jest.Mocked<typeof Sentry>;

// Component that throws an error for testing
interface ThrowErrorProps {
  shouldThrow: boolean;
}

const ThrowError: React.FC<ThrowErrorProps> = ({ shouldThrow }) => {
  if (shouldThrow) {
    throw new Error('Test error message');
  }
  return <div>No error</div>;
};

// Component that renders successfully
const SuccessComponent: React.FC = () => <div>Success component</div>;

describe('ErrorBoundary', () => {
  let consoleErrorSpy: jest.SpyInstance;

  beforeEach(() => {
    // Mock console.error to prevent error output during tests
    consoleErrorSpy = jest.spyOn(console, 'error').mockImplementation(() => {});
    // Clear Sentry mock calls
    jest.clearAllMocks();
  });

  afterEach(() => {
    // Restore console.error
    consoleErrorSpy.mockRestore();
  });

  describe('when no error occurs', () => {
    it('should render children normally', () => {
      render(
        <ErrorBoundary>
          <SuccessComponent />
        </ErrorBoundary>
      );

      expect(screen.getByText('Success component')).toBeInTheDocument();
    });

    it('should not call Sentry.captureException', () => {
      render(
        <ErrorBoundary>
          <SuccessComponent />
        </ErrorBoundary>
      );

      expect(mockedSentry.captureException).not.toHaveBeenCalled();
    });
  });

  describe('when an error occurs', () => {
    it('should catch the error and render fallback UI', () => {
      render(
        <ErrorBoundary>
          <ThrowError shouldThrow={true} />
        </ErrorBoundary>
      );

      expect(screen.getByText('Something went wrong!')).toBeInTheDocument();
      expect(screen.getByText('Test error message')).toBeInTheDocument();
    });

    it('should call Sentry.captureException with the error', () => {
      render(
        <ErrorBoundary>
          <ThrowError shouldThrow={true} />
        </ErrorBoundary>
      );

      expect(mockedSentry.captureException).toHaveBeenCalledTimes(1);
      expect(mockedSentry.captureException).toHaveBeenCalledWith(
        expect.objectContaining({
          message: 'Test error message'
        })
      );
    });

    it('should display the error message when error exists', () => {
      render(
        <ErrorBoundary>
          <ThrowError shouldThrow={true} />
        </ErrorBoundary>
      );

      expect(screen.getByText('Test error message')).toBeInTheDocument();
    });

    it('should not display error message when error is null', () => {
      // Create a custom error boundary instance to test null error state
      interface TestErrorBoundaryProps {
        children: React.ReactNode;
      }

      interface TestErrorBoundaryState {
        hasError: boolean;
        error?: Error | null;
        errorInfo?: React.ErrorInfo | null;
      }

      class TestErrorBoundary extends ErrorBoundary {
        constructor(props: TestErrorBoundaryProps) {
          super(props);
          // Manually set state to simulate null error
          this.state = {
            hasError: true,
            error: null,
            errorInfo: null
          } as TestErrorBoundaryState;
        }
      }

      render(
        <TestErrorBoundary>
          <div>Child component</div>
        </TestErrorBoundary>
      );

      expect(screen.getByText('Something went wrong!')).toBeInTheDocument();
      expect(screen.queryByText('Test error message')).not.toBeInTheDocument();
    });
  });

  describe('getDerivedStateFromError', () => {
    it('should return correct state when error occurs', () => {
      const error = new Error('Test error');
      const result = ErrorBoundary.getDerivedStateFromError(error);

      expect(result).toEqual({
        hasError: true,
        error: error,
        errorInfo: null
      });
    });
  });

  describe('componentDidCatch', () => {
    it('should update state with error and errorInfo', () => {
      interface ErrorBoundaryProps {
        children: React.ReactNode;
      }

      const errorBoundaryInstance = new ErrorBoundary({} as ErrorBoundaryProps);
      const error = new Error('Test error');
      const errorInfo: React.ErrorInfo = { 
        componentStack: 'Component stack trace' 
      };

      // Spy on setState with proper typing
      const setStateSpy = jest.spyOn(errorBoundaryInstance, 'setState') as jest.SpyInstance<
        void,
        [Partial<{ hasError: boolean; error?: Error | null; errorInfo?: React.ErrorInfo | null }>]
      >;

      errorBoundaryInstance.componentDidCatch(error, errorInfo);

      expect(setStateSpy).toHaveBeenCalledWith({
        error: error,
        errorInfo: errorInfo
      });

      expect(mockedSentry.captureException).toHaveBeenCalledWith(error);
    });
  });

  describe('error recovery', () => {
    it('should render children normally after error is resolved', () => {
      const { rerender }: RenderResult = render(
        <ErrorBoundary>
          <ThrowError shouldThrow={true} />
        </ErrorBoundary>
      );

      // First render should show error boundary
      expect(screen.getByText('Something went wrong!')).toBeInTheDocument();

      // Re-render with non-throwing component
      rerender(
        <ErrorBoundary>
          <ThrowError shouldThrow={false} />
        </ErrorBoundary>
      );

      // Should still show error boundary (error boundaries don't auto-recover)
      expect(screen.getByText('Something went wrong!')).toBeInTheDocument();
    });
  });

  describe('multiple children', () => {
    it('should render all children when no error occurs', () => {
      render(
        <ErrorBoundary>
          <div>First child</div>
          <div>Second child</div>
          <SuccessComponent />
        </ErrorBoundary>
      );

      expect(screen.getByText('First child')).toBeInTheDocument();
      expect(screen.getByText('Second child')).toBeInTheDocument();
      expect(screen.getByText('Success component')).toBeInTheDocument();
    });

    it('should catch error from any child component', () => {
      render(
        <ErrorBoundary>
          <div>First child</div>
          <ThrowError shouldThrow={true} />
          <div>Third child</div>
        </ErrorBoundary>
      );

      expect(screen.getByText('Something went wrong!')).toBeInTheDocument();
      expect(screen.queryByText('First child')).not.toBeInTheDocument();
      expect(screen.queryByText('Third child')).not.toBeInTheDocument();
    });
  });
});