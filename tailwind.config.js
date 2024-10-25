module.exports = {
  theme: {
    extend: {
      typography: {
        // Keep default styles
        DEFAULT: {},
        // Add custom 'even' modifier
        even: {
          css: {
            'h1, h2, h3, h4, h5, h6, p, ul, ol, blockquote, figure, pre': {
              marginTop: '0.5em',
              marginBottom: '0.5em',
            },
            'h1:first-child, h2:first-child, h3:first-child, p:first-child': {
              marginTop: '0',
            },
            'h1:last-child, h2:last-child, h3:last-child, p:last-child': {
              marginBottom: '0',
            },
            'ul > li': {
              marginTop: '0.5em',
              marginBottom: '0.5em',
            },
            'ol > li': {
              marginTop: '0.5em',
              marginBottom: '0.5em',
            }
          }
        }
      }
    }
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require('@tailwindcss/line-clamp'),
  ],
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/components/**/*.{rb,html,html.erb,yml}'
  ]
}
