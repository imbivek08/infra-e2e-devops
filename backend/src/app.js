const express = require('express');
const cors = require('cors');
const postRoutes = require('./routes/posts');
const commentRoutes = require('./routes/comments');

const app = express();

app.use(cors());
app.use(express.json());

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'Jerney API is vibing ✨' });
});

app.use('/api/posts', postRoutes);
app.use('/api/comments', commentRoutes);

module.exports = app;