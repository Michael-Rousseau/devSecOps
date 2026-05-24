import pg from 'pg';
import { config } from './index.js';

export const pool = new pg.Pool({
    host: config.pg.host,
    port: config.pg.port,
    database: config.pg.database,
    user: config.pg.user,
    password: config.pg.password,
    max: 10,
    idleTimeoutMillis: 30_000,
    ssl: config.nodeEnv === 'production' ? { rejectUnauthorized: false } : false,
});

export async function initDatabase(): Promise<void> {
    await pool.query(`
        CREATE TABLE IF NOT EXISTS favorites (
            id SERIAL PRIMARY KEY,
            user_id VARCHAR(255) NOT NULL,
            apod_date VARCHAR(10) NOT NULL,
            title VARCHAR(500),
            url TEXT,
            created_at TIMESTAMP DEFAULT NOW(),
            UNIQUE(user_id, apod_date)
        );

        CREATE TABLE IF NOT EXISTS search_history (
            id SERIAL PRIMARY KEY,
            user_id VARCHAR(255) NOT NULL,
            query VARCHAR(500) NOT NULL,
            search_type VARCHAR(50) NOT NULL,
            created_at TIMESTAMP DEFAULT NOW()
        );
    `);
}
