import { ObjectSchema } from "joi";
import { NextFunction, Request, Response } from 'express';


function validateRequest(req: Request, res: Response, next: NextFunction, schema: ObjectSchema) {
    const options = {
        abortEarly: false, // include all errors
        allowUnknown: true, // ignore unknown props
        stripUnknown: true // remove unknown props
    };
    const { error, value } = schema.validate(req.body, options);
    if (error) {
        res.status(400).send(error.details);
    } else {
        req.body = value;
        next();
    }
}

export {
    validateRequest
}