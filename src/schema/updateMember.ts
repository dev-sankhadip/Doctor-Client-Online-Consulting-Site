import Joi, { ObjectSchema } from "joi";
import { validateRequest } from "../middleware/validateRequest";
import { NextFunction, Request, Response } from 'express';



const UpdateMemberSchema: ObjectSchema = Joi.object({
    frst_name: Joi.string().required().label("First Name"),
    last_name: Joi.string().required().label("Last Name"),
    email: Joi.string().email().required().label("Email"),
    major: Joi.string().required().label("Major"),
    spec: Joi.string().required().label("Specification"),
    experience: Joi.string().required().label("Experience"),
    addr: Joi.string().allow(null, "").label("Address"),
    photo_url: Joi.string().uri().allow(null, "").label("Photo URL"),
    reminder_time: Joi.number().min(1).required().label("Reminder Time")
})



const ValidateUpdateMember = (req: Request, res: Response, next: NextFunction) => {
    validateRequest(req, res, next, UpdateMemberSchema);
}

export {
    ValidateUpdateMember,
}