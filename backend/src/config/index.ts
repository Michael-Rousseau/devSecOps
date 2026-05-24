export const config = {
    port: parseInt(process.env.PORT || '3000', 10),
    nodeEnv: process.env.NODE_ENV || 'development',

    nasaApiKey: process.env.NASA_API_KEY || 'DEMO_KEY',

    pg: {
        host: process.env.PG_HOST || 'localhost',
        port: parseInt(process.env.PG_PORT || '5432', 10),
        database: process.env.PG_DATABASE || 'deus_dashboard',
        user: process.env.PG_USER || 'postgres',
        password: process.env.PG_PASSWORD || 'postgres',
    },

    dynamodb: {
        endpoint: process.env.DYNAMODB_ENDPOINT,
        region: process.env.AWS_REGION || 'eu-west-3',
        tableName: process.env.DYNAMODB_TABLE || 'NasaApiCache',
    },

    cacheTtlSeconds: parseInt(process.env.CACHE_TTL_SECONDS || '3600', 10),
} as const;
