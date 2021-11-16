import { Auth, calendar_v3, google } from 'googleapis';
import * as dotenv from 'dotenv'
dotenv.config()


class GoogleAPIClient {
    private googleAuth2Client: Auth.OAuth2Client;

    constructor() {
        const { OAuth2 } = google.auth

        this.googleAuth2Client = new OAuth2(
            process.env.GOOGLE_CLIENT_ID,
            process.env.GOOGLE_CLIENT_SECRET,
            `${process.env.APPLICATION_URL}/oauth`
        )
    }

    get GoogleAuth2Client() {
        return this.googleAuth2Client;
    }

    SetCredentials(access_token: string, refresh_token: string) {
        this.googleAuth2Client.setCredentials({
            access_token,
            refresh_token
        })

        return this.googleAuth2Client;
    }

    GoogleCalenderAPI = (googleAuth2Client: Auth.OAuth2Client) => {
        const calendar: calendar_v3.Calendar = google.calendar({ version: 'v3', auth: googleAuth2Client });

        return calendar;
    }


    ListCalenderEvent(access_token: string, refresh_token: string, minDate: string, maxDate: string | undefined): Promise<calendar_v3.Schema$Event[] | undefined> {
        return new Promise(async (resolve, reject) => {
            try {

                const calender = this.GoogleCalenderAPI(this.SetCredentials(access_token, refresh_token))
                const response = await calender.events.list({
                    calendarId: 'primary',
                    timeMin: minDate,
                    timeMax: maxDate,
                    singleEvents: true,
                    orderBy: 'startTime',
                });
                const events = response.data.items;
                return resolve(events);
            } catch (error) {
                reject(error);
            }
        })
    }

    CreateCalenderEvent(access_token: string, refresh_token: string, eventDetails: object) {
        return new Promise((resolve, reject) => {
            const googleClient = this.SetCredentials(access_token, refresh_token);
            const calender = this.GoogleCalenderAPI(googleClient);
            try {
                const event = calender.events.insert({
                    calendarId: 'primary',
                    requestBody: eventDetails,
                    conferenceDataVersion: 1,
                    sendUpdates: "all"
                });
                return resolve(event);
            } catch (error) {
                return reject(error);
            }
        })
    }

    GenerateAuthURL(scopes: string[], email: string) {
        return new Promise((resolve, reject) => {
            try {
                const url = this.googleAuth2Client.generateAuthUrl({
                    access_type: 'offline',
                    scope: scopes,
                    login_hint: email,
                    prompt: 'select_account consent'
                });
                return resolve(url);
            } catch (error) {
                return reject(error);
            }
        })
    }

    UpdateCalendarEvent = (access_token: string, refresh_token: string, eventId: string, eventDetails: object) => {
        return new Promise(async (resolve, reject) => {
            const calender = this.GoogleCalenderAPI(this.SetCredentials(access_token, refresh_token));

            try {
                const event = await calender.events.patch({
                    calendarId: 'primary',
                    eventId,
                    requestBody: eventDetails,
                    sendUpdates: "all"
                });
                return resolve(event);
            } catch (error) {
                return reject(error);
            }
        })
    }

    GetTokenInfo = (access_token: string): Promise<Auth.TokenInfo> => {
        return new Promise(async (resolve, reject) => {
            try {
                const scope = await this.googleAuth2Client.getTokenInfo(access_token);
                return resolve(scope);
            } catch (error) {
                return reject(error);
            }
        })
    }
}

export default new GoogleAPIClient();