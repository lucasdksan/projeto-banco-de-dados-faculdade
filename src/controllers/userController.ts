import { Request, Response } from 'express';
import db from '../database/connection';
import Compare from '../utils/Comparing';
import client_view from '../views/client_view';

export default class UserController {
    async index(req: Request, res: Response){
        const filter = req.query;
        const name = filter.name as string;
        if(!filter.name){
            return res.status(400).json({error: 'Missing filters to search Client.'});
        }
        if(!await Compare('usuario', 'nome', name)){
            return res.status(400).json({error: 'User not Exists.'});
        }
        const Client = await db('usuario').where('usuario.nome', '=', name).first();
        return res.json(client_view.render(Client));
    }
    async show(req: Request, res: Response){
        try{
            const tableUsers = await db('usuario');
            return res.json(client_view.renderMany(tableUsers));
        } catch(err){
            return res.status(400).json({ error: 'Users show error'});
        }
    }
};