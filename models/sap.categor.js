module.exports = {
  SAP_CATEGORIY: `SELECT sap_category.* FROM sap_category JOIN categories ON sap_category.catRefid = categories.catId WHERE categories.catName = $1;`,
  SAPALL: 'SELECT * FROM sap_category',
}
