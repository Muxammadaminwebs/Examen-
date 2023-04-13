
CREATE Table users (
    id VARCHAR (36) DEFAULT uuid_generate_v4() PRIMARY KEY,
    username VARCHAR(25) NOT NULL,
    login VARCHAR(128) NOT NULL UNIQUE,
    password VARCHAR(64) not NULL REFERENCES
);


INSERT INTO users (username, login, password)VALUES
('Ali','ali@erjtn','ladkjgladjfgkjdfkgjdajg326dg'),
('sdffkn','ali@e156','ladkjgladjfgkjdfkgjdajg326dg');


 create table videos (
 video_id serial primary key,
 user_id varchar(36) REFERENCES users(id),
 title varchar(128) not null,
 path varchar(128) not null,
 add_date date default current_timestamp);








 -- create users table

CREATE TABLE users (
  userId serial primary KEY,
  username VARCHAR(150) NOT NULL,
  login VARCHAR(150) UNIQUE NOT NULL,
  password VARCHAR(150) NOT NULL
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
  catName VARCHAR(50) NOT NULL
);

INSERT INTO categories (catName) VALUES ('dasturlash'), ('marketing'), ('dizayn');

-- sap category

CREATE TABLE sap_category (
  sapId Serial primary key,
  sapName VARCHAR(50) NOT NULL,
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
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  categoryId INT NOT NULL,
  sapId BIGINT NOT NULL,
  path varchar(200),
  FOREIGN KEY (sapId) REFERENCES sap_category(sapId),
  FOREIGN KEY (categoryId) REFERENCES categories(catId),
  FOREIGN KEY (userId) REFERENCES users(userId)
);

INSERT INTO videos (userId, title, categoryId, sapId , path) VALUES
  (1, 'Video title1',  1, 3 ,'Salom dunyo degan video 1');
  (2, 'Video title2',  2, 1 ,'Salom dunyo degan video 2' ),
  (3, 'Video title3',  3, 1  ,'Salom dunyo degan video 3'),
  (4, 'Video title4',  1, 4  ,'Salom dunyo degan video 4'),
  (5, 'Video title5',  2, 5  ,'Salom dunyo degan video 5'),
  (6, 'Video title6',  3, 6  ,'Salom dunyo degan video 6'),
  (7, 'Video title7',  2, 7  ,'Salom dunyo degan video 7'),
  (8, 'Video title8',  3, 2  ,'Salom dunyo degan video 8'),
  (9, 'Video title9',  1, 2  ,'Salom dunyo degan video 9');



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

INSERT INTO comments (userId, videoId, comment) VALUES
  (26, 16, 'edvbuiqeviqfvjavb ervbevbiefbvebsdvasvbvsadbfncxvabkjvxc bb vmd j  ds bm     jef  mn jbmlzffbjgbermmnmmju');