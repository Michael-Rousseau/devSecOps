import { Router } from 'express';
import client from 'prom-client';

const register = client.register;

client.collectDefaultMetrics({ register });

export const httpRequestDuration = new client.Histogram({
    name: 'http_request_duration_seconds',
    help: 'Duration of HTTP requests in seconds',
    labelNames: ['method', 'route', 'status_code'],
    buckets: [0.01, 0.05, 0.1, 0.5, 1, 5],
});

export const httpRequestTotal = new client.Counter({
    name: 'http_requests_total',
    help: 'Total number of HTTP requests',
    labelNames: ['method', 'route', 'status_code'],
});

export const cacheHitTotal = new client.Counter({
    name: 'cache_hit_total',
    help: 'Total number of DynamoDB cache hits',
    labelNames: ['route'],
});

export const cacheMissTotal = new client.Counter({
    name: 'cache_miss_total',
    help: 'Total number of DynamoDB cache misses',
    labelNames: ['route'],
});

const router = Router();

router.get('/metrics', async (_req, res) => {
    res.set('Content-Type', register.contentType);
    res.end(await register.metrics());
});

export default router;
