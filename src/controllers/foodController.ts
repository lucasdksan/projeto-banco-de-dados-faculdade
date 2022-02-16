import { Request, Response } from 'express';
import db from '../database/connection';
import Compare from '../utils/Comparing';

export default class FoodController {
    async createFood(req: Request, res: Response){
        const { name, nutrients, calories, gluten } = req.body;

        const trx = await db.transaction();

        function handleGluten(value:boolean){
            if(value){
                return "S"
            } else {
                return "N"
            }
        }

        if(await Compare('alimento', 'nome_alimento', String(name))){
            return res.status(400).json({error: 'Food already exists'});
        }

        try{
            await trx('alimento').insert({
                    nome_alimento: name,
                    nutrientes: nutrients,
                    calorias: calories,
                    gluten: handleGluten(gluten)
                });
            await trx.commit();
            return res.json({message: 'food successfully created'});
        } catch (err){
            console.log(err);
            return res.status(400).json({error: 'Registration failed'});
        }
    }

    async createRevenue(req: Request, res: Response){
        const { name, method_preparation } = req.body;

        const trx = await db.transaction();

        if(await Compare('receita', 'nome_receita', String(name))){
            return res.status(400).json({error: 'Revenue already exists'});
        }

        try{
            await trx('receita').insert({
                    nome_receita: name,
                    modo_preparo: method_preparation
                });
            await trx.commit();
            return res.json({message: 'revenue successfully created'});
        } catch (err){
            console.log(err);
            return res.status(400).json({error: 'Registration failed'});
        }
    }

    async createIngredientRecipe(req: Request, res: Response){
        const { r_id, ingredient } = req.body;

        const trx = await db.transaction();

        try{
            await trx('receita_ingrediente').insert({
                    R_ID: r_id,
                    ingrediente: ingredient
                });
            await trx.commit();
            return res.json({message: 'ingredient successfully created'});
        } catch (err){
            console.log(err);
            return res.status(400).json({error: 'Registration failed'});
        }
    }
};