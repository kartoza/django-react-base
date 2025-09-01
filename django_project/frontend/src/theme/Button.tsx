import { defineRecipe } from "@chakra-ui/react"

export const buttonRecipe = defineRecipe({
  variants: {
    visual: {
      primary: {
        bg: "primary.main",
        color: "white",
        _hover: { bg: "primary.main" }
      },
    },
  },
})