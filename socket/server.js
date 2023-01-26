const express = require("express");
const http = require("http");
const port = 3050;
const app = express();
var server = http.createServer(app);
var io = require("socket.io")(server);

io.on("Connection", (socket) => {
  console.log("connected");
});

server.listen(port, "0.0.0.0", () => {
  console.log("Server is Running");
});
