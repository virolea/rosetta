/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["app/views/**/*", "app/helpers/**/*"],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms")],
};
