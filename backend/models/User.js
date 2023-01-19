const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: [true, "Please Enter Your Name"],
        maxLength: [30, "Name cannot exceed 30 characters"],
        minLength: [2, "Name should have more than 2 characters"],
        unique: true,
    },
    email: {
        type: String,
        required: [true, "Please Enter Your Email"],
        unique: true,
        validate: [validator.isEmail, "Please Enter a valid Email"],
    },
    password: {
        type: String,
        required: [true, "Please Enter Your Password"],
        minLength: [5, "Password should be greater than 4 characters"],
        select: false,
    },
    avatar: {
        public_id: {
            type: String,
            default: ""
        },
        url: {
            type: String,
            default: ""
        },
    },
    friends: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        }
    ],
    conversations: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        }
    ],
    requests: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        }
    ],
    createdAt: {
        type: Date,
        default: Date.now,
    },

    resetPasswordToken: String,
    resetPasswordExpire: Date,
});

//happens before saving a model
//we are hashing the password before saving
userSchema.pre("save", async function (next) {
    if (!this.isModified("password")) {
        next();
    }
    const salt = await bcrypt.genSalt(10)
    this.password = await bcrypt.hash(this.password, salt);
    next()
});

userSchema.methods.comparePassword = async function (password) {
    return await bcrypt.compare(password, this.password);
};

// JWT TOKEN
userSchema.methods.getJWTToken = function () {
    return jwt.sign({ id: this._id }, "timbergthelegend", {
        expiresIn: "10min",
    });
};

module.exports = mongoose.model("User", userSchema);