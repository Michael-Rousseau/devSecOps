import { createApp } from './app.js';
import { config } from './config/index.js';
import { initDatabase } from './config/database.js';

async function main() {
    await initDatabase();
    const app = createApp();
    app.listen(config.port, () => {
        console.log(`Backend listening on port ${config.port}`);
    });
}

main().catch((err) => {
    console.error('Failed to start:', err);
    process.exit(1);
});
