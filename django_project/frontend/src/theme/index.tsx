import { createSystem, defaultConfig } from "@chakra-ui/react"
import { buttonRecipe } from "./Button";

const COLORS = {
  primary: {
    50: { value: "#E3F2FA" },
    100: { value: "#C1E0F4" },
    200: { value: "#9FCDEE" },
    300: { value: "#7CB9E8" },
    400: { value: "#5AA5E2" },
    500: { value: "#57A0C7" },
    600: { value: "#4F91B2" },
    700: { value: "#477F9D" },
    800: { value: "#3F6D88" },
    900: { value: "#375C73" },
    950: { value: "#2F4B5E" },
  },
  secondary: {
    50: { value: "#FFF6E5" },
    100: { value: "#FFEDC2" },
    200: { value: "#FFE29E" },
    300: { value: "#FFD77A" },
    400: { value: "#FFCC56" },
    500: { value: "#ECB44B" },
    600: { value: "#D69F42" },
    700: { value: "#BF8B39" },
    800: { value: "#A97630" },
    900: { value: "#916226" },
    950: { value: "#7A501D" },
  }
}
export const kartozaTheme = createSystem(defaultConfig, {
  theme: {
    tokens: {
      colors: COLORS,
    },
    recipes: {
      button: buttonRecipe,
    },
  },
})

