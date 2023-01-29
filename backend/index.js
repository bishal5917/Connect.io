const express = require("express");
require("dotenv").config();
var bodyParser = require("body-parser");
const path = require("path");
const multer = require("multer");
const helmet = require("helmet");
const http = require("http");
const morgan = require("morgan");
const Mongoose = require("mongoose");
const app = express();
var socketSvr = http.createServer(app);
var io = require("socket.io")(socketSvr);

// Handling Uncaught Exception
// process.on("uncaughtException", (err) => {
//     console.log(`Error: ${err.message}`);
//     console.log(`Shutting down the server due to Uncaught Exception`);
//     process.exit(1);
// });

// MAKING IMAGES FOLDER PUBLIC TO USE
app.use("/ProfPics", express.static(path.join(__dirname, "/ProfPics")));

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
app.use(bodyParser.json());

//cors policy
const cors = require("cors");
const corsOptions = {
  origin: "*",
  credentials: true, //access-control-allow-credentials:true
  optionSuccessStatus: 200,
};
app.use(cors(corsOptions)); // Use this after the variable declaration

MONGO_URL = `mongodb+srv://${process.env.DB_USERNAME}:${process.env.DB_PASS}@cluster0.lbpqbeq.mongodb.net/?retryWrites=true&w=majority`;

Mongoose.connect(MONGO_URL, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => {
    console.log("Mongodb connected sucessfully");
  })
  .catch((error) => {
    console.log(error);
  });

//middlewares
app.use(express.json());
app.use(helmet());
app.use(morgan("dev"));

//import for routes
const userroute = require("./routes/users");
const conversationroute = require("./routes/conversations");
const messageroute = require("./routes/messages");
const errorHandler = require("./middleware/error");

app.use(errorHandler);

//routes for router
app.use("/api", userroute);
app.use("/api", conversationroute);
app.use("/api", messageroute);

/// *** SOCKET RELATED CODE *** ///

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
    // console.log(socket_id);
    io.to(socket_id).emit("getmessage", { msg });
    // console.log("EMITTED");
  });
});

const server = app.listen("5000", () => {
  console.log("Backend is Running");
});

socketSvr.listen("5000", "0.0.0.0", () => {
  console.log("Socket Server Running");
});

//MULTER RELATED CODE
//code for file upload using multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "ProfPics");
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}${path.extname(file.originalname)}`);
  },
});

function checkFileType(file, cb) {
  const filetypes = /jpg|jpeg|png/;
  const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
  if (extname) {
    return cb(null, true);
  } else {
    cb("Only Images can be upoaded !");
  }
}

const upload = multer({
  storage: storage,
  fileFilter: (req, file, cb) => {
    checkFileType(file, cb);
  },
});

app.post("/api/upload", upload.single("file"), (req, res) => {
  res.status(200).json("file has been uploaded");
});

// Unhandled Promise Rejection
process.on("unhandledRejection", (err) => {
  console.log(`Error: ${err.message}`);
  console.log(`Shutting down the server due to Unhandled Promise Rejection`);

  server.close(() => {
    process.exit(1);
  });
});
