const { Router } = require("express");
const { GET } = require("../controller/users");
// const { REG } = require("../controller/auth");


const users = Router();

users.get('/categories', GET)
users.get('/categories/:id', GET)
users.get('/categories/:id/:title', GET)
users.get('/categories/:id/:title/:videoId', GET)


module.exports = { users };
