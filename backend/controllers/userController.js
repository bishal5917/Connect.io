const User = require('../models/User');

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
        res.status(500).json({
            success: false,
            message: error.message
        })
    }
}

exports.logUser = async (req, res, next) => {
    const { email, password } = req.body

    if (!email || !password) {
        res.status(400).json({ success: false, error: "Please provide email and password" })
    }

    try {
        const user = await User.findOne({ email }).select("+password")
        if (!user) {
            res.status(500).json({ success: false, message: "Invalid Credentials !!!" })
        }
        const isMatch = await user.comparePassword(password)
        if (!isMatch) {
            res.status(500).json({ success: false, message: "Wrong Password !!!" })
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