module.exports = {
    client: 'mysql', // Nome do banco de dados que você vai utilizar.
    connection:{
        host : '127.0.0.1', // Host, no meu caso localhost.
        user : 'root', // Nome do user que contém o banco de dados.
        password : '123456789', // Senha para acessar;
        database : 'lifoo', // Nome do banco de dados.
        port : 3305
    },
    useNullAsDefault: true,
};