import { Router } from 'express';
import { fetchNaturalEvents } from '../services/nasaApi.service.js';
import { getCached, setCache } from '../services/cache.service.js';
import type { EonetEvent } from '../types/index.js';

const router = Router();

router.get('/events', async (req, res) => {
    const limit = parseInt(req.query.limit as string) || 20;
    const days = parseInt(req.query.days as string) || 20;
    const cacheKey = `events:${limit}:${days}`;

    const cached = await getCached<{ events: EonetEvent[] }>(cacheKey);
    if (cached) {
        res.json(cached);
        return;
    }

    const data = await fetchNaturalEvents(limit, days);
    await setCache(cacheKey, data);
    res.json(data);
});

export default router;
