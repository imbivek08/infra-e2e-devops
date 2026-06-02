const request = require('supertest');
const app = require('../src/app');
const db = require('../src/db');

jest.mock('../src/db', () => ({
  pool: {
    query: jest.fn(),
  },
}));

describe('API smoke tests', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('returns health status', async () => {
    const response = await request(app).get('/api/health');

    expect(response.status).toBe(200);
    expect(response.body).toEqual({
      status: 'ok',
      message: 'Jerney API is vibing ✨',
    });
  });

  it('validates required fields for post creation', async () => {
    const response = await request(app).post('/api/posts').send({ title: 'Only title' });

    expect(response.status).toBe(400);
    expect(response.body).toEqual({ error: 'Title and content are required' });
    expect(db.pool.query).not.toHaveBeenCalled();
  });

  it('returns all posts when query succeeds', async () => {
    const rows = [{ id: 1, title: 'Test post', content: 'Hi', comment_count: '0' }];
    db.pool.query.mockResolvedValueOnce({ rows });

    const response = await request(app).get('/api/posts');

    expect(response.status).toBe(200);
    expect(response.body).toEqual(rows);
    expect(db.pool.query).toHaveBeenCalledTimes(1);
  });
});