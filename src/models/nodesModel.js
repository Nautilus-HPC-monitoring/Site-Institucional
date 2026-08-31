var database = require("../database/config");

function chamarHPC(nome,fk_empresa){
     var instrucaoSql = `SELECT ambiente_hpc.nome,
        ambiente_hpc.fk_empresa 
        from ambiente_hpc 
        join empresa on 
        empresa.id = ambiente_hpc.fk_empresa 
        where ambiente_hpc.nome = ${nome} and ambiente_hpc.fk_empresa =${fk_empresa}  `;
    
         return database.executar(instrucaoSql);
}

function chamarCluster(nome,ambiente_hpc_fk){
     var instrucaoSql = `SELECT cluster.nome,
        cluster.fk_ambiente_hpc
        from cluster join ambiente_hpc on 
        ambiente_hpc.id_ambiente_hpc = cluster.fk_ambiente_hpc
        where cluster.nome = ${nome} and cluster.ambiente_hpc_fk= ${ambiente_hpc_fk} `;
         return database.executar(instrucaoSql);
}


function cadastrar(hostname, ip, status, sistemaOperacional, clusterFk){
     var instrucaoSql = `
        INSERT INTO node
        (hostname, ip, status, sistema_operacional, fk_cluster)
        VALUES
        ('${hostname}', '${ip}', '${status}', '${sistemaOperacional}', ${clusterFk});
    `;

    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrar,
    chamarHPC,
    chamarCluster
};
