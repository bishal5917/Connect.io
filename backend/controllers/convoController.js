const Convo = require("../models/Convo");
const User = require("../models/User");
const errorResponse = require("../utils/errorResponse");

//saving new conversations
exports.saveConversation = async (req, res, next) => {
  const newConversation = new Convo({
    members: [req.body.senderId, req.body.receiverId],
  });
  try {
    const savedConvo = await newConversation.save();
    res.status(200).send(savedConvo);
  } catch (error) {
    res.status(500).json(error);
  }
};

//geting conversation of a particular user with a user Id
exports.getConversation = async (req, res, next) => {
  try {
    const findConversation = await Convo.find({
      members: { $in: [req.params.uid] },
    });
    for (const element of findConversation) {
      let copyarray = element.members;
      copyarray.pull(req.params.uid);
      try {
        const user = await User.findById(copyarray[0]);
        const { password, ...others } = user._doc;
        element["friendname"] = others.username;
        element["fr_avatar"]["public_id"] = others.avatar.public_id;
        element["fr_avatar"]["url"] = others.avatar.url;
        copyarray.push(req.params.uid);
      } catch (err) {
        res.status(500).json(err);
      }
    }
    res.status(200).json(findConversation);
  } catch (error) {
    res.status(500).json(error);
  }
};

//checking if there was already a conversation with a friend
exports.ifNewConversation = async (req, res, next) => {
  try {
    const findConversation = await Convo.findOne({
      members: [req.params.uid, req.params.fid],
    });
    if (findConversation) {
      return res.status(200).send(findConversation);
    } else {
      return res.status(404).send("Not Found");
    }
  } catch (error) {
    res.status(500).json(error);
  }
};
