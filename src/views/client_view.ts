interface ClientProps{
    id: number;
    nome: string;
    email: string;
    senha: string;
}

export default {
    render(client: ClientProps){
        return {
            id: client.id,
            name: client.nome,
            email: client.email
        }
    },
    renderMany(clients: ClientProps[]){
        return clients.map(client => this.render(client));
    }
}