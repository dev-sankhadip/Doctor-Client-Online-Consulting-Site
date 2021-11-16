import 'reflect-metadata';
import express, { Express, Router } from 'express'
import cors from 'cors'
import * as dotenv from 'dotenv'
import config from './VO/config';
import Container from 'typedi';
import { MemberRouter, LookupRouter, UserRouter, ClientRouter } from './api/index';
import fileUpload from 'express-fileupload';
import SchedulerRouter from './api/scheduler.routes';


class App {
    private app: Express;
    private router: Router;

    constructor() {
        this.app = express();
        this.router = express.Router();
        this.setMiddleware();
        this.setRoutes();
        this.startApp();
    }

    setMiddleware() {
        this.app.use(cors(config.corsOptions));
        this.app.use(express.json());
        this.app.use(express.urlencoded({ extended: true }));
        this.app.use(fileUpload());
        dotenv.config();
    }

    setRoutes() {
        this.app.use('/', this.router);
        Container.get(UserRouter).SetRouter(this.router);
        Container.get(LookupRouter).SetRouter(this.router);
        Container.get(MemberRouter).SetRouter(this.router);
        Container.get(ClientRouter).SetRouter(this.router);
        Container.get(SchedulerRouter).SetRouter(this.router);
    }

    startApp() {
        const port = process.env.APP_PORT || 3000;
        this.app.listen(port, () => {
            console.log(`Project running on ${port}`);
        });
    }
}



new App();