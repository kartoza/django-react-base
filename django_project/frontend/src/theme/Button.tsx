import { defineRecipe } from "@chakra-ui/react"

export const buttonRecipe = defineRecipe({
  variants: {
    variant: {
      primary: {
        bg: "primary.500",
        color: "white",
        _hover: { bg: "secondary.500" }
      },
      "primary.outline": {
        bg: "white",
        color: "primary.500",
        border: "1px solid",
        borderColor: "primary.500",
        _hover: {
          bg: "secondary.500",
          color: "white",
          borderColor: "secondary.500",
        }
      },
    },
  }
})