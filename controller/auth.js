const { fetch, fetchAll } = require("../database/pg");
const {
  REGIST,
  LOGIN,
  INSERTV,
  POSTCOMMENT,
  PUT,
  VIDEODELETE,
  COMDELETE
} = require("../models/auth.model");
const { SIGN, VERIFY } = require("../utils/jwt");
const sha256 = require("sha256");
const path = require("path");

module.exports = {
  REG: async (req, res) => {
    try {
      let { username, login, password } = req.body;
      let userId = await fetch(REGIST, username, login, sha256(password));
      console.log(userId);
      res.send({
        status: 200,
        message: "User added!",
        data: { token: SIGN(userId[0]) },
      });
    } catch (error) {
      res.send({ status: 404, message: error.message });
    }
  },
  

  LOG: async (req, res) => {
    try {
      let { login, password } = req.body;
      if (!login || !password) throw new Error("Wrong data!");
      let userId = await fetch(LOGIN, login, sha256(password));
      if (!userId) throw new Error("Not foun user!");
      res.send({
        status: 200,
        message: "Success!",
        data: { token: SIGN(userId[0]) },
      });
    } catch (error) {
      res.send({ status: 404, message: error.message });
    }
  },
  CHECK: (req, res, next) => {
    try {
      if (!VERIFY(req.headers.token)) throw new Error("Invalid token!");
      res.send({
        status: 200,
        message: "Success!",
      });
    } catch (error) {
      res.send({ status: 404, message: error.message });
    }
  },
  UPLOAD: async (req, res) => {
    try {

         let { file } = req.files;
      let {title  , categoryId , sapId } = req.body;
      let { token } = req.headers;
      const {
        userid
      } = VERIFY(token);
      if (!VERIFY(req.headers.token))
        return res.send({
          status: 401,
          message: "you must send max 50 mb file",
        });
      
   
      // console.log(userid);

      if (file.truncated) throw new Error("you must send max 50 mb file");
      let types = file.name.split(".");
      let type = types[types.length - 1];
      if (type != "mp4") throw new Error("Video's type invalid!");
      const random = Math.floor(Math.random() * 9000 + 1000);
      await file.mv(
        path.join(
          process.cwd(),
          "public",
          "videos",
          title + random + "." + type 
        )
      );
      await fetch(INSERTV, userid, title, '/videos/' + title + random + "." + type, categoryId, sapId);
      res.send({ status: 200, message: "Video added!" });
    } catch (err) {
      res.send({ status: 404, message: err.message });
    }
  },

    COMMENT: async (req, res) => {
    try {
      let { token } = req.headers
      let { videoId, comment } = req.body
      const { userid } = VERIFY(token);
   let [{
     videoid
   }] = await fetch(POSTCOMMENT, userid, videoId, comment)
      if (!VERIFY(req.headers.token))
        return res.send({
          status: 401,
          message: 'your token is broken, please try again later.',
        });
      res.send({status: 200, message: `comment of ${videoid} was added succsessfull` })
    } catch (error) {
      res.send({ status: 404, message: error.message })
    }
  },
    PUT: async (req, res) => {
      try {
        let {
          file
        } = req.files;
        let {
          token
        } = req.headers;
        let {
          title,
          categoryId,
          sapId
        } = req.body;
        let types = file.name.split(".");
        let type = types[types.length - 1];
        const random = Math.floor(Math.random() * 9000 + 1000);
        const {
          userid
        } = VERIFY(token);

        if (!VERIFY(req.headers.token)) throw new Error("Invalid token!");
        if (file.truncated) throw new Error("you must send max 50 mb file");
        if (req.params.id) {
          console.log(req.body, userid)
          await file.mv(
            path.join(
              process.cwd(),
              "public",
              "videos",
              title + random + "." + type
            )
          );
          res.send({
            status: 200,
            data: fetch(
              PUT,
              "/videos/" + title + random + "." + type,
              title,
              categoryId,
              sapId,
              req.params.id,
              userid
            ),
            message: "Success",
          });
        }


      } catch (error) {
        res.send({
          status: 404,
          message: error.message
        });
      }
  },
    
    
    DETVID: (req, res) => {
      try {
        let {
          token
        } = req.headers;
        const {
          userid
        } = VERIFY(token);
        if (!VERIFY(req.headers.token)) throw new Error("Invalid token!");
        if (req.params.id) {

          res.send({
            status: 200,
            data: fetch(
              VIDEODELETE,
              userid,
              req.params.id
            ),
            message: "Deleted video",
          });

        }
      } catch (error) {
        res.send({
          status: 404,
          message: error.message
        });
      }
  },
    
        COMDEL: (req, res) => {
          try {
            let {
              token
            } = req.headers;
            const {
              userid
            } = VERIFY(token);
            if (!VERIFY(req.headers.token)) throw new Error("Invalid token!");
            if (req.params.id) {

              res.send({
                status: 200,
                data: fetch(
                  COMDELETE,
                  userid,
                  req.params.id
                ),
                message: "Deleted video",
              });

            }
          } catch (error) {
            res.send({
              status: 404,
              message: error.message
            });
          }
        }

};
