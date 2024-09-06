-- +migrate Up
CREATE TABLE IF NOT EXISTS user_follows (
  follow_id SERIAL PRIMARY KEY,
  follower_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
  followed_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
  followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (follower_id, followed_id)
);

CREATE INDEX idx_user_follows_follower_id ON user_follows (follower_id);

CREATE INDEX idx_user_follows_followed_id ON user_follows (followed_id);

CREATE TABLE IF NOT EXISTS avatar_follows (
  follow_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
  avatar_id INTEGER NOT NULL REFERENCES avatars (avatar_id) ON DELETE CASCADE,
  followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (user_id, avatar_id)
);

CREATE INDEX idx_avatar_follows_user_id ON avatar_follows (user_id);

CREATE INDEX idx_avatar_follows_avatar_id ON avatar_follows (avatar_id);

-- +migrate Down
DROP TABLE IF EXISTS user_follows;

DROP TABLE IF EXISTS avatar_follows;
