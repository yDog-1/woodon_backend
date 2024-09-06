-- +migrate Up
CREATE TABLE IF NOT EXISTS users(
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(20) NOT NULL UNIQUE,
  display_name VARCHAR(50) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  banned BOOLEAN DEFAULT FALSE
);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE TABLE user_bans (
  ban_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  ban_reason TEXT,
  banned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS user_profiles(
  profile_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  birthdate DATE,
  bio TEXT,
  profile_picture_url VARCHAR(255)
);
CREATE INDEX idx_user_profiles_user_id ON user_profiles(user_id);
CREATE TABLE IF NOT EXISTS avatars(
  avatar_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  name VARCHAR(50) NOT NULL
);
CREATE INDEX idx_avatars_user_id ON avatars(user_id);
CREATE TABLE IF NOT EXISTS posts (
  post_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  avatar_id INTEGER NOT NULL REFERENCES avatars(avatar_id) ON DELETE CASCADE,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_avatar_id ON posts(avatar_id);
CREATE TABLE IF NOT EXISTS post_images (
  image_id SERIAL PRIMARY KEY,
  post_id INTEGER NOT NULL REFERENCES posts(post_id) ON DELETE CASCADE,
  image_url VARCHAR(255) NOT NULL
);
-- +migrate Down
DROP TABLE IF EXISTS post_images;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS avatars;
DROP TABLE IF EXISTS user_bans;
DROP TABLE IF EXISTS user_profiles;
DROP TABLE IF EXISTS users;