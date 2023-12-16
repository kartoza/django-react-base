import React from 'react';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import '../styles/NavBar.scss';


function Navbar() {
  return (
    <AppBar position="static">
      <Toolbar>
        <Typography className="nav-bar-title" variant="h6" component="div">
          Kartoza App
        </Typography>
        <Button color="inherit">Login</Button>
      </Toolbar>
    </AppBar>
  );
}

export default Navbar;
