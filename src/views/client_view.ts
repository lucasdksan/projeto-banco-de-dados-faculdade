interface ClientProps{
    ID: number;
    nome: string;
    email: string;
    senha: string;
}

export default {
    render(client: ClientProps){
        return {
            id: client.ID,
            name: client.nome,
            email: client.email
        }
    },
    renderMany(clients: ClientProps[]){
        return clients.map(client => this.render(client));
    }
}