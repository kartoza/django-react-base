import React from 'react';
import { Box, Button, Icon } from '@chakra-ui/react';
import { Link } from 'react-router-dom';
import { FaBug } from "react-icons/fa"

import './style.scss';

function Navbar() {
  const errorButtonClicked = () => {
    throw new Error('error!')
  }
  return (
    <Box as="header" bg="primary.main" px={4} py={2} shadow="md">
      <Box>
        <Link to="/">Kartoza Django React Base</Link>
      </Box>
      <Box>
        <Link to="/about">About</Link>
        <Button variant="primary.outline">
          Login
        </Button>
        <Icon
          as={FaBug}
          onClick={errorButtonClicked}
          cursor="pointer"/>
      </Box>
    </Box>
  );
}

export default Navbar;