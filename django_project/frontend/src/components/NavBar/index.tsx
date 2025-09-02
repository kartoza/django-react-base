import React from 'react';
import { Box, Button, Heading, Icon } from '@chakra-ui/react';
import { FaBug } from "react-icons/fa"

import './style.scss';

function Navbar() {
  const errorButtonClicked = () => {
    throw new Error('error!')
  }
  return (
    <Box as="header" bg="primary.main" px={4} py={2} shadow="md">
      <Box>
        <Heading as="h1" size="md" color="white">
          Kartoza Django React Base
        </Heading>
      </Box>
      <Box>
        <Icon as={FaBug} boxSize={6} onClick={errorButtonClicked}
              cursor="pointer"/>
        {/* TODO: Create our own variant*/}
        <Button
          variant="outline" color="white"
          _hover={{ color: 'primary.main' }}
        >
          Login
        </Button>
      </Box>
    </Box>
  );
}

export default Navbar;