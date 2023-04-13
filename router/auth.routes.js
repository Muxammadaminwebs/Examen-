const { Router } = require("express");
const {
    REG,
    LOG,
    CHECK,
    UPLOAD,
    COMMENT,
    PUT,
    DETVID,
    COMDEL
} = require("../controller/auth.js");

const auth = Router();

auth.post("/register", REG);
auth.post("/login", LOG);
auth.post("/upload", UPLOAD);
auth.post("/comment", COMMENT);
auth.put("/video/:id", PUT);
auth.delete("/video/:id", DETVID);
auth.delete("/comment/:id", COMDEL);
auth.get("/check", CHECK);
module.exports = { auth };
