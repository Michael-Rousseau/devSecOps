import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient } from '@aws-sdk/lib-dynamodb';
import { config } from './index.js';

const client = new DynamoDBClient({
    region: config.dynamodb.region,
    ...(config.dynamodb.endpoint && { endpoint: config.dynamodb.endpoint }),
});

export const docClient = DynamoDBDocumentClient.from(client, {
    marshallOptions: { removeUndefinedValues: true },
});
