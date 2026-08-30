var database = require("../database/config");

function cadastrar(hostname, ip, status, sistemaOperacional, clusterFk){
     var instrucaoSql = `
        INSERT INTO node
        (hostname, ip, status, sistema_operacional, cluster_fk)
        VALUES
        ('${hostname}', '${ip}', '${status}', '${sistemaOperacional}', ${clusterFk});
    `;

    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrar
};
