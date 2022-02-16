import knex from 'knex';

const db = knex(
    {
        client: 'mysql',
        connection:{
            host : '127.0.0.1',
            user : 'root',
            password : '123456789',
            database : 'lifoo',
            port : 3305   
        },
        useNullAsDefault: true,
    }
);

export default db;