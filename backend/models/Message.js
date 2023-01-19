const mongoose = require('mongoose')

const messageSchema = new mongoose.Schema({
    conversationId: {
        type: String,
        required: true
    },
    senderId: {
        type: String,
        required: true
    },
    text: {
        type: String,
        required: true
    },
}, { timestamps: true }  //timestamps will  be given on creation and updation automatically
);

module.exports = mongoose.model('message', messageSchema) 
