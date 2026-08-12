const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'secure-app' });
});

app.listen(port, () => {
  console.log(`Secure app listening on port ${port}`);
});
