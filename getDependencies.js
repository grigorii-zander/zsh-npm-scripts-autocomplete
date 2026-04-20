const pkg = require(process.argv[2])

const result = Object
  .entries({ ...pkg.dependencies, ...pkg.devDependencies })
  .map(entry => `${entry[0]}: ${entry[1]}`)
  .join('\n')

console.log(result)
