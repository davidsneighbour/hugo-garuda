module.exports = {
  'plugins': {
    // '@fullhuman/postcss-purgecss': {
    //   content: [
    //     './layouts/**/*.html',
    //     './content/**/*.md'
    //   ]
    // },
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
