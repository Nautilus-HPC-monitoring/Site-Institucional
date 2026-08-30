var nodesModel = require("../models/nodesModel");

function cadastrar(req, res) {

    var hostname = req.body.hostnameServer;
    var ip = req.body.ipServer;
    var status = req.body.statusServer;
    var sistemaOperacional = req.body.sistemaOperacionalServer;
    var clusterFk = req.body.clusterFkServer;

     if (hostname == undefined) {

        res.status(400).send("Hostname está undefined!");

    } else if (ip == undefined) {

        res.status(400).send("IP está undefined!");

    } else if (status == undefined) {

        res.status(400).send("Status está undefined!");

    } else if (sistemaOperacional == undefined) {

        res.status(400).send("Sistema operacional está undefined!");

    } else if (clusterFk == undefined) {

        res.status(400).send("Cluster está undefined!");

    } else {

        nodesModel.cadastrar(
            hostname,
            ip,
            status,
            sistemaOperacional,
            clusterFk
        )
        .then(function(resultado) {

            res.json(resultado);

        })

        .catch(function(erro) {
        res.status(500).json(erro.sqlMessage);
        });
        }
        module.exports = {
    cadastrar}

}
