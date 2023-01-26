const express = require("express");
const http = require("http");
const port = 3050;
const app = express();
var server = http.createServer(app);
var io = require("socket.io")(server);

var onlineUsers = {};

io.on("connection", (socket) => {
  socket.on("/online", (iid) => {
    // console.log(iid);
    onlineUsers[iid] = socket.id;
    console.log(onlineUsers);
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("Server is Running");
});
