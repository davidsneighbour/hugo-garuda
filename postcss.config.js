module.exports = {
  'plugins': {
    '@fullhuman/postcss-purgecss': {
      content: [
        './layouts/**/*.html',
        './content/**/*.md'
      ],
      keyframes: true,
      variables: true
    },
    'precss': {},
    'autoprefixer': {
      'flexbox': true
    },
    'pixrem': {},
    'cssnano': {
      'preset': 'default'
    }
  }
}
