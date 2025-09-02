import React, { ReactNode, useEffect } from 'react';
import { Box } from "@chakra-ui/react";

interface Props {
  title: string;
  children: ReactNode;
}

function Page({ title, children }: Props) {
  useEffect(() => {
    document.title = title;
  }, [title]);

  return (
    <Box className="App" p="1rem">{children}</Box>
  )
}

export default Page;
