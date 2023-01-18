const router = require('express').Router()
const { regUser, logUser } = require('../controllers/userController')
const User = require('../models/User')

// var transporter = nodemailer.createTransport({
//     service: "gmail",
//     auth: {
//         user: "Khanajam828@gmail.com",
//         pass: "LessSecure1pp",
//     },
//     tls: {
//         rejectUnauthorized: false,
//     },
// });

router.route('/users/register').post(regUser)
router.route('/users/login').post(logUser)


//api for sending email
router.post('/sendemail', async (req, res) => {
    try {
        let data = await User.findOne({ email: req.body.email })
        if (data) {
            let otpcode = Math.floor((Math.random()) * 10000 + 1)
            let otpdata = await new OTP({
                email: req.body.email,
                code: otpcode,
                expireIn: new Date().getTime() + 300 * 1000
            })
            let savedOtp = await otpdata.save()
            let sub = "Password reset"
            var mailOptions = {
                from: ' "Password Reset" <Khanajam828@gmail.com> ',
                to: req.body.email,
                subject: "KJM - Password Reset",
                html: ` <p>Your OTP code is ${otpcode} </p>
                        <p> This code <b>expires in 5 minutes</b>.</p> `,
            };
            transporter.sendMail(mailOptions, function (error, info) {
                if (error) {
                    console.log(error);
                } else {
                    console.log(info);
                    console.log(
                        "Password Resetting for email is sent to your gmail account"
                    );
                }
            });
            res.status(200).json({ savedOtp, message: "Check your email for OTP code" })

        }
        else {
            res.status(404).json("Email not registered !!! ")
        }
    } catch (error) {
        res.status(500).json(error)
    }
})

//api for changing password
router.post('/resetpass', async (req, res) => {
    try {
        let data = await OTP.findOne({ email: req.body.email, code: req.body.code })
        if (data) {
            let currentTime = new Date().getTime()
            let diff = data.expireIn - currentTime
            if (diff < 0) {
                res.status(403).json("Expired !!!")
            }
            else {
                let user = await User.findOne({ email: req.body.email })
                user.password = CryptoJS.AES.encrypt(req.body.password, "0010").toString()
                user.save()
                res.status(200).json("Reset Successful !")
            }
        }
        else {
            res.status(403).json("Invalid OTP code ! ")
        }
    } catch (error) {
        res.status(500).json(error)
    }
})

module.exports = router