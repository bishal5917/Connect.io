
const Message = require('../models/Message')
const errorResponse = require('../utils/errorResponse')

//saving new conversations
exports.saveMessage = async (req, res, next) => {
    const newMessage = new Message(req.body)
    try {
        const savedmsg = await newMessage.save()
        res.status(201).send(savedmsg)
    } catch (error) {
        res.status(500).json(error)
    }
}

//geting conversation of a particular user with a user Id
exports.fetchMessages = async (req, res, next) => {
    try {
        const messages = await Message.find({
            conversationId: req.params.cid
        })
        for (const element in messages) {
            element.createdAt = element.createdAt
        }
        res.status(200).json(messages)
    } catch (error) {
        res.status(500).json(error)
    }
}