import { Request, Response } from 'express';
import db from '../database/connection';
import Compare from '../utils/Comparing';

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

};