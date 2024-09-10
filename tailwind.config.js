/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "app/views/**/*",
    "app/helpers/**/*",
    "app/assets/javascripts/**/*",
  ],
  safelist: ["pagy"],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms")],
};
