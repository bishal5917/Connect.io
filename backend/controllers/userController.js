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
        res.status(201).json({
            success: true,
            user
        })
    } catch (error) {
        return next(error)
    }
}

exports.logUser = async (req, res, next) => {
    const { email, password } = req.body

    if (!email || !password) {
        return next(new errorResponse("Please Enter email and password !",400))
    }

    try {
        const user = await User.findOne({ email }).select("+password")
        if (!user) {
            return next(new errorResponse("Invalid email or password !",404))
        }
        const isMatch = await user.comparePassword(password)
        if (!isMatch) {
            return next(new errorResponse("Invalid Password",403))
        }

        res.status(200).json({
            success: true,
            token: "asjiajia",
            user
        })
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message
        })
    }
}