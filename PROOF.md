# Proof / Step-by-step process (MT Ticket Orders)

## 1) Receive files
1. Download the assignment ZIP.
2. Extract it into a project folder.
3. Confirm the three CSV files are present:
   - MT Data Set - CUSTOMERS.csv
   - MT Data Set - SHOWS.csv
   - MT Data Set - ORDERS.csv

## 2) Inspect CSV structure
Open each CSV and confirm columns:

### CUSTOMERS
UID, First Name, Last Name, Address, Adress 2, City, Province/State, Postcode, Country

### SHOWS
UID, Title, Author, Date, Time

### ORDERS
UID, PEOPLE ID, SHOW ID, QTY, PRICE

Observation: ORDERS links people (customers) to shows using numeric IDs, so the natural relational design is:
- Customers (one)
- Shows (one)
- Orders (many) referencing both.

## 3) Database design (tables + keys)
Create a 3-table relational model:

- Customers(customer_id PK, first_name, last_name, address1, address2, city, province_state, postcode, country)
- Shows(show_id PK, title, author, show_date, show_time)
- Orders(order_id PK, customer_id FK, show_id FK, qty, price)

Rationale:
- Customers and Shows contain attributes that repeat across many orders, so they are separated to reduce duplication.
- Orders is the transactional table connecting a customer to a show and storing purchase details (qty, price).
- Primary keys use the existing UID columns from the dataset.
- Foreign keys enforce referential integrity from Orders -> Customers/Shows.

## 4) Create the database schema
Execute `03_sql/schema.sql` in SQLite (or your DBMS).

Important settings:
- Turn on foreign keys (SQLite): `PRAGMA foreign_keys = ON;`

## 5) Import data
Import rows into each table:
1. Import CUSTOMERS into Customers
2. Import SHOWS into Shows
3. Import ORDERS into Orders

After import, verify row counts:
- Customers: 20
- Shows: 10
- Orders: 40

## 6) Validate relationships
Run quick checks:
- No orphan Orders:
  - Orders.customer_id must exist in Customers
  - Orders.show_id must exist in Shows

Example validation queries:
- `SELECT COUNT(*) FROM Orders o LEFT JOIN Customers c ON c.customer_id=o.customer_id WHERE c.customer_id IS NULL;`
- `SELECT COUNT(*) FROM Orders o LEFT JOIN Shows s ON s.show_id=o.show_id WHERE s.show_id IS NULL;`

Expected result: 0 for both.

## 7) Run the assignment question query
Write a SQL query using JOINs between Orders, Customers, and Shows.

Common patterns:
- Revenue per show: SUM(qty * price) grouped by show
- Total spend per customer: SUM(qty * price) grouped by customer
- Tickets per country/city: group by customer geography fields

Queries used for this submission are saved in `03_sql/queries.sql` and exported outputs are in `04_outputs/`.

## 8) Export results (proof of output)
Export your query results as CSV or screenshot the result grid.

This submission includes:
- 04_outputs/revenue_by_show.csv
- 04_outputs/top_customers_by_spend.csv
- 04_outputs/revenue_by_country.csv
- 04_outputs/orders_detail_with_totals.csv
