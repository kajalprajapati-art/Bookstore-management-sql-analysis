# # 📚 Bookstore Management & Sales Analysis Using SQL

## 📌 Project Overview

This project focuses on analyzing bookstore sales, customer purchasing behavior, book inventory, and revenue using **PostgreSQL**. The database consists of three relational tables: `Books`, `Customers`, and `Orders`.

SQL queries are used to extract meaningful business information, analyze sales performance, identify high-value customers, evaluate book popularity, and examine inventory levels. The project demonstrates the application of SQL for data retrieval, aggregation, relational data analysis, and business decision-making.

## 🎯 Key Objectives

- Analyze total revenue generated from book orders.
- Identify the most frequently ordered books and popular genres.
- Evaluate customer purchasing behavior and spending patterns.
- Analyze book prices, available stock, and inventory levels.
- Calculate the total quantity of books sold by each author.
- Identify repeat customers and high-value orders.
- Use relational joins and aggregate functions to extract business insights.

## 🛠️ Tools & Technologies

- **PostgreSQL** — Database management and SQL query execution.
- **pgAdmin 4** — SQL query editor and database management interface.
- **CSV Files** — Source data for books, customers, and orders.
- **SQL** — Data extraction, filtering, aggregation, joins, and analysis.

## 🗂️ Database Structure

The project contains three tables:

| Table | Description |
|---|---|
| `Books` | Book titles, authors, genres, publication years, prices, and stock quantities. |
| `Customers` | Customer details, email addresses, phone numbers, cities, and countries. |
| `Orders` | Order dates, customer IDs, book IDs, quantities, and total order amounts. |

The `Orders` table connects the `Books` and `Customers` tables using foreign keys, enabling relational analysis across the database.

## 🔍 Key Analysis Performed

### 1. Book & Inventory Analysis
- Retrieved books by genre and publication year.
- Identified the most expensive books.
- Calculated total available stock.
- Identified books with the lowest stock.
- Examined order quantities against book inventory.

### 2. Sales & Revenue Analysis
- Calculated total revenue from all orders.
- Filtered orders by date and order amount.
- Analyzed total books sold by genre.
- Evaluated quantities sold by each author.
- Identified the most frequently ordered book.

### 3. Customer Analysis
- Identified customers from specific countries.
- Found customers who placed at least two orders.
- Calculated total spending by customer.
- Identified cities associated with orders exceeding $30.


## 💡 Key Business Questions

This project uses SQL to answer questions such as:

---1) Retrieve all the books in the "Fiction" genre:
SELECT
	*
FROM
	BOOKS
WHERE
	GENRE = 'Fiction';

---2) Find books published after the year 1950:
SELECT
	*
FROM
	BOOKS
WHERE
	PUBLISHED_YEAR > 1950;

--3) List all customers from the Canada:
SELECT
	*
FROM
	CUSTOMERS
WHERE
	COUNTRY = 'Canada';

--4) Show Orders placed in November 2023:
SELECT
	*
FROM
	ORDERS
WHERE
	ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';

--5) Retrieve the Total Stock of Book available:
SELECT
	SUM(STOCK) AS TOTAL_STOCK
FROM
	BOOKS;

--6) Find the details of the most expensive book:
SELECT
	*
FROM
	BOOKS
ORDER BY
	PRICE DESC
LIMIT
	1;

--7) Show all customers who ordered more than 1 quantity of a book:
SELECT
	*
FROM
	ORDERS
WHERE
	QUANTITY > 1;

--8) Retrieve all order Where the total amount exceeds $20:
SELECT
	*
FROM
	ORDERS
WHERE
	TOTAL_AMOUNT > 20;

--9) List all genres available in the books table:
SELECT
	*
FROM
	BOOKS
ORDER BY
	STOCK ASC;

--10) Find the book with the lowest stock:
SELECT
	*
FROM
	BOOKS
ORDER BY
	STOCK
LIMIT
	1;

--11) Calculate the Total Revenue generated from all the orders:
SELECT
	SUM(TOTAL_AMOUNT) AS REVENUE
FROM
	ORDERS;

#### 4. ADVANCE QUERY

--12) Retrieve the total number of Books sold from each genre:
SELECT
	B.GENRE,
	SUM(O.QUANTITY)
FROM
	ORDERS O
	JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY
	B.GENRE;

--13) Find Average Price of books in the Fantasy Genre:
SELECT
	AVG(PRICE) AS AVERAGE_PRICE
FROM
	BOOKS
WHERE
	GENRE = 'Fantasy';

--14) List customers who have placed at least 2 orders:
SELECT
	O.CUSTOMER_ID,
	C.NAME,
	COUNT(O.ORDER_ID) AS ORDER_COUNT
FROM
	ORDERS O
	JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY
	O.CUSTOMER_ID,
	C.NAME
HAVING
	COUNT(ORDER_ID) >= 2;

--15) Find the most Frequently ordered book:
SELECT
	BOOK_ID,
	COUNT(ORDER_ID) AS ORDER_COUNT
FROM
	ORDERS
GROUP BY
	BOOK_ID
ORDER BY
	ORDER_COUNT DESC
LIMIT
	1;

--16) Show the Top 3 most expensive books of Fantasy genre:
SELECT
	*
FROM
	BOOKS
WHERE
	GENRE = 'Fantasy'
ORDER BY
	PRICE DESC
LIMIT
	3;

--17) Retrieve the total quantity of books sold by each author:
SELECT
	B.AUTHOR,
	SUM(O.QUANTITY) AS TOTAL_BOOK_SOLD
FROM
	ORDERS O
	JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY
	B.AUTHOR;

--18) List the Cities where customers who spend over $30 are located:
SELECT DISTINCT
	C.CITY,
	TOTAL_AMOUNT
FROM
	ORDERS O
	JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE
	O.TOTAL_AMOUNT > 30;

--19) Find the Customer who spend the most on the orders:
SELECT
	C.CUSTOMER_ID,
	C.NAME,
	SUM(O.TOTAL_AMOUNT) AS TOTAL_SPEND
FROM
	ORDERS O
	JOIN CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY
	C.CUSTOMER_ID,
	C.NAME
ORDER BY
	TOTAL_SPEND DESC
LIMIT
	1;

--20) Calculate the stock remaining after fulfilling all the orders:
SELECT
	B.BOOK_ID,
	B.TITLE,
	B.STOCK,
	COALESCE(SUM(QUANTITY), 0) AS ORDER_QUANTITY,
	B.STOCK - COALESCE(SUM(O.QUANTITY), 0) AS REMAINING_QUANTITY
FROM
	BOOKS B
	LEFT JOIN ORDERS O ON B.BOOK_ID = O.BOOK_ID
GROUP BY
	B.BOOK_ID;











---

*This project demonstrates practical SQL skills for analyzing relational business data and supporting data-driven decision-making.*

