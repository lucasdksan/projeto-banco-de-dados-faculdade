import express, { Request, Response } from 'express';
import AuthController from './controllers/authController';
import SearchController from './controllers/searchController';
import FoodController from './controllers/foodController';
import UserController from './controllers/userController';

const routes = express.Router();

const authcontroller = new AuthController();
const searchcontroller = new SearchController();
const foodcontroller = new FoodController();
const usercontroller = new UserController();

routes.get('/test', (req: Request, res: Response)=>{
    return res.send('Deu certo');
});

routes.post('/authenticate', authcontroller.authenticate);
routes.post('/register', authcontroller.create);
routes.post('/register/food', foodcontroller.createFood);
routes.post('/register/revenue-create', foodcontroller.createRevenue);
routes.post('/register/ingredient', foodcontroller.createIngredientRecipe);
routes.post('/register/revenue', searchcontroller.revenue);
routes.post('/register/reuse', searchcontroller.reuse);
routes.post('/register/act', searchcontroller.act);

routes.get('/show_users', usercontroller.show);
routes.get('/search_user', usercontroller.index);
routes.get('/search_reuse', searchcontroller.searchReuse);
routes.get('/search_food', searchcontroller.searchFood);
routes.get('/search_revenue', searchcontroller.searchRevenue);
routes.get('/search_reuse_all', searchcontroller.searchReuseAll);
routes.get('/search_food_all', searchcontroller.searchFoodAll);

export default routes;