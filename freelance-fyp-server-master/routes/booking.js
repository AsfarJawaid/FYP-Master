const express = require("express");
const { check, validationResult } = require("express-validator");
const router = express.Router();
const Booking = require("../models/booking");
const Worker = require("../models/worker");
const auth = require("../middleware/auth");
const Feedback = require("../models/feedback");
const Notifications = require("../models/notification");
const { compareSync } = require("bcryptjs");

const client = require("twilio")(
  "ACeb4286c376ef472f6111e70722e4ecaa",
  "5c3ab726eeaff185869192b441c195f0"
);

function SendSms(phone_number) {
  console.log(phone_number);
  try {
    client.messages
      .create({
        from: "+12673290739",
        to: "011923330387860",
        body: "You just sent an SMS from Node.js using Twilio!",
      })
      .then((messsage) => console.log(messsage.sid));
  } catch (e) {
    console.log(e);
  }
}

router.get("/", async (req, res) => res.send("User , route"));

router.post(
  "/book",
  // auth,
  [
    check("worker_id", "worker_id is required").not().isEmpty(),
    check("client_id", "client_id is required").not().isEmpty(),
  ],

  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ success: false, error: errors.array() });
    }
    try {
      var book = new Booking({
        Client: req.body.client_id,
        Worker: req.body.worker_id,
        status_val: "pending",
        status: "new",
        booking_task: req.body.booking_task,
      });
      var notify = new Notifications({
        client: req.body.client_id,
        worker: req.body.worker_id,
        text: "You have a new booking",
        rating: "0",
      });
      await notify.save();
      await book.save();
      return res.json({
        booking: book,
      });
    } catch (err) {
      return res.status(500).json({ success: false, error: err });
    }
  }
);

router.put("/book/completed/:id", async (req, res) => {
  try {
    var feedback = new Feedback({
      client: req.body.client,
      worker: req.body.worker,
      feedback: req.body.feedback,
      rating: req.body.rating,
      booking: req.body.booking,
    });
    await feedback.save();
    let worker = await Worker.findById(req.body.worker);
    worker.rating = (
      parseFloat(worker.rating) +
      (parseFloat(req.body.rating) / 5) * 0.1
    ).toString();
    await worker.save();
    var notify = new Notifications({
      client: req.body.client,
      worker: req.body.worker,
      text:
        "Good job your work have been marked completed and rated  " +
        req.body.rating.toString(),
      rating: req.body.rating.toString(),
    });
    await notify.save();
    let book = await Booking.findById(req.params.id);
    book.status = "old";
    book.save();
    if (book) {
      return res.json({
        success: true,
        Booking: "COMPLETED BOOKING",
        feed: feedback,
      });
    } else {
      return res.status(404).json({ success: false, error: "book Not Found" });
    }
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/history/:id", async (req, res) => {
  try {
    let book = await Booking.find({ status: "old", Worker: req.params.id })
      .populate("Client")
      .populate("Worker");

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/history", async (req, res) => {
  try {
    let book = await Booking.find({ status: "old" })
      .populate("Client")
      .populate("Worker");

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/:id", async (req, res) => {
  try {
    let book = await Booking.findById(req.params.id);
    if (book) {
      return res.json({
        success: true,
        Booking: book,
      });
    } else {
      return res.status(404).json({ success: false, error: "book Not Found" });
    }
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book", async (req, res) => {
  try {
    let book = await Booking.find()
      .populate("Client")
      .populate("Worker")
      .exec();
    SendSms("011923330387860");
    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/client/:id", async (req, res) => {
  try {
    let book = await Booking.find({ Client: req.params.id, status: "new" })
      .populate("Client")
      .populate("Worker")
      .exec();

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/client/delete/:id", async (req, res) => {
  try {
    let book = await Booking.findByIdAndDelete(req.params.id);

    return res.json({
      success: true,
      msg: "Deleted ",
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/worker/:id", async (req, res) => {
  try {
    let book = await Booking.find({ status: "new", Worker: req.params.id })
      .populate("Client")
      .populate("Worker")
      .exec();

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});
router.delete("/book/worker/:id", async (req, res) => {
  try {
    let deletedBooking = await Booking.findByIdAndDelete(req.params.id);

    if (!deletedBooking) {
      console.log('Hello');
      return res.status(404).json({
        success: false,
        error: "Booking not found",
      });
    }
    console.log('found And Deleted');
    return res.json({ 
      success: true,
      deletedBooking,
    });
  } catch (err) {
    return res.status(500).json({
      success: false,
      error: err.message,
    });
  }
});
router.get("/book/client/pending/:id", async (req, res) => {
  try {
    let book = await Booking.find({
      status: "new",
      Client: req.params.id,
      status_val: "pending",
    })
      .populate("Client")
      .populate("Worker")
      .exec();

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/client/confirm/:id", async (req, res) => {
  try {
    let book = await Booking.find({
      status: "new",
      Client: req.params.id,
      status_val: "confirm",
    })
      .populate("Client")
      .populate("Worker")
      .exec();

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/client/confirm/all/admin", async (req, res) => {
  try {
    let book = await Booking.find({
      status: "new",
      status_val: "confirm",
    })
      .populate("Client")
      .populate("Worker")
      .exec();

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/client/pending/all/admin", async (req, res) => {
  try {
    let book = await Booking.find({
      status: "new",
      status_val: "pending",
    })
      .populate("Client")
      .populate("Worker")
      .exec();

    return res.json({
      success: true,
      Booking: book,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.put("/book/client/set-confirm/:id", async (req, res) => {
  try {
    let book = await Booking.findById(req.params.id);
    book.status_val = "confirm";
    await book.save();

    return res.json({
      success: true,
      msg: "Confirm",
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

router.get("/book/worker/notification/:id", async (req, res) => {
  try {
    let notify = await Notifications.find({ worker: req.params.id })
      .populate("client")
      .populate("worker")
      .exec();

    return res.json({
      success: true,
      notify: notify,
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
});

module.exports = router;
