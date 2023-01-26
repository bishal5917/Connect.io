const router = require("express").Router();
const {
  saveConversation,
  getConversation,
  ifNewConversation,
  getTargetId,
} = require("../controllers/convoController");
const Convo = require("../models/Convo");

router.route("/convos/create").post(saveConversation);
router.route("/convos/get/:uid").get(getConversation);
router.route("/convos/check/:uid/:fid").get(ifNewConversation);
router.route("/convos/getTarget/:cid/:uid").get(getTargetId);

module.exports = router;
