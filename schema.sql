PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Shows;

CREATE TABLE Customers (
  customer_id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  address1 TEXT,
  address2 TEXT,
  city TEXT,
  province_state TEXT,
  postcode TEXT,
  country TEXT
);

CREATE TABLE Shows (
  show_id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  author TEXT,
  show_date TEXT,
  show_time TEXT
);

CREATE TABLE Orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  show_id INTEGER NOT NULL,
  qty INTEGER NOT NULL CHECK (qty >= 0),
  price REAL NOT NULL CHECK (price >= 0),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

CREATE INDEX idx_orders_customer ON Orders(customer_id);
CREATE INDEX idx_orders_show ON Orders(show_id);
