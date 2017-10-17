DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (id, fname, lname)
VALUES
  (1, 'Niall', 'Mahford');

INSERT INTO
  users (id, fname, lname)
VALUES
  (2, 'Jeffrey', 'Chuc');

INSERT INTO
  users (id, fname, lname)
VALUES
  (3, 'Jesse', 'Ta');

INSERT INTO
  questions (id, title, body, user_id)
VALUES
  (1, 'How do you program?', 'I want to get paid to program, how do you do that?', 2);

INSERT INTO
  questions (id, title, body, user_id)
VALUES
  (2, 'What up?', 'How you doin today?', 1);

INSERT INTO
  question_follows (id, user_id, question_id)
VALUES
  (1, 1, 1);

INSERT INTO
  question_follows (id, user_id, question_id)
VALUES
  (2, 3, 1);

INSERT INTO
  question_follows (id, user_id, question_id)
VALUES
  (3, 2, 2);

INSERT INTO
  replies (id, question_id, body, parent_id, user_id)
VALUES
  (1, 1, 'yes', null, 1);

INSERT INTO
  replies (id, question_id, body, parent_id, user_id)
VALUES
  (2, 1, 'cool', 1, 3);

INSERT INTO
  question_likes (id, user_id, question_id)
VALUES
  (1, 3, 1);
