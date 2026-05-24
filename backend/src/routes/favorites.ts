import { Router, type Request } from 'express';
import { pool } from '../config/database.js';

const router = Router();

function getUserId(req: Request): string {
    return (req.headers['x-user-id'] as string) || 'anonymous';
}

router.get('/favorites', async (req, res) => {
    const userId = getUserId(req);
    const result = await pool.query(
        'SELECT * FROM favorites WHERE user_id = $1 ORDER BY created_at DESC',
        [userId],
    );
    res.json(result.rows);
});

router.post('/favorites', async (req, res) => {
    const userId = getUserId(req);
    const { apod_date, title, url } = req.body as { apod_date: string; title?: string; url?: string };
    if (!apod_date) {
        res.status(400).json({ error: 'apod_date is required' });
        return;
    }

    const result = await pool.query(
        `INSERT INTO favorites (user_id, apod_date, title, url)
         VALUES ($1, $2, $3, $4)
         ON CONFLICT (user_id, apod_date) DO NOTHING
         RETURNING *`,
        [userId, apod_date, title || null, url || null],
    );
    res.status(201).json(result.rows[0] || { message: 'Already favorited' });
});

router.delete('/favorites/:apod_date', async (req, res) => {
    const userId = getUserId(req);
    await pool.query('DELETE FROM favorites WHERE user_id = $1 AND apod_date = $2', [
        userId,
        req.params.apod_date,
    ]);
    res.status(204).send();
});

export default router;
