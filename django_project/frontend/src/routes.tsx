// src/routes.tsx
import React from 'react';
import { Route, Routes } from 'react-router-dom';
import Home from './pages/Home';
import About from './pages/About';
import Page from "./pages/Page";

const AppRoutes = () => {
  return (
    <Routes>
      <Route
        path="/"
        element={<Page title="Home"><Home/></Page>}
      />
      <Route
        path="/about"
        element={<Page title="About"><About/></Page>}
      />
    </Routes>
  );
};

export default AppRoutes;