const express = require("express")
var bodyParser = require('body-parser');
const helmet = require('helmet')
const morgan = require('morgan')
const Mongoose = require("mongoose");


// Handling Uncaught Exception
// process.on("uncaughtException", (err) => {
//     console.log(`Error: ${err.message}`);
//     console.log(`Shutting down the server due to Uncaught Exception`);
//     process.exit(1);
// });


const app = express()
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json())

//cors policy
const cors = require("cors");
const corsOptions = {
    origin: '*',
    credentials: true,            //access-control-allow-credentials:true
    optionSuccessStatus: 200,
}
app.use(cors(corsOptions)) // Use this after the variable declaration

MONGO_URL = "mongodb+srv://Bsal:newpass@cluster0.lbpqbeq.mongodb.net/?retryWrites=true&w=majority";

Mongoose.connect(MONGO_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => {
    console.log("Mongodb connected sucessfully")
}).catch((error) => {
    console.log(error)
})


//middlewares
app.use(express.json())
app.use(helmet())
app.use(morgan("dev"))


//import for routes
const userroute = require('./routes/users')


//routes for router
app.use('/api', userroute)


const server = app.listen('5000', () => {
    console.log("Backend is Running")
})

// Unhandled Promise Rejection
process.on("unhandledRejection", (err) => {
    console.log(`Error: ${err.message}`);
    console.log(`Shutting down the server due to Unhandled Promise Rejection`);

    server.close(() => {
        process.exit(1);
    });
});