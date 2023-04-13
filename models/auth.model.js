module.exports = {
  REGIST:
    "INSERT INTO users (username, login, password) VALUES ($1,$2,$3) RETURNING *",
  LOGIN: "SELECT userId FROM users WHERE login = $1 and password = $2",
  INSERTV:
    "INSERT INTO videos (userid, title, path , categoryId , sapId ) VALUES ($1,$2,$3 , $4,$5) RETURNING userid",
  POSTCOMMENT: "INSERT INTO comments (userid, videoId, comment) VALUES ($1,$2,$3) RETURNING *",
  PUT: "UPDATE videos SET path = $1, title = $2, categoryId = $3, sapId = $4 WHERE videoId=$5 and userid = $6",
  VIDEODELETE: "DELETE FROM videos WHERE userid=$1 and videoId =$2 RETURNING *",
  COMDELETE: "DELETE FROM comments WHERE userid=$1 and commentId =$2 RETURNING *",
};
