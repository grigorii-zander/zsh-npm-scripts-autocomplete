const pkg = require(process.argv[2])

const result = Object
  .entries(pkg.scripts || {})
  .map(entry => {
    entry[0] = entry[0].replace(/([$:])/ig, '\\$1')
    entry[1] = entry[1].replace(/([$:])/ig, '\\$1')
    return entry
  })
  .map(entry => `${entry[0]}:$ ${entry[1]}`)
  .join('\n')

console.log(result)
