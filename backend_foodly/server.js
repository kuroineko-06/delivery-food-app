const express = require("express");
require("dotenv").config();
const app = express();
const port = process.env.PORT || 3000;
const categoryRouter = require("./routes/category");
const foodRouter = require("./routes/food");
const ratingRouter = require("./routes/rating");
const restaurantRouter = require("./routes/restaurant");
const authRouter = require("./routes/auth");
const userRouter = require("./routes/user");
const addressRouter = require("./routes/address");
const cartRouter = require("./routes/cart");
const orderRouter = require("./routes/order");
const paymentRouter = require("./routes/payment_method");
const http = require("http");
const ngrok = require("@ngrok/ngrok");

const cors = require("cors");
app.use(cors());

const mongoose = require("mongoose");

mongoose
  .connect(process.env.MONGO_URL)
  .then(() => console.log("Foodly Database Connected"))
  .catch((err) => console.log(err));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/", authRouter);
app.use("/api/users", userRouter);

app.use("/api/category", categoryRouter);
app.use("/api/restaurant", restaurantRouter);
app.use("/api/foods", foodRouter);
app.use("/api/rating", ratingRouter);
app.use("/api/address", addressRouter);
app.use("/api/cart", cartRouter);
app.use("/api/orders", orderRouter);
app.use("/api/payment", paymentRouter);

app.listen(port, () => console.log(`Server running on port: ${port}`));
