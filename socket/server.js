const express = require("express");
const http = require("http");
const port = 3050;
const app = express();
var server = http.createServer(app);
var io = require("socket.io")(server);

//creating array for online users
let onlineUsers = [];

//function for creating new users
const addUser = (uid, socketId) => {
  //pushing users into array if there is new user
  !onlineUsers.some((user) => user.uid === uid) &&
    onlineUsers.push({ uid, socketId });
};

//function for removing users
const removeUser = (socketId) => {
  onlineUsers = onlineUsers.filter((user) => user.socketId !== socketId);
};

//function for getting users
const getUser = (uid) => {
  return onlineUsers.find((user) => user.uid === uid);
};

io.on("connection", (socket) => {
  socket.on("/online", (iid) => {
    addUser(iid, socket.id);
    console.log(onlineUsers);
  });

  socket.on("message", (msg) => {
    const foundOne = onlineUsers.find(({ uid }) => uid === msg.targetId);
    const socket_id = foundOne?.socketId;
    console.log(socket_id);
    io.to(socket_id).emit("getmessage", { msg });
    console.log("EMITTED");
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("Server is Running");
});
