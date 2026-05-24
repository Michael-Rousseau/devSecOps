import { Router } from 'express';
import { pool } from '../config/database.js';

const router = Router();

router.get('/health', async (_req, res) => {
    const checks: Record<string, string> = { status: 'ok' };
    try {
        await pool.query('SELECT 1');
        checks.postgres = 'connected';
    } catch {
        checks.postgres = 'disconnected';
        checks.status = 'degraded';
    }
    const statusCode = checks.status === 'ok' ? 200 : 503;
    res.status(statusCode).json(checks);
});

export default router;
