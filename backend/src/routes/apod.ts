import { Router } from 'express';
import { fetchApod, fetchApodRange, fetchApodRandom } from '../services/nasaApi.service.js';
import { getCached, setCache } from '../services/cache.service.js';
import type { ApodData } from '../types/index.js';

const router = Router();

router.get('/apod', async (req, res) => {
    const date = req.query.date as string | undefined;
    const cacheKey = `apod:${date || 'today'}`;

    const cached = await getCached<ApodData>(cacheKey);
    if (cached) {
        res.json(cached);
        return;
    }

    const data = await fetchApod(date);
    await setCache(cacheKey, data);
    res.json(data);
});

router.get('/apod/range', async (req, res) => {
    const { start_date, end_date } = req.query as { start_date: string; end_date: string };
    if (!start_date || !end_date) {
        res.status(400).json({ error: 'start_date and end_date are required' });
        return;
    }
    const cacheKey = `apod-range:${start_date}:${end_date}`;
    const cached = await getCached<ApodData[]>(cacheKey);
    if (cached) {
        res.json(cached);
        return;
    }

    const data = await fetchApodRange(start_date, end_date);
    await setCache(cacheKey, data);
    res.json(data);
});

router.get('/apod/random', async (req, res) => {
    const count = parseInt(req.query.count as string) || 6;
    const data = await fetchApodRandom(count);
    res.json(data);
});

export default router;
