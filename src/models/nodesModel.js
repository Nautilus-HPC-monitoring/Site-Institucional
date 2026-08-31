var database = require("../database/config");

function chamarHPC(nome,empresa_fk){
     var instrucaoSql = `SELECT ambiente_hpc.nome,
        ambiente_hpc.empresa_fk 
        from ambiente_hpc 
        join empresa on 
        empresa.id = ambiente_hpc.empresa_fk `;
         return database.executar(instrucaoSql);
}

function chamarCluster(nome,ambiente_hpc_fk){
     var instrucaoSql = `SELECT cluster.nome,
        cluster.ambiente_hpc_fk 
        from cluster join ambiente_hpc on 
        ambiente_hpc.id_ambiente_hpc = cluster.ambiente_hpc_fk`;
         return database.executar(instrucaoSql);
}


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
    cadastrar,
    chamarHPC
};
