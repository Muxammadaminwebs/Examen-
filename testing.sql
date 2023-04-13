-- create users table

CREATE TABLE users (
  userId serial primary KEY,
  username VARCHAR(100) NOT NULL,
  login VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL
);
INSERT INTO users (username, login, password) VALUES
  ('username1', 'emaile1@gmail.com', 'password1'),
  ('username2', 'emaile2@gmail.com', 'password2'),
  ('username3', 'emaile3@gmail.com', 'password3'),
  ('username4', 'emaile4@gmail.com', 'password4'),
  ('username5', 'emaile5@gmail.com', 'password5'),
  ('username6', 'emaile6@gmail.com', 'password6'),
  ('username7', 'emaile7@gmail.com', 'password7'),
  ('username8', 'emaile9@gmail.com', 'password8'),
  ('username9', 'emaile10@gmail.com', 'password9');

-- category create
CREATE TABLE categories (
  catId serial PRIMARY KEY,
  catName VARCHAR(100) NOT NULL
);

INSERT INTO categories (catName) VALUES ('dasturlash'), ('marketing'), ('dizayn');

-- sap category

CREATE TABLE sap_category (
  sapId Serial primary key,
  sapName VARCHAR(100) NOT NULL,
  catRefId INT NOT NULL,
  FOREIGN KEY (catRefId) REFERENCES categories(catId)
);

INSERT INTO sap_category
    (sapName, catRefId)
VALUES
    ('python', 1),
    ('java', 1),
    ('nodejs', 1),
    ('.net', 1),
    ('go', 1),
    ('smm', 2),
    ('brand', 2),
    ('logo', 3),
    ('grafika', 3),
    ('interyer', 3),
    ('muqova', 3);


-- videos create table;

CREATE TABLE videos (
  videoId serial primary KEY,
  userId BIGINT NOT NULL,
  title VARCHAR(100) NOT NULL,
  path VARCHAR(200) NOT NULL
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  categoryId INT NOT NULL,
  sapId BIGINT NOT NULL,
  FOREIGN KEY (sapId) REFERENCES sap_category(sapId),
  FOREIGN KEY (categoryId) REFERENCES categories(catId),
  FOREIGN KEY (userId) REFERENCES users(userId)
);

INSERT INTO videos (userId, title, categoryId, sapId) VALUES
  (1, 'Video title1',  1, 3),
  (2, 'Video title2',  2, 1),
  (3, 'Video title3',  3, 1),
  (4, 'Video title4',  1, 4),
  (5, 'Video title5',  2, 5),
  (6, 'Video title6',  3, 6),
  (7, 'Video title7',  2, 7),
  (8, 'Video title8',  3, 2),
  (9, 'Video title9',  1, 2);



-- create comments table

CREATE TABLE comments (
  commentId serial primary KEY,
  userId INT NOT NULL,
  videoId INT NOT NULL,
  comment TEXT NOT NULL,
  FOREIGN KEY (userId) REFERENCES users(userId),
  FOREIGN KEY (videoId) REFERENCES videos(videoId)
);


INSERT INTO comments (userId, videoId, comment) VALUES
  (1, 1, 'Great tutorial, thanks for sharing!'),
  (2, 1, 'This was really helpful, thank you!'),
  (3, 1, 'I had been struggling with this topic but your video made it clear.'),
  (4, 2, 'Interesting points, but I think there are some other strategies worth considering.'),
  (5, 2, 'Thanks for the tips, I will definitely try them out.'),
  (6, 3, 'I really enjoyed this video, it was very informative.'),
  (7, 3, 'Can you recommend any additional resources for learning more about this topic?'),
  (8, 4, 'I loved your approach to teaching Python, it made the language seem less intimidating.'),
  (9, 5, 'This was a great overview of the design principles, thank you!');


UPDATE videos
SET userId = $1, title = $2, categoryId = $3, sapId = $4  WHERE userId = $5;


PUT: async (req, res) => {
    try {
      let { file } = req.files;
      let { token } = req.headers;
      let { title, categoryId, sapId } = req.body;
      let types = file.name.split(".");
      let type = types[types.length - 1];
      const random = Math.floor(Math.random() * 9000 + 1000);
      const { userid } = VERIFY(token);

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
            PUTVIDEO,
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
      res.send({ status: 404, message: error.message });
    }
  },