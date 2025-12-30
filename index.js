const express = require('express');
const app = express();

// Environment variables provided by Cloud Run
const PORT = process.env.PORT || 8080;
const SERVICE = process.env.K_SERVICE || 'local-dev';
const REVISION = process.env.K_REVISION || 'v0';

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to Project Stratos v2',
    status: 'operational',
    service: SERVICE,
    revision: REVISION,
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`Stratos app listening on port ${PORT}`);
});
