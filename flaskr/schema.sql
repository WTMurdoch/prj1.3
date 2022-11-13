DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS board_owns;
DROP TABLE IF EXISTS share;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS tracks;
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS owns;
DROP TABLE IF EXISTS committee;
DROP TABLE IF EXISTS enrolled;
DROP TABLE IF EXISTS post;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  firstname TEXT,
  lastname TEXT,
  age INTEGER,
  occupation TEXT,
  zipcode INTEGER
);

CREATE TABLE board_owns (
  boardid INTEGER PRIMARY KEY AUTOINCREMENT,
  id INTEGER UNIQUE NOT NULL,
  FOREIGN KEY (id) REFERENCES user (id)
);

CREATE TABLE share (
  boardid INTEGER REFERENCES board_owns (boardid),
  id INTEGER REFERENCES user (id),
  PRIMARY KEY (boardid, id)
);

CREATE TABLE member(
  memberid INTEGER PRIMARY KEY AUTOINCREMENT,
  prefix TEXT,
  lastname TEXT,
  firstname TEXT,
  statedistrict TEXT,
  age INTEGER
);

CREATE TABLE tracks(
  boardid INTEGER REFERENCES board_owns (boardid),
  memberid INTEGER REFERENCES member (memberid),
  PRIMARY KEY (boardid, memberid)
);

CREATE TABLE stock(
  symbol TEXT PRIMARY KEY,
  name TEXT,
  currentvalue FLOAT 
);

CREATE TABLE owns(
  memberid INTEGER REFERENCES member (memberid),
  symbol TEXT REFERENCES stock (symbol),
  disclosure TEXT,
  docid INTEGER,
  buydate DATE,
  PRIMARY KEY (memberid, symbol)
);

CREATE TABLE committee(
  committeeid INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE enrolled(
  memberid INTEGER REFERENCES member (memberid),
  committeeid INTEGER REFERENCES committee (committeeid),
  PRIMARY KEY (memberid, committeeid)
);

CREATE TABLE post (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES user (id)
);