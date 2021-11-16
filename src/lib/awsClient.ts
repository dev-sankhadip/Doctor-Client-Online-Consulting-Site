import aws from 'aws-sdk';
import * as dotenv from 'dotenv'

class AwsClient {
    private readonly s3;

    constructor() {
        dotenv.config();
        aws.config.update({
            region: process.env.AWS_REGION
        })

        this.s3 = new aws.S3({
            accessKeyId: process.env.AWS_S3_ACCESS_KEY_ID,
            secretAccessKey: process.env.AWS_S3_SECRET_ACCESS_KEY,
            signatureVersion: "v4"
        });

    }

    CreateBucket(bucketName: string) {
        return new Promise((resolve, reject) => {
            const params = {
                Bucket: bucketName,
                CreateBucketConfiguration: {
                    LocationConstraint: process.env.AWS_REGION
                }
            };

            this.s3.createBucket(params, function (err, data) {
                if (err) reject(err);
                else resolve(data);
            });
        })
    }

    UploadFileToS3(file: any, bucketName?: string): Promise<aws.S3.ManagedUpload.SendData> {
        return new Promise((resolve, reject) => {
            var params = {
                ACL: 'public-read',
                Bucket: process.env.AWS_BUCKET_NAME as string,
                Body: file.data,
                Key: `${file.name}`
            };

            this.s3.upload(params, (err: any, data: aws.S3.ManagedUpload.SendData) => {
                if (err) {
                    return reject(err);
                }

                return resolve(data);
            });
        })
    }
}


export default new AwsClient();