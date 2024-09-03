/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "app/views/**/*",
    "app/helpers/**/*",
    "app/assets/javascripts/**/*",
  ],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms")],
};
