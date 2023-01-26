const express = require("express");
const http = require("http");
const port = 3050;
const app = express();
var server = http.createServer(app);
var io = require("socket.io")(server);

var onlineUsers = {};

io.on("connection", (socket) => {
  socket.on("/online", (iid) => {
    onlineUsers[iid] = socket;
    // console.log(onlineUsers);
  });

  socket.on("message", (msg) => {
    console.log(msg);
    let targetId = msg.targetId;
    if (onlineUsers[targetId]) {
        console.log("Emitted");
      onlineUsers[targetId].emit("message", msg);
    }
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("Server is Running");
});
