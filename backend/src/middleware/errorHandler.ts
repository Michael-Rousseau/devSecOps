import type { ErrorRequestHandler } from 'express';

export const errorHandler: ErrorRequestHandler = (err, _req, res, _next) => {
    console.error('Unhandled error:', err);
    const status = (err as { status?: number }).status || 500;
    res.status(status).json({
        error: 'Internal server error',
        ...(process.env.NODE_ENV !== 'production' && { message: (err as Error).message }),
    });
};
