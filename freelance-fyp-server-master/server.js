const express = require("express");
const connectDB = require("./config/db");
var bodyParser = require("body-parser");
const passport = require("passport");
var cors = require("cors");

const app = express();

// Passport config
app.use(passport.initialize());
app.use(passport.session());
require("./middleware/passport")(passport);

// connect database
connectDB();

// Init Middleware
app.use(bodyParser.json({ limit: "50mb" }));
app.get("/", (req, res) => res.send("API Running"));
app.use(cors());

//Routes;
app.use("/worker", require("./routes/worker"));
app.use("/client", require("./routes/client"));
app.use("/login", require("./routes/login"));
app.use("/booking", require("./routes/booking"));
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
});
