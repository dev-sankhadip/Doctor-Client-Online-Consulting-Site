import { admin } from '../lib/firebaseAdmin';
import { Request, Response, NextFunction } from 'express'
import { Container } from 'typedi';
import UserDA from '../DA/user.da';


const VerifyUser = (req: Request, res: Response, next: NextFunction) => {
    const { accesstoken } = req.headers;

    admin
        .auth()
        .verifyIdToken(accesstoken as string)
        .then(async (decodedIdToken) => {

            const user_rows = await Container.get(UserDA).GetUserIdByExternalUserId(decodedIdToken.user_id);
            req.userid = user_rows[0].User_Id;
            next();
        })
        .catch((err) => {
            console.log(err);
            if (err.code == "auth/id-token-expired") {
                console.error("Access Token has expired")
            }
            if (err.code == "auth/argument-error") {
                console.error("Decoding Firebase ID token failed");
            }
            if (err.code == "auth/id-token-revoked") {
                console.error("Access Token has been revoked")
            }
            res.status(401).send({ err });
        });
};

export {
    VerifyUser
}