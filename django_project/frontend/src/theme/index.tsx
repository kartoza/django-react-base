import { createSystem, defaultConfig } from "@chakra-ui/react"
import { buttonRecipe } from "./Button";

export const kartozaTheme = createSystem(defaultConfig, {
  theme: {
    tokens: {
      colors: {
        primary: {
          main: { value: "#57A0C7" }
        },
        secondry: {
          main: { value: "#ECB44B" }
        },
      },
    },
    recipes: {
      button: buttonRecipe,
    },
  },
})