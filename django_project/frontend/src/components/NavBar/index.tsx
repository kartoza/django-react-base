import React from 'react';
import { Box, Button, Flex, Heading } from '@chakra-ui/react';

function Navbar() {
  return (
    <Box bg="primary.main" px={4} py={2} shadow="md">
      <Flex justify="space-between" align="center">
        <Heading as="h1" size="md" color="white">
          Kartoza Django React Base
        </Heading>
        {/* TODO: Create our own variant*/}
        <Button
          variant="outline" color="white"
          _hover={{ color: 'primary.main' }}
        >
          Login
        </Button>
      </Flex>
    </Box>
  );
}

export default Navbar;