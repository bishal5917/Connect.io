
const Convo = require('../models/Convo')
const User = require('../models/User')
const errorResponse = require('../utils/errorResponse')

//saving new conversations
exports.saveConversation = async (req, res, next) => {
    const newConversation = new Convo({
        members: [req.body.senderId, req.body.receiverId]
    })
    try {
        const savedConvo = await newConversation.save()
        res.status(200).send(savedConvo)
    } catch (error) {
        res.status(500).json(error)
    }
}

//geting conversation of a particular user with a user Id
exports.getConversation = async (req, res, next) => {
    try {
        const findConversation = await Convo.find({
            members: { $in: [req.params.uid] }
        })
        findConversation.forEach(myFunc)
        function myFunc(element) {
            let copyarray = element.members
            copyarray.pull(req.params.uid)
            element["nextId"] = copyarray[0]
            copyarray.push(req.params.uid)
        }
        res.status(200).json(findConversation)
    } catch (error) {
        res.status(500).json(error)
    }
}