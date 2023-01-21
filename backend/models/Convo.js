const mongoose = require('mongoose')

const ConvoSchema = new mongoose.Schema({
    members: {
        type: Array,
        required: true
    },
    friendname: {
        type: String,
        default: ""
    },
    fr_avatar: {
        public_id: {
            type: String,
            default: ""
        },
        url: {
            type: String,
            default: ""
        },
    },
}, { timestamps: true }  //timestamps will  be given on creation and updation automatically
);

module.exports = mongoose.model('Convo', ConvoSchema) 
