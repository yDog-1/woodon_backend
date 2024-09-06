-- +migrate Up
CREATE TABLE IF NOT EXISTS categories (
  category_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

ALTER TABLE posts
ADD COLUMN category_id INTEGER REFERENCES categories (category_id) ON DELETE RESTRICT;

-- +migrate Down
ALTER TABLE posts
DROP COLUMN category_id;

DROP TABLE IF EXISTS categories;
