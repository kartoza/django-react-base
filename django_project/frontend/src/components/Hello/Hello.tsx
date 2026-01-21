import React from "react";

export function Hello({ name = 'world' }: { name?: string }) {
  return <span>Hello, {name}!</span>;
}
