import admin from 'firebase-admin';

let serviceAccount = require(process.env.CREDENTIAL_PATH as string);

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: process.env.FIREBASE_DB_URL,
});


export {
    admin
}