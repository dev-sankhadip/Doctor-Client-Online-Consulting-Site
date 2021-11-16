import Joi, { ObjectSchema, } from "joi";
import { validateRequest } from "../middleware/validateRequest";
import { NextFunction, Request, Response } from 'express';


const VerifyTimeFormat = (value: any, helpers: any) => {
    if (value > '23:59' || value < '00:00')
        return helpers.error('any.formaterror');
    return value;
}

const VerifyEndTime = (value: any, helpers: any) => {
    const { startTime } = helpers.state.ancestors[0];
    if (value < startTime)
        return helpers.error('any.invalid');
    return value;
}

const CreateAppoiment: ObjectSchema = Joi.object({
    summary: Joi.string().required().label("Summary"),
    date: Joi.date().required().label("Meeting Date"),
    startTime: Joi.string()
        .regex(/^([0-9]{2})\:([0-9]{2})$/)
        .required()
        .custom(VerifyTimeFormat)
        .label("Meeting Start Time")
        .messages({
            'any.formaterror': "Wrong Time format",
        })
    ,
    endTime: Joi.string()
        .regex(/^([0-9]{2})\:([0-9]{2})$/)
        .required()
        .custom(VerifyTimeFormat)
        .custom(VerifyEndTime)
        .label("Meeting End Time")
        .messages({
            'any.formaterror': "Wrong Time format",
        }),
    sessionInfo: Joi.string().required().label("Session Information"),
    patientDetails: Joi.array().items(Joi.object({
        name: Joi.string().required().label("Patient Name"),
        email: Joi.string().email().required().label("Patient Email"),
        gender: Joi.string().required().label("Patient Gender"),
        ph: Joi.string().length(12).pattern(/^[0-9]+$/).required().label("Patient Phone Number"),
        dob: Joi.date().required().label("Patient DOB"),
    })).min(1).unique().required()
})


const UpdateAppoinment = CreateAppoiment.keys({
    meetingId: Joi.string().required().label("Meeting ID")
})


const ValidateUpdateAppoiment = (req: Request, res: Response, next: NextFunction) => {
    validateRequest(req, res, next, UpdateAppoinment);
}

const ValidateCreateAppoiment = (req: Request, res: Response, next: NextFunction) => {
    validateRequest(req, res, next, CreateAppoiment);
}

export {
    ValidateCreateAppoiment,
    ValidateUpdateAppoiment
}