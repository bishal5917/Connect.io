const User = require('../models/User');
const errorResponse = require('../utils/errorResponse')

exports.regUser = async (req, res, next) => {
    const { username, email, password } = req.body
    try {
        const user = await User.create({
            username,
            email,
            password
        })
        sendToken(user, 201, res)
    } catch (error) {
        return next(error)
    }
}

exports.logUser = async (req, res, next) => {
    const { email, password } = req.body

    if (!email || !password) {
        return next(new errorResponse("Please Enter email and password !", 400))
    }

    try {
        const user = await User.findOne({ email }).select("+password")
        if (!user) {
            return next(new errorResponse("Invalid email or password !", 404))
        }
        const isMatch = await user.comparePassword(password)
        if (!isMatch) {
            return next(new errorResponse("Invalid Password", 403))
        }

        sendToken(user, 200, res)

    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message
        })
    }
}

const sendToken = (user, statusCode, res) => {
    const token = user.getJWTToken();
    res.status(statusCode).json({ success: true, token, user })

}

//sending friend request to another user
exports.sendFriendRequest = async (req, res, next) => {
    if (req.body.userId !== req.params.id) {
        try {
            const userToRequest = await User.findById(req.params.id)
            const currentUser = await User.findById(req.body.userId)
            if (!userToRequest.requests.includes(req.body.userId)) {
                if (!currentUser.friends.includes(req.params.id)) {
                    await userToRequest.updateOne({ $push: { requests: req.body.userId } })
                    await currentUser.updateOne({ $push: { requested: req.params.id } })
                    res.status(200).send("Request Sent")
                }
                else {
                    return next(new errorResponse("Already a Friend", 403))
                }
            }
            else {
                return next(new errorResponse("Already Requested", 403))
            }

        } catch (error) {
            res.status(500).json(error)
        }
    }
    else {
        return next(new errorResponse("You can't follow yourself !", 403))
    }
}

//accepting friend requests
exports.acceptRequest = async (req, res, next) => {
    if (req.body.userId !== req.body.reqId) {
        try {
            const requestFrom = await User.findById(req.body.reqId)
            const currentUser = await User.findById(req.body.userId)
            if (currentUser.requests.includes(req.body.reqId)) {
                if (!currentUser.friends.includes(req.body.reqId)) {
                    await currentUser.updateOne({ $push: { friends: req.body.reqId } })
                    await requestFrom.updateOne({ $push: { friends: req.body.userId } })
                    await currentUser.updateOne({ $pull: { requests: req.body.reqId } })
                    await requestFrom.updateOne({ $pull: { requested: req.body.userId } })
                    res.status(200).send("Request Accepted !")
                }
                else {
                    return next(new errorResponse("Already a Friend", 403))
                }
            }
            else {
                return next(new errorResponse("Not Found in requested list !", 404))
            }

        } catch (error) {
            res.status(500).json(error)
        }
    }
    else {
        return next(new errorResponse("You can't accept your own !", 403))
    }
}

exports.getMyDetails = async (req, res, next) => {
    try {
        const user = await User.findById(req.params.userId)
        const { password, ...others } = user._doc;
        res.status(200).json(others);
    } catch (err) {
        res.status(500).json(err);
    }
}

exports.getDetails = async (req, res, next) => {
    try {
        const user = await User.findById(req.params.userId)
        const { password, ...others } = user._doc;
        res.status(200).json(others);
    } catch (err) {
        res.status(500).json(err);
    }
}
