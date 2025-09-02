import * as Sentry from "@sentry/react";
import React from 'react';
import { createRoot } from "react-dom/client";
import { ChakraProvider } from "@chakra-ui/react";

import reportWebVitals from './reportWebVitals';
import ErrorBoundary from "./components/ErrorBoundary";
import { BrowserRouter as Router } from "react-router-dom";

import { kartozaTheme } from "./theme";
import Navbar from "./components/NavBar";
import AppRoutes from './routes';

import './styles/index.scss';

Sentry.init({
  dsn: (window as any).sentryDsn,
  tunnel: '/sentry-proxy/',
  tracesSampleRate: 0.5
})

const rootElement = document.getElementById('app')!
const root = createRoot(rootElement);
root.render(
  <ErrorBoundary>
    <ChakraProvider value={kartozaTheme}>
      <React.StrictMode>
        <Router>
          <Navbar/>
          <AppRoutes/>
        </Router>
      </React.StrictMode>
    </ChakraProvider>
  </ErrorBoundary>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
