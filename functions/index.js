const nodemailer = require("nodemailer");
const functions = require("firebase-functions/v2/https"); 
const logger = require("firebase-functions/logger");        

const gmailEmail = 'ergisziu1@gmail.com';
const gmailPassword = 'rqbe crir gtwg zchz'; 

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: gmailEmail,
    pass: gmailPassword,
  },
});

exports.sendOrderEmail = functions.onRequest({ cors: true }, async (req, res) => {
  try {
    const { name, email, address, items } = req.body;

    const mailOptions = {
      from: gmailEmail,
      to: gmailEmail,
      subject: 'New Order from Solana Eyewear',
      text: `
        Name: ${name}
        Email: ${email}
        Address: ${address}
        Items: ${items.join(', ')}
      `,
    };

    await transporter.sendMail(mailOptions);
    res.status(200).send("Email sent successfully");

  } catch (error) {
    logger.error("Error sending email:", error);
    res.status(500).send("Error sending email");
  }
});
