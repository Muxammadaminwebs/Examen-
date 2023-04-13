CREATE TABLE users (
    userId serial PRIMARY KEY,
    login VARCHAR(100),
    username VARCHAR(100),
    password VARCHAR(100)
);

CREATE TABLE categories (
    id serial PRIMARY KEY,
    catName VARCHAR(100)
);

CREATE TABLE sap_category (
    sapId serial PRIMARY KEY,
    sapName VARCHAR(100),
    catRefid INT,
    FOREIGN KEY (catRefid) REFERENCES categories(id)
);

CREATE TABLE videos (
    videoId serial PRIMARY KEY,
    userId VARCHAR(100),
    title VARCHAR(100),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    categoryId INT,
    sapId INT,
    FOREIGN KEY (categoryId) REFERENCES categories(id), 
    FOREIGN KEY (sapId) REFERENCES sap_category(sapId), 
    FOREIGN KEY (userId) REFERENCES users(userId)
);

CREATE TABLE comments (
    commentId serial PRIMARY KEY,
    userId VARCHAR(100),
    videoId INT,
    comment TEXT,
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (videoId) REFERENCES videos(videoId)
);


INSERT INTO users
    (userId, login,username, password)
VALUES
    ('user1', 'ali1','qwerty' ,'password1'),
    ('user2', 'ali22', 'nemo','password2'),
    ('user3', 'ali 22', 'Cola','password3'),
    ('user4', 'esha', 'kia','password4'),
    ('user5', 'taesh', 'champion','password5');

-- cate
INSERT INTO categories
    (catName)
VALUES
    ('dasturlash'),
    ('marketing'),
    ('smm'),
    ('logo'),
    ('test');

-- sap cate

INSERT INTO sap_category
    (sapName, catRefid)
VALUES
    ('python', 1),
    ('javascript', 1),
    ('go', 1),
    ('logo', 2),
    ('interyer', 2),
    ('grafika', 2),
    ('smm', 3),
    ('brand', 3),
    ('blog', 3),
    ('grafika', 4),
    ('smm', 4),
    ('brand', 5),
    ('blog', 5);


INSERT INTO videos
    (userId, title, categoryId, sapId)
VALUES
    ('user1', 'mening titlem', 1, 4),
    ('user2', 'mening titlem', 2, 3),
    ('user3', 'mening titlem', 5, 2),
    ('user4', 'mening titlem', 4, 1),
    ('user5', 'mening titlem', 3, 4),
    ('user1', 'mening titlem', 1, 2);

INSERT INTO comments (userId, videoId, comment) VALUES
('user1', 1, 'bu video zor ekan'),
('user2', 1, 'bu video zor ekan'),
('user3', 3, 'bu video zor ekan'),
('user4', 4, 'bu video zor ekan'),
('user5', 5, 'bu video zor ekan'); 


-- shrift
                                                -- muqova
           
                                                
                                                
                                                -- media










SELECT sap_category.*, videos.*, comments.comment, users.username
 FROM sap_category
 INNER JOIN videos ON sap_category.sapId = videos.sapId
 INNER JOIN comments ON videos.videoId = comments.videoId
 INNER JOIN users ON comments.userId = users.userId
 WHERE sap_category.sapName = 'javascript'
 AND videos.videoId = 6;