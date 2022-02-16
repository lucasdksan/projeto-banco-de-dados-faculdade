import express, { Request, Response } from 'express';
import AuthController from './controllers/authController';
import SearchController from './controllers/searchController';
import FoodController from './controllers/foodController';

const routes = express.Router();

const authcontroller = new AuthController();
const searchcontroller = new SearchController();
const foodController = new FoodController();

routes.get('/test', (req: Request, res: Response)=>{
    return res.send('Deu certo');
});

routes.post('/authenticate', authcontroller.authenticate);
routes.post('/register', authcontroller.create);
routes.post('/register/food', foodController.createFood);
routes.post('/register/revenue-create', foodController.createRevenue);
routes.post('/register/ingredient', foodController.createIngredientRecipe);
routes.post('/register/revenue', searchcontroller.revenue);
routes.post('/register/reuse', searchcontroller.reuse);
routes.post('/register/act', searchcontroller.act);

export default routes;