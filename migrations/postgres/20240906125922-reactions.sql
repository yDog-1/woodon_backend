-- +migrate Up
CREATE TABLE IF NOT EXISTS reactions (
  reaction_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS post_reactions (
  post_reaction_id SERIAL PRIMARY KEY,
  post_id INTEGER NOT NULL REFERENCES posts(post_id) ON DELETE CASCADE,
  user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  reaction_id INTEGER NOT NULL REFERENCES reactions(reaction_id) ON DELETE CASCADE,
  UNIQUE(post_id, user_id, reaction_id)
);
CREATE INDEX idx_post_reactions_post_id ON post_reactions(post_id);
CREATE INDEX idx_post_reactions_user_id ON post_reactions(user_id);
-- +migrate Down
DROP TABLE IF EXISTS reactions;
DROP TABLE IF EXISTS post_reactions;