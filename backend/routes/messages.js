const router = require('express').Router()
const { saveMessage, fetchMessages } = require('../controllers/messageController')
const Convo = require('../models/Convo')

router.route('/messages/send').post(saveMessage)
router.route('/messages/fetch/:cid').get(fetchMessages)

module.exports = router