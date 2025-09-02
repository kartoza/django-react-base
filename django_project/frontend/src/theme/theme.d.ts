import '@chakra-ui/react';

declare module '@chakra-ui/react' {
  export interface ButtonProps {
    variant?: 'primary.outline' | 'solid' | 'outline' | 'ghost' | 'link' | 'unstyled';
  }
}