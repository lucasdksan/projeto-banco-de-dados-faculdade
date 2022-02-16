interface FoodProps{
    ID_alimento: number,
	nome_alimento: string,
    nutrientes: string,
    calorias: string,
    gluten: string
}

export default {
    render(food: FoodProps){
        return {
            id: food.ID_alimento,
            name: food.nome_alimento,
            nutrients: food.nutrientes, 
            calories: food.calorias, 
            gluten: food.gluten
        }
    },
    renderMany(foods: FoodProps[]){
        return foods.map(food => this.render(food));
    }
}