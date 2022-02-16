interface IngrsProps{
    R_ID: number,
    ingrediente: string
}

export default {
    render(ingr: IngrsProps){
        return {
            ingredient: ingr.ingrediente,
        }
    },
    renderMany(ingrs: IngrsProps[]){
        return ingrs.map(ingr => this.render(ingr));
    }
}