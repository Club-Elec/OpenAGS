/* CREATE DATABASE */
CREATE DATABASE openags;

\c openags


/* CREATE TABLE */
CREATE TABLE userlist(
   username VARCHAR(32) PRIMARY KEY NOT NULL,
   password VARCHAR(32) NOT NULL
);

/* INSERT VALUES */
INSERT INTO userlist(username, password)
VALUES
    ('test', 'pwd');
