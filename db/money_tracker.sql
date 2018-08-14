DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE budgets;


CREATE TABLE merchants(
  id SERIAL PRIMARY KEY,
  store_name VARCHAR
);

CREATE TABLE tags(
  id SERIAL PRIMARY KEY,
  type VARCHAR
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
  transaction_time TIMESTAMP,
  amount FLOAT

);
CREATE TABLE budgets (
  id SERIAL PRIMARY KEY,
  amount FLOAT,
  add_time TIMESTAMP
);
