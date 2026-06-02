import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import ConfirmModal from './ConfirmModal';

describe('ConfirmModal', () => {
  it('renders title/message and triggers callbacks', async () => {
    const onCancel = vi.fn();
    const onConfirm = vi.fn();
    const user = userEvent.setup();

    render(
      <ConfirmModal
        title="Delete post"
        message="This cannot be undone"
        onConfirm={onConfirm}
        onCancel={onCancel}
      />
    );

    expect(screen.getByText('Delete post')).toBeInTheDocument();
    expect(screen.getByText('This cannot be undone')).toBeInTheDocument();

    await user.click(screen.getByRole('button', { name: 'Nah, keep it' }));
    await user.click(screen.getByRole('button', { name: 'Yeah, delete it' }));

    expect(onCancel).toHaveBeenCalledTimes(1);
    expect(onConfirm).toHaveBeenCalledTimes(1);
  });
});