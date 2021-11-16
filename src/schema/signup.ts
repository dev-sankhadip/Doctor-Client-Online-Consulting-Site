import Joi, { ObjectSchema } from "joi";
import { validateRequest } from "../middleware/validateRequest";
import { NextFunction, Request, Response } from 'express';

const SignupSchema: ObjectSchema = Joi.object({
    frst_name: Joi.string().required().label("First Name"),
    last_name: Joi.string().required().label("Last Name"),
    email: Joi.string().email().required().label("Email"),
    phone_number: Joi.string()
        .length(12)
        .pattern(/^[0-9]+$/)
        .required()
        .label("Phone Number"),
    refresh_token: Joi.string().required().label('Refresh Token'),
    user_type: Joi.string().valid('P', 'S').required().label('User Type'),
    IsNewUser: Joi.boolean().required().label("New User Identification"),
    major: Joi.string().when('IsNewUser', {
        is: false,
        then: Joi.required(),
        otherwise: Joi.allow(null, '')
    }).label("Major"),
    spec: Joi.string().when('IsNewUser', {
        is: false,
        then: Joi.required(),
        otherwise: Joi.allow(null, '')
    }).label("Specification"),
    experience: Joi.string().when('IsNewUser', {
        is: false,
        then: Joi.required(),
        otherwise: Joi.allow(null, '')
    }).label("Experience")
})

const ValidateSignup = (req: Request, res: Response, next: NextFunction) => {
    validateRequest(req, res, next, SignupSchema);
}

export {
    ValidateSignup,
}

