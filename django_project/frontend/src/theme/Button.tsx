import { defineRecipe } from "@chakra-ui/react"

export const buttonRecipe = defineRecipe({
  variants: {
    variant: {
      primary: {
        bg: "primary.main",
        color: "white",
        _hover: { bg: "secondary.main" }
      },
      "primary.outline": {
        bg: "white",
        color: "primary.main",
        border: "1px solid",
        borderColor: "primary.main",
        _hover: {
          bg: "secondary.main",
          color: "white",
          borderColor: "secondary.main",
        }
      },
    },
  }
})