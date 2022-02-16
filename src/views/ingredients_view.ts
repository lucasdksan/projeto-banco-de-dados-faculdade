interface IngrProps{
    ID_receita: number,
    nome_receita: string,
    modo_preparo: string
}

export default {
    render(ingr: IngrProps){
        return {
            id: ingr.ID_receita,
            name: ingr.nome_receita,
            method: ingr.modo_preparo
        }
    },
    renderMany(ingrs: IngrProps[]){
        return ingrs.map(ingr => this.render(ingr));
    }
}