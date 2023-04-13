const { fetch, fetchAll } = require("../database/pg");
const { SELECTALL } = require("../models/users.model");
const {
  SAP_CATEGORIY
} = require("../models/sap.categor");
const {
  VIDEOID,
  VIDEOTITLE,
  
} = require("../models/video.model");

module.exports = {
  GET: async (req, res) => {
    if (req.params.videoId) {
      res.send({
        data: await fetch(VIDEOID, req.params.title, req.params.videoId),
      });
    } else if (req.params.title) {
      res.send({
        data: await fetch(VIDEOTITLE, req.params.id, req.params.title),
      });
    } else if (req.params.id) {
      res.send({
        data: await fetch(SAP_CATEGORIY, req.params.id),
      });
    } else {
      res.send({
        data: await fetchAll(SELECTALL),
      });
    }
  },
  POST: async (req, res) => {},
};
