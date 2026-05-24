import type { Request, Response, NextFunction } from 'express';
import { httpRequestDuration, httpRequestTotal } from '../routes/metrics.js';

export function metricsMiddleware(req: Request, res: Response, next: NextFunction): void {
    const end = httpRequestDuration.startTimer();
    res.on('finish', () => {
        const route = req.route?.path || req.path;
        const labels = { method: req.method, route, status_code: String(res.statusCode) };
        end(labels);
        httpRequestTotal.inc(labels);
    });
    next();
}
