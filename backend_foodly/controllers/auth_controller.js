const User = require("../models/user");
const CryptoJS = require("crypto-js");
const jwt = require("jsonwebtoken");
const generatOtp = require("../utils/otp_generator");
const sendEmail = require("../utils/smtp_function");

module.exports = {
  createUser: async (req, res) => {
    const emailRegex =
      /^([A-Z0-9_+-]+\.?)*[A-Z0-9_+-]@([A-Z0-9][A-Z0-9-]*\.)+[A-Z]{2,}$/i;
    if (!emailRegex.test(req.body.email)) {
      return res
        .status(400)
        .json({ status: false, message: "Email is not valid!" });
    }

    const minPasswordLenght = 8;
    if (req.body.password < minPasswordLenght) {
      return res.status(400).json({
        status: false,
        message:
          "Password should be at least" +
          minPasswordLenght +
          "characters long!",
      });
    }

    try {
      const emailExists = await User.findOne({ email: req.body.email });

      if (emailExists) {
        return res
          .status(400)
          .json({ status: false, message: "Email already exists!" });
      }
      //gen_otp
      const otp = generatOtp();
      const newUser = new User({
        username: req.body.username,
        email: req.body.email,
        userType: "Client",
        password: CryptoJS.AES.encrypt(
          req.body.password,
          process.env.SECRET
        ).toString(),
        otp: otp,
      });
      //save user
      await newUser.save();
      //send otp
      sendEmail(newUser.email, otp);
      res
        .status(201)
        .json({ status: true, message: "User successfully created!" });
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },

  loginUser: async (req, res) => {
    const emailRegex =
      /^([A-Z0-9_+-]+\.?)*[A-Z0-9_+-]@([A-Z0-9][A-Z0-9-]*\.)+[A-Z]{2,}$/i;
    if (!emailRegex.test(req.body.email)) {
      return res
        .status(400)
        .json({ status: false, message: "Email is not valid!" });
    }

    const minPasswordLenght = 8;
    if (req.body.password < minPasswordLenght) {
      return res.status(400).json({
        status: false,
        message:
          "Password should be at least" +
          minPasswordLenght +
          "characters long!",
      });
    }

    try {
      const user = await User.findOne({ email: req.body.email });

      if (!user) {
        return res
          .status(400)
          .json({ status: false, message: "User not found!" });
      }

      const decryptedPassword = CryptoJS.AES.decrypt(
        user.password,
        process.env.SECRET
      );

      const depassword = decryptedPassword.toString(CryptoJS.enc.Utf8);

      if (depassword !== req.body.password) {
        return res
          .status(400)
          .json({ status: false, message: "Wrong password!" });
      }
      const userToken = jwt.sign(
        {
          id: user._id,
          userType: user.userType,
          email: user.email,
        },
        process.env.JWT_SECRET,
        { expiresIn: "21d" }
      );

      const { password, createAt, updateAt, __v, otp, ...others } = user._doc;
      res.status(200).json({ ...others, userToken });
    } catch (error) {
      res.status(500).json({ status: false, message: error.message });
    }
  },
};
