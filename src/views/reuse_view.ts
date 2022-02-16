interface ReuseProps{
    ID_reutiliza: number,
    ID_alim: number,
	nome_reutilizacao: string,
	descricao: string
}

export default {
    render(reuse: ReuseProps){
        return {
            id: reuse.ID_reutiliza,
            id_a: reuse.ID_alim,
            name: reuse.nome_reutilizacao,
            description: reuse.descricao
        }
    },
    renderMany(reuses: ReuseProps[]){
        return reuses.map(reuse => this.render(reuse));
    }
}