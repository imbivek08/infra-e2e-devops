import { render, screen } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import PostCard from './PostCard';

describe('PostCard', () => {
  it('renders post content and link', () => {
    const post = {
      id: 9,
      title: 'Testing post card',
      content: 'This is a preview',
      author: 'QA',
      emoji: '🧪',
      created_at: '2026-01-01T00:00:00.000Z',
      comment_count: 3,
    };

    render(
      <MemoryRouter>
        <PostCard post={post} />
      </MemoryRouter>
    );

    expect(screen.getByText('Testing post card')).toBeInTheDocument();
    expect(screen.getByText('This is a preview')).toBeInTheDocument();
    expect(screen.getByText('3 comments')).toBeInTheDocument();
    expect(screen.getByRole('link')).toHaveAttribute('href', '/post/9');
  });
});