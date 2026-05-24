import { GetCommand, PutCommand } from '@aws-sdk/lib-dynamodb';
import { docClient } from '../config/dynamodb.js';
import { config } from '../config/index.js';

const TABLE = config.dynamodb.tableName;

export async function getCached<T>(key: string): Promise<T | null> {
    try {
        const result = await docClient.send(
            new GetCommand({ TableName: TABLE, Key: { cacheKey: key } }),
        );
        if (!result.Item) return null;
        if (result.Item.ttl < Math.floor(Date.now() / 1000)) return null;
        return result.Item.data as T;
    } catch {
        return null;
    }
}

export async function setCache(key: string, data: unknown): Promise<void> {
    try {
        await docClient.send(
            new PutCommand({
                TableName: TABLE,
                Item: {
                    cacheKey: key,
                    data,
                    ttl: Math.floor(Date.now() / 1000) + config.cacheTtlSeconds,
                },
            }),
        );
    } catch (err) {
        console.error('Cache write failed:', err);
    }
}
