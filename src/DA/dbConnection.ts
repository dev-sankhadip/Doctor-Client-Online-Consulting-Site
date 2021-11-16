import mysql, { Pool } from 'mysql2/promise';
import { ConvertUndefinedToNull } from '../lib/commonFunctions';

export default class DbConnection {

    public poolConnection: Pool;
    protected static instance: DbConnection | null = null

    constructor() {
        this.poolConnection = mysql.createPool({
            user: process.env.DB_USER,
            host: process.env.DB_HOST,
            database: process.env.DATABASE,
            password: process.env.DB_PASSWORD,
            waitForConnections: true,
            connectionLimit: Number.MAX_SAFE_INTEGER,
            queueLimit: 0,
            port: parseInt(process.env.SQL_PORT as string)
        });
    }

    public static getInstance(): DbConnection {
        if (!DbConnection.instance) {
            DbConnection.instance = new DbConnection()
        }
        return DbConnection.instance;
    }

    InsertOrUpdateDB(queryList: string[], paramsList: (string | null | number | Date | undefined)[][]) {
        return new Promise<void | any>(async (resolve, reject) => {
            let resultSet: (mysql.RowDataPacket[] | mysql.RowDataPacket[][] | mysql.OkPacket | mysql.OkPacket[] | mysql.ResultSetHeader)[] = [];
            const connection = await this.poolConnection.getConnection();
            await connection.execute("SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED");
            await connection.beginTransaction();

            try {
                const promises = queryList.map(async (query, index) => {
                    try {
                        const [res] = await connection.execute(query, ConvertUndefinedToNull(paramsList[index]));
                        resultSet.push(res);
                    } catch (error) {
                        throw error;
                    }
                });
                await Promise.all(promises);
                await connection.commit();
                resolve(resultSet);
            } catch (error) {
                await connection.rollback();
                reject(error);
            }
        })
    }

    ReadDB<T>(query: string, paramsList?: (string | null | number | Date)[]) {
        return new Promise<T>(async (resolve, reject) => {
            try {
                const [result] = await this.poolConnection.execute(query, paramsList);
                resolve(result as unknown as T);
            } catch (error) {
                reject(error);
            }
        })
    }

}