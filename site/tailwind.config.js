const defaultTheme = require('tailwindcss/defaultTheme');
const { orange } = require('tailwindcss/colors');

// backdrop-filter backdrop-blur bg-opacity-30

module.exports = {
  darkMode: 'class',

  purge: {
    enabled: process.env.PURGE_CSS === 'true',
    layers: ['base', 'utilities'],

    content: [
      './app/index.html',
      './app/**/*.hbs',
      '../docs/**/*.md',
      './node_modules/**/*.hbs',
      '../node_modules/**/*.hbs'
    ],
    options: {
      safelist: [/^_/, /js-/]
    }
  },

  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', ...defaultTheme.fontFamily.sans]
      },
      colors: {
        gray: {
          1000: '#12161f'
        },
        primary: orange,
        brand: '#f97316'
      },
      zIndex: {
        1: '1'
      },
      maxHeight: {
        '(screen-16)': 'calc(100vh - 4rem)'
      },
      typography: (theme) => ({
        DEFAULT: {
          css: {
            maxWidth: 'none',
            color: theme('colors.gray.500'),
            fontFamily: ['Inter', ...defaultTheme.fontFamily.sans].join(', '),
            a: {
              color: theme('colors.primary.700'),
              fontWeight: theme('fontWeight.medium'),
              textDecoration: 'none'
            },
            'a code': {
              color: 'inherit',
              fontWeight: 'inherit'
            },
            strong: {
              color: theme('colors.gray.900'),
              fontWeight: theme('fontWeight.medium')
            },
            'a strong': {
              color: 'inherit',
              fontWeight: 'inherit'
            },
            code: {
              fontWeight: theme('fontWeight.normal'),
              padding: theme('padding.1'),
              backgroundColor: theme('colors.gray.100'),
              borderRadius: theme('borderRadius.sm')
            },
            'code::before': null,
            'code::after': null
          }
        },
        light: {
          css: [
            {
              color: theme('colors.gray.300'),
              '[class~="lead"]': {
                color: theme('colors.gray.200')
              },
              a: {
                color: theme('colors.white')
              },
              strong: {
                color: theme('colors.white')
              },
              'ol > li::before': {
                color: theme('colors.gray.400')
              },
              'ul > li::before': {
                backgroundColor: theme('colors.gray.600')
              },
              hr: {
                borderColor: theme('colors.gray.200')
              },
              blockquote: {
                color: theme('colors.gray.200'),
                borderLeftColor: theme('colors.gray.600')
              },
              h1: {
                color: theme('colors.white')
              },
              h2: {
                color: theme('colors.white')
              },
              h3: {
                color: theme('colors.white')
              },
              h4: {
                color: theme('colors.white')
              },
              'figure figcaption': {
                color: theme('colors.gray.400')
              },
              code: {
                backgroundColor: theme('colors.gray.900'),
                color: theme('colors.white')
              },
              'a code': {
                color: theme('colors.white')
              },
              pre: {
                color: theme('colors.gray.200'),
                backgroundColor: theme('colors.gray.900')
              },
              thead: {
                color: theme('colors.white'),
                borderBottomColor: theme('colors.gray.400')
              },
              'tbody tr': {
                borderBottomColor: theme('colors.gray.600')
              }
            }
          ]
        }
      })
    },
    frontile: () => {
      return {
        overlays: {
          config: {
            backdropColor: 'rgba(17,24,39, 0.5)'
          },

          extend: {
            overlay: {
              parts: {
                backdrop: {
                  backdropFilter: 'blur(8px)'
                }
              }
            }
          }
        }
      };
    }
  },
  variants: {
    extend: {
      typography: ['dark'],
      boxShadow: ['focus-visible'],
      ringWidth: ['focus-visible']
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@frontile/core/tailwind'),
    require('@frontile/overlays/tailwind')
  ]
};
