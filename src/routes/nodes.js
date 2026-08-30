var express = require("express");

var router = express.Router();

var nodesController = require("../controllers/nodesController");

router.post("/cadastrar", function(req, res) {

    nodesController.cadastrar(req, res);

});

module.exports = router;