--Creating Tables:
CREATE TABLE Books (
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);

CREATE TABLE Customers (
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);

CREATE TABLE Orders (
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);

--SELECTING DATA:
SELECT *FROM Books;
SELECT *FROM Customers;
SELECT *FROM Orders;

--IMPORT DATA INTO BOOKS TABLE
COPY Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM 'E:\Kajal\Power BI\SQL satish\SQL Data 1\30 Day - SQL\Satish- SQL Practice Files\SQL Project 1\Books.csv'
CSV HEADER;

---IMPORT DATA INTO CUSTOMERS TABLE
COPY Customers(Customer_ID,Name, Email,Phone,City,Country)
FROM 'E:\Kajal\Power BI\SQL satish\SQL Data 1\30 Day - SQL\Satish- SQL Practice Files\SQL Project 1\Customers.csv'
CSV HEADER;

---IMPORT DATA INTO Orders TABLE
COPY Orders(Order_ID,Customer_ID, Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'E:\Kajal\Power BI\SQL satish\SQL Data 1\30 Day - SQL\Satish- SQL Practice Files\SQL Project 1\Orders.csv'
CSV HEADER;

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

--ADVANCE QUERY
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
