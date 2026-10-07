const express = require('express');
const app = express();
const VERSION = process.env.APP_VERSION || 'inconnue';
const ENV = process.env.APP_ENV || 'local';
app.get('/', (req, res) =>
  res.json({ message: 'GitOps demo', version: VERSION, env: ENV }));
app.get('/health', (req, res) => res.status(200).send('ok'));
app.listen(3000, () => console.log('API sur le port 3000'));
