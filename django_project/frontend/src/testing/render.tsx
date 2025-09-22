import React from 'react';
import { ChakraProvider } from '@chakra-ui/react';
import { BrowserRouter } from 'react-router-dom';
import { render as rtlRender } from "@testing-library/react"
import { kartozaTheme } from "../theme";


export function render(ui: React.ReactNode) {
  return rtlRender(<>{ui}</>, {
    wrapper: (props: React.PropsWithChildren) => (
        <ChakraProvider value={kartozaTheme}>
            <BrowserRouter>
                {props.children}
            </BrowserRouter>
        </ChakraProvider>
    ),
  })
}