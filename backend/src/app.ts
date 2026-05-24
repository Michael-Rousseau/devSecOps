import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import healthRoutes from './routes/health.js';
import apodRoutes from './routes/apod.js';
import eventsRoutes from './routes/events.js';
import favoritesRoutes from './routes/favorites.js';
import metricsRoutes from './routes/metrics.js';
import { errorHandler } from './middleware/errorHandler.js';
import { metricsMiddleware } from './middleware/metricsMiddleware.js';

export function createApp() {
    const app = express();

    app.use(helmet());
    app.use(cors());
    app.use(morgan('combined'));
    app.use(express.json());
    app.use(metricsMiddleware);

    app.use('/api', healthRoutes);
    app.use('/api', apodRoutes);
    app.use('/api', eventsRoutes);
    app.use('/api', favoritesRoutes);
    app.use('/api', metricsRoutes);

    app.use(errorHandler);

    return app;
}
