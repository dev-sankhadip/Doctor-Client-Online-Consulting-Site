import * as dotenv from 'dotenv';
dotenv.config();

class Config {
    public readonly corsOptions = {
        origin:
            process.env.ENVIORONMENT == "dev"
                ? "http://localhost:4200"
                : process.env.APPLICATION_URL,
        optionsSuccessStatus: 200,
        methods: "GET,HEAD,PUT,PATCH,POST,DELETE",
    }
}

export default new Config();