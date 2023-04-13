module.exports = {
  VIDEOS: `SELECT videos.* FROM videos
INNER JOIN sap_category ON videos.sapId = sap_category.sapId
WHERE sap_category.sapName = $1;`,

  VIDEOID: `SELECT *
  FROM sap_category
  INNER JOIN videos ON sap_category.sapId = videos.categoryId
  INNER JOIN comments ON videos.videoId = comments.videoId
  INNER JOIN users ON comments.userId = users.userId
  WHERE sap_category.sapName = $1
  AND videos.videoId = $2`,
  
 VIDEOTITLE:`SELECT *
  FROM categories
  JOIN sap_category ON categories.catId = sap_category.catRefId
  JOIN videos ON sap_category.sapId = videos.sapId
  WHERE categories.catName = $1 AND sap_category.sapName = $2`,
};
