var nodemailer = require("nodemailer");
require("dotenv").config();

let transporter = nodemailer.createTransport({
  service: "Gmail",
  auth: {
    user: process.env.MAILER_USERNAME,
    pass: process.env.MAILER_PASS,
  },
});

const mailerr = (email, subject, text) => {
  transporter.sendMail(
    {
      from: '"Khanajam" <Khanajam828@gmail.com>', // sender address
      to: email, // list of receivers
      subject: subject, // Subject line
      text: text,
    },
    (err, info) => {
      if (err) {
        console.log(err);
      } else {
        console.log("email sent successfully : " + info.response);
      }
    }
  );
};

module.exports = mailerr;
