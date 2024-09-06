-- +migrate Up
CREATE TABLE IF NOT EXISTS post_comments (
  comment_id SERIAL PRIMARY KEY,
  post_id INTEGER NOT NULL REFERENCES posts (post_id) ON DELETE CASCADE,
  user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_post_comments_post_id ON post_comments (post_id);

CREATE INDEX idx_post_comments_user_id ON post_comments (user_id);

-- +migrate Down
DROP TABLE IF EXISTS post_comments;
