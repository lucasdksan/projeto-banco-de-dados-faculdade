import { Request, Response } from 'express';
import db from '../database/connection';
import reuse_view from '../views/reuse_view';
import Compare from '../utils/Comparing';
import food_view from '../views/food_view';
import ingredients_view from '../views/ingredients_view';
import plus_view from '../views/plus_view';

export default class SearchController {
    async revenue(req: Request, res: Response){
        const { user_id, rec_id } = req.body;
        const trx = await db.transaction();

        const userVerify = await Compare('usuario', 'ID', user_id);
        const searchVerify =  await Compare('receita', 'ID_receita', rec_id);

        console.log({user: userVerify, search: searchVerify})

        if(!userVerify && !searchVerify){
            return res.status(400).json({error: 'User or Search not exists'});
        }

        try{
            await trx('pesquisa_rec').insert({
                ID_user_rec: user_id,
                ID_rec: rec_id
            });
            await trx.commit();
            return res.json({message: 'Registration done successfully'});
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Registration failed'});
        }

    }

    async reuse(req: Request, res: Response){
        const { user_id, reu_id } = req.body;
        const trx = await db.transaction();

        const userVerify = await Compare('usuario', 'ID', user_id);
        const searchVerify =  await Compare('reutilizacao', 'ID_reutiliza', reu_id);

        console.log({user: userVerify, search: searchVerify})

        if(!userVerify && !searchVerify){
            return res.status(400).json({error: 'User or Search not exists'});
        }

        try{
            await trx('pesquisa_reu').insert({
                ID_user_reu: user_id,
                ID_reu: reu_id
            });
            await trx.commit();
            return res.json({message: 'Registration done successfully'});
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Registration failed'});
        }

    }

    async act(req: Request, res: Response){
        const { al_id, rec_id } = req.body;
        const trx = await db.transaction();

        const alVerify = await Compare('alimento', 'ID_alimento', al_id);
        const searchVerify =  await Compare('receita', 'ID_receita', rec_id);

        console.log({al: alVerify, search: searchVerify})

        if(!alVerify && !searchVerify){
            return res.status(400).json({error: 'Food or recipe does not exist'});
        }

        try{
            await trx('atua_em').insert({
                ID_al: al_id,
                ID_rec_atua: rec_id
            });
            await trx.commit();
            return res.json({message: 'Registration done successfully'});
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Registration failed'});
        }

    }

    async searchReuse(req: Request, res: Response){
        const filter = req.query;
        const name = filter.name as string;
        const tableReuse = await db('reutilizacao');

        try{
            function searchName(value:string){
                return value === name;
            }
    
            const result = tableReuse.map(item => {
                let nameItem = item.nome_reutilizacao as string;
                const nameFat = nameItem.split(' ');
                const cond = nameFat.find(searchName);
                if(cond){
                    return item;
                } else {
                    return ;
                }
            })
    
            const finalResult = result.filter(function (i) {
                return i;
              });
    
            return res.json(reuse_view.renderMany(finalResult));
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Search not found'});
        }
    }

    async searchReuseAll(req: Request, res: Response){
        const tableReuse = await db('reutilizacao');

        try{
            return res.json(reuse_view.renderMany(tableReuse));
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Search not found'});
        }
    }

    async searchFood(req: Request, res: Response){
        const filter = req.query;
        const name = filter.name as string;
        const tableReuse = await db('alimento');

        try{
            function searchName(value:string){
                return value === name;
            }
    
            const result = tableReuse.map(item => {
                let nameItem = item.nome_alimento as string;
                const nameFat = nameItem.split(' ');
                const cond = nameFat.find(searchName);
                if(cond){
                    return item;
                } else {
                    return ;
                }
            })
    
            const finalResult = result.filter(function (i) {
                return i;
              });
    
            return res.json(food_view.renderMany(finalResult));
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Search not found'});
        }
    }

    async searchFoodAll(req: Request, res: Response){
        const tableReuse = await db('alimento');

        try{
            return res.json(food_view.renderMany(tableReuse));
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Search not found'});
        }
    }

    async searchRevenue(req: Request, res: Response){
        const filter = req.query;
        const name = filter.name as string;
        const tableReuse = await db('receita');
        const Ingr = await db('receita_ingrediente');

        try{
            function searchName(value:string){
                return value === name;
            }
    
            const result = tableReuse.map(item => {
                let nameItem = item.nome_receita as string;
                const nameFat = nameItem.split(' ');
                const cond = nameFat.find(searchName);
                if(cond){
                    const ingredients = Ingr.map(items=> {
                        if(items.R_ID === item.ID_receita){
                            return items
                        } else {
                            return ;
                        }
                    });
                    const finalIngredients = ingredients.filter(function (i) {
                        return i;
                    });
                    
                    const revenues = ingredients_view.render(item);
                    const ingrs = plus_view.renderMany(finalIngredients);
                    return { revenues, ingrs };
                } else {
                    return ;
                }
            })
    
            const finalResult = result.filter(function (i) {
                return i;
            });
    
            return res.json(finalResult);
        } catch(err){
            console.log(err);
            return res.status(400).json({error: 'Search not found'});
        }
    }
    
};