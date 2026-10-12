create database online_bookstore;

CREATE TABLE Books (
    Book_ID int PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
    );
    
    drop table books;
    
CREATE TABLE Customers (
    Customer_ID int PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10, 2),

    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from books where genre = "Fiction";

-- 2) Find books published after the year 1950:
select * from books where Published_Year > 1950;

-- 3) List all customers from the Canada:
select * from customers where country = "canada";

-- 4) Show orders placed in November 2023:
select * from orders where Order_Date between '2023-11-1' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) from books ;

-- 6) Find the details of the most expensive book:
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders where Quantity > 1 order by Quantity asc;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where Total_Amount > 20 order by Total_Amount asc;

-- 9) List all genres available in the Books table:
select distinct(genre) from books;

-- 10) Find the book with the lowest stock:
select * from books order by stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) from orders;

-- 1) Retrieve the total number of books sold for each genre:

 SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- 4) Find the most frequently ordered book:

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC ;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books where genre = "fantasy" order by Price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author:

select b.author,sum(o.Quantity) from books b
join 
orders o
on b.Book_ID = o.Book_ID
group by b.Author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct(c.City),Total_Amount from orders o
join customers c
on c.Customer_ID = o.Customer_ID
where o.Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;












