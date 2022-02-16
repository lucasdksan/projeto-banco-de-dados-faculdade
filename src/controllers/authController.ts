import { Request, Response } from 'express';
import BycriptPassword from '../utils/Bycript';
import db from '../database/connection';
import GenerateToken from '../utils/TokenGenerate';
import Compare from '../utils/Comparing';
import clientView from '../views/client_view';

export default class AuthController{
    async create(req: Request, res: Response){
        const bycript = new BycriptPassword();
        const { name, email, password } = req.body;
        const newpassword = await bycript.crypt(password);
        const trx = await db.transaction();

        if(await Compare('usuario', 'nome', String(name))){
            return res.status(400).json({error: 'User already exists'});
        }
        
        try{
            await trx('usuario').insert({
                    nome: name,
                    senha: newpassword,
                    email
                });
            await trx.commit();
            return res.json({message: 'user account successfully created'});
        } catch (err){
            console.log(err);
            return res.status(400).json({error: 'Registration failed'});
        }
    }
    async authenticate(req: Request, res: Response){
        const bycript = new BycriptPassword();
        const {email, password} = req.body;
        try{
            const user = await db('usuario').where('usuario.email', '=', String(email)).first();
            const find = await bycript.comparePassword(password, user.senha);
            const clientUser = clientView.render(user);
            if(find){
                return res.json({clientUser, token: GenerateToken(user.id)});
            } else{
                return res.status(400).json({error: 'Invalid password'});
            }
        }catch(err){
            console.log(err);
            return res.status(400).json({error: 'User not found'});
        }
    }
}