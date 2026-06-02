import js from "@eslint/js";
import globals from "globals";

export default [
  {
    files: ["src/**/*.{js,mjs,cjs}"],
    ...js.configs.recommended,
    languageOptions: { globals: globals.node },
  },
  {
    files: ["tests/**/*.{js,mjs,cjs}"],
    ...js.configs.recommended,
    languageOptions: {
      globals: {
        ...globals.node,
        ...globals.jest,
      },
    },
  },
];
