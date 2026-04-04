/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './layouts/**/*.html',
    './content/**/*.md',
    './content/**/*.html',
  ],
  theme: {
    extend: {
      colors: {
        'wc-blue':  '#327BB0',
        'wc-light': '#AFD6F2',
      },
      fontFamily: {
        'bauhaus': ['Jost', 'sans-serif'],
        'apparat': ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
