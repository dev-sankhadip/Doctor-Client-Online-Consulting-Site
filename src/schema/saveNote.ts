import Joi, { ObjectSchema } from "joi";

const SavePatientNotes: ObjectSchema = Joi.object({
    noteId: Joi.string().allow(null),
    clientId: Joi.string().required().label("Doctor ID"),
    meetingId: Joi.string().required().label("Meeting ID"),
    resource: Joi.string().required().label("Notes")
})



export {
    SavePatientNotes
}