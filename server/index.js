const http = require('http')

const PORT = process.env.PORT || 3001

const requestListener = function (_, res) {
  res.writeHead(200)
  res.end('hello world')
}

const server = http.createServer(requestListener)
server.listen(PORT)
