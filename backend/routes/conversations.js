const router = require('express').Router()
const { saveConversation, getConversation } = require('../controllers/convoController')
const Convo = require('../models/Convo')

router.route('/convos/create').post(saveConversation)
router.route('/convos/get/:uid').get(getConversation)

module.exports = router