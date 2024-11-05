const paypal = require("paypal-rest-sdk");
const Order = require("../models/order");
const User = require("../models/user");
// const { PAYPAL_MODE, PAYPAL_CLIENT_ID, PAYPAL_SECRET_KEY } = process.env;

paypal.configure({
  mode: process.env.PAYPAL_MODE,
  client_id: process.env.PAYPAL_CLIENT_ID,
  client_secret: process.env.PAYPAL_SECRET_KEY,
});

module.exports = {
  createPaymentMethod: async (req, res) => {
    const amount = req.query.amount;
    const currency = req.query.currency.toUpperCase();

    console.log(amount), console.log(currency);

    const create_payment_json = {
      intent: "sale",
      payer: {
        payment_method: "paypal",
      },
      redirect_urls: {
        return_url: `https://1589-2402-9d80-24c-9e1d-641e-7135-f2d2-e637.ngrok-free.app/api/payment/execute?amount=${amount}&currency=${currency}`,
        cancel_url: "http://localhost:8000/cancel",
      },
      transactions: [
        {
          item_list: {
            items: [
              {
                name: "test product",
                sku: "001",
                price: amount,
                currency: currency,
                quantity: 1,
              },
            ],
          },
          amount: {
            currency: currency,
            total: amount,
          },
          description: "Iphone 5s",
        },
      ],
    };
    paypal.payment.create(create_payment_json, function (error, payment) {
      if (error) {
        throw error;
      } else {
        console.log("Create payment response");
        console.log(payment);

        for (let i = 0; i < payment.links.length; i++) {
          if (payment.links[i].rel === "approval_url") {
            res.redirect(payment.links[i].href);
          }
        }
      }
    });
  },

  Execute: async (req, res) => {
    const amount = req.query.amount;
    const currency = req.query.currency.toUpperCase();

    var execute_payment_json = {
      payer_id: req.query.PayerID,
      transactions: [
        {
          amount: {
            currency: currency,
            total: amount,
          },
        },
      ],
    };

    const paymentId = req.query.paymentId;
    paypal.payment.execute(
      paymentId,
      execute_payment_json,
      function (error, payment) {
        if (error) {
          console.log(error);
          throw error;
        } else {
          console.log(JSON.stringify(payment));
          res.redirect(
            "http://return_url/?status=success&id=" +
              payment.id +
              "&state=" +
              payment.state
          );
        }
      }
    );
  },
};
