sqlite> .open C:/Users/harin/OneDrive/ADSD_Assignment4/task5.db
sqlite> CREATE TABLE customers (
(x1...>   customer_id INTEGER PRIMARY KEY,
(x1...>   customer_name TEXT
(x1...> );
sqlite> CREATE TABLE orders (
(x1...>   order_id INTEGER PRIMARY KEY,
(x1...>   customer_id INTEGER,
(x1...>   product_name TEXT,
(x1...>   FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
(x1...> );
sqlite> INSERT INTO customers (customer_name) VALUES ('Alice');
sqlite> INSERT INTO customers (customer_name) VALUES ('Bob');
sqlite> INSERT INTO customers (customer_name) VALUES ('Charlie');
sqlite> INSERT INTO orders (customer_id, product_name) VALUES (1, 'Laptop');
sqlite> INSERT INTO orders (customer_id, product_name) VALUES (2, 'Smartphone');
sqlite> INSERT INTO orders (customer_id, product_name) VALUES (1, 'Tablet');
sqlite> SELECT customers.customer_name, orders.product_name
   ...> FROM customers
   ...> INNER JOIN orders
   ...> ON customers.customer_id = orders.customer_id;
Alice|Laptop
Bob|Smartphone
Alice|Tablet
sqlite> SELECT customers.customer_name, orders.product_name
   ...> FROM customers
   ...> LEFT JOIN orders
   ...> ON customers.customer_id = orders.customer_id;
Alice|Laptop
Alice|Tablet
Bob|Smartphone
Charlie|
sqlite> SELECT products.product_name, suppliers.supplier_name
   ...> FROM products
   ...> LEFT JOIN product_suppliers
   ...> ON products.product_id = product_suppliers.product_id
   ...> LEFT JOIN suppliers
   ...> ON product_suppliers.supplier_id = suppliers.supplier_id;
Parse error: no such table: products
sqlite> CREATE TABLE products (
(x1...>   product_id INTEGER PRIMARY KEY,
(x1...>   product_name TEXT
(x1...> );
sqlite> CREATE TABLE suppliers (
(x1...>   supplier_id INTEGER PRIMARY KEY,
(x1...>   supplier_name TEXT
(x1...> );
sqlite> CREATE TABLE product_suppliers (
(x1...>   product_id INTEGER,
(x1...>   supplier_id INTEGER,
(x1...>   FOREIGN KEY (product_id) REFERENCES products(product_id),
(x1...>   FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
(x1...> );
sqlite> INSERT INTO products (product_name) VALUES ('Laptop');
sqlite> INSERT INTO products (product_name) VALUES ('Tablet');
sqlite> INSERT INTO products (product_name) VALUES ('Smartphone');
sqlite> INSERT INTO suppliers (supplier_name) VALUES ('TechCorp');
sqlite> INSERT INTO suppliers (supplier_name) VALUES ('GadgetCo');
sqlite> INSERT INTO product_suppliers (product_id, supplier_id) VALUES (1, 1);  -- Laptop from TechCorp
sqlite> INSERT INTO product_suppliers (product_id, supplier_id) VALUES (2, 2);  -- Tablet from GadgetCo
sqlite> SELECT products.product_name, suppliers.supplier_name
   ...> FROM products
   ...> LEFT JOIN product_suppliers
   ...> ON products.product_id = product_suppliers.product_id
   ...> LEFT JOIN suppliers
   ...> ON product_suppliers.supplier_id = suppliers.supplier_id;
Laptop|TechCorp
Tablet|GadgetCo
Smartphone|
sqlite> -- First part: Left Join to get employees (even without departments)
sqlite> SELECT employees.employee_name, departments.department_name
   ...> FROM employees
   ...> LEFT JOIN departments
   ...> ON employees.department_id = departments.department_id
   ...>
   ...> UNION
   ...>
   ...> -- Second part: Left Join to get departments (even without employees)
   ...> SELECT employees.employee_name, departments.department_name
   ...> FROM departments
   ...> LEFT JOIN employees
   ...> ON employees.department_id = departments.department_id;
Parse error: no such table: departments
sqlite> CREATE TABLE employees (
(x1...>   employee_id INTEGER PRIMARY KEY,
(x1...>   employee_name TEXT,
(x1...>   department_id INTEGER,
(x1...>   FOREIGN KEY (department_id) REFERENCES departments(department_id)
(x1...> );
sqlite> CREATE TABLE departments (
(x1...>   department_id INTEGER PRIMARY KEY,
(x1...>   department_name TEXT
(x1...> );
sqlite> INSERT INTO departments (department_name) VALUES ('HR');
sqlite> INSERT INTO departments (department_name) VALUES ('Engineering');
sqlite> INSERT INTO departments (department_name) VALUES ('Sales');
sqlite> INSERT INTO employees (employee_name, department_id) VALUES ('Alice', 1);  -- HR
sqlite> INSERT INTO employees (employee_name, department_id) VALUES ('Bob', 2);    -- Engineering
sqlite> INSERT INTO employees (employee_name, department_id) VALUES ('Charlie', NULL);  -- No Department
sqlite> -- First part: Left Join to get employees (even without departments)
sqlite> SELECT employees.employee_name, departments.department_name
   ...> FROM employees
   ...> LEFT JOIN departments
   ...> ON employees.department_id = departments.department_id
   ...>
   ...> UNION
   ...>
   ...> -- Second part: Left Join to get departments (even without employees)
   ...> SELECT employees.employee_name, departments.department_name
   ...> FROM departments
   ...> LEFT JOIN employees
   ...> ON employees.department_id = departments.department_id;
|Sales
Alice|HR
Bob|Engineering
Charlie|
sqlite> SELECT e.employee_name AS employee, m.employee_name AS manager
   ...> FROM employees e
   ...> LEFT JOIN employees m
   ...> ON e.manager_id = m.employee_id;
Parse error: no such column: e.manager_id
sqlite> CREATE TABLE employees (
(x1...>   employee_id INTEGER PRIMARY KEY,
(x1...>   employee_name TEXT,
(x1...>   manager_id INTEGER,
(x1...>   FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
(x1...> );
Parse error: table employees already exists
  CREATE TABLE employees (   employee_id INTEGER PRIMARY KEY,   employee_name TE
               ^--- error here
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('Alice', NULL);   -- Alice has no manager
Parse error: table employees has no column named manager_id
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('Bob', 1);        -- Bob's manager is Alice
Parse error: table employees has no column named manager_id
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('Charlie', 1);    -- Charlie's manager is Alice
Parse error: table employees has no column named manager_id
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('David', 2);      -- David's manager is Bob
Parse error: table employees has no column named manager_id
sqlite> SELECT e.employee_name AS employee, m.employee_name AS manager
   ...> FROM employees e
   ...> LEFT JOIN employees m
   ...> ON e.manager_id = m.employee_id;
Parse error: no such column: e.manager_id
sqlite> ALTER TABLE employees ADD COLUMN manager_id INTEGER;
sqlite> DROP TABLE employees;
sqlite> CREATE TABLE employees (
(x1...>   employee_id INTEGER PRIMARY KEY,
(x1...>   employee_name TEXT,
(x1...>   manager_id INTEGER,
(x1...>   FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
(x1...> );
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('Alice', NULL);   -- Alice has no manager
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('Bob', 1);        -- Bob's manager is Alice
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('Charlie', 1);    -- Charlie's manager is Alice
sqlite> INSERT INTO employees (employee_name, manager_id) VALUES ('David', 2);      -- David's manager is Bob
sqlite> SELECT e.employee_name AS employee, m.employee_name AS manager
   ...> FROM employees e
   ...> LEFT JOIN employees m
   ...> ON e.manager_id = m.employee_id;
Alice|
Bob|Alice
Charlie|Alice
David|Bob
sqlite> SELECT products.product_name, customers.customer_name
   ...> FROM products
   ...> CROSS JOIN customers;
Laptop|Alice
Laptop|Bob
Laptop|Charlie
Tablet|Alice
Tablet|Bob
Tablet|Charlie
Smartphone|Alice
Smartphone|Bob
Smartphone|Charlie
sqlite> SELECT *
   ...> FROM customers
   ...> NATURAL JOIN orders;
1|Alice|1|Laptop
2|Bob|2|Smartphone
1|Alice|3|Tablet
sqlite> SELECT c.customer_name, COUNT(o.product_id) AS total_products_ordered
   ...> FROM customers c
   ...> JOIN orders o ON c.customer_id = o.customer_id
   ...> GROUP BY c.customer_name;
Parse error: no such column: o.product_id
  SELECT c.customer_name, COUNT(o.product_id) AS total_products_ordered FROM cus
                  error here ---^
sqlite> CREATE TABLE customers (
(x1...>   customer_id INTEGER PRIMARY KEY,
(x1...>   customer_name TEXT
(x1...> );
Parse error: table customers already exists
  CREATE TABLE customers (   customer_id INTEGER PRIMARY KEY,   customer_name TE
               ^--- error here
sqlite> INSERT INTO customers (customer_name) VALUES ('Alice');
sqlite> INSERT INTO customers (customer_name) VALUES ('Bob');
sqlite> INSERT INTO customers (customer_name) VALUES ('Charlie');
sqlite> SELECT c.customer_name, COUNT(o.product_id) AS total_products_ordered
   ...> FROM customers c
   ...> JOIN orders o ON c.customer_id = o.customer_id
   ...> GROUP BY c.customer_name;
Parse error: no such column: o.product_id
  SELECT c.customer_name, COUNT(o.product_id) AS total_products_ordered FROM cus
                  error here ---^
sqlite> .tables
customers          employees          product_suppliers  suppliers
departments        orders             products
sqlite> PRAGMA table_info(orders);
0|order_id|INTEGER|0||1
1|customer_id|INTEGER|0||0
2|product_name|TEXT|0||0
sqlite> DROP TABLE IF EXISTS orders;
sqlite> DROP TABLE IF EXISTS customers;
sqlite> CREATE TABLE customers (
(x1...>   customer_id INTEGER PRIMARY KEY,
(x1...>   customer_name TEXT
(x1...> );
sqlite> CREATE TABLE orders (
(x1...>   order_id INTEGER PRIMARY KEY,
(x1...>   customer_id INTEGER,
(x1...>   product_id INTEGER,
(x1...>   FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
(x1...> );
sqlite> INSERT INTO customers (customer_name) VALUES ('Alice');
sqlite> INSERT INTO customers (customer_name) VALUES ('Bob');
sqlite> INSERT INTO customers (customer_name) VALUES ('Charlie');
sqlite>
sqlite> INSERT INTO orders (customer_id, product_id) VALUES (1, 101);  -- Order by Alice
sqlite> INSERT INTO orders (customer_id, product_id) VALUES (1, 102);  -- Another order by Alice
sqlite> INSERT INTO orders (customer_id, product_id) VALUES (2, 103);  -- Order by Bob
sqlite> INSERT INTO orders (customer_id, product_id) VALUES (3, 104);  -- Order by Charlie
sqlite> INSERT INTO orders (customer_id, product_id) VALUES (2, 105);  -- Another order by Bob
sqlite> SELECT c.customer_name, COUNT(o.product_id) AS total_products_ordered
   ...> FROM customers c
   ...> JOIN orders o ON c.customer_id = o.customer_id
   ...> GROUP BY c.customer_name;
Alice|2
Bob|2
Charlie|1
sqlite> SELECT
   ...>     c.customer_name,
   ...>     p.product_name,
   ...>     o.order_date
   ...> FROM
   ...>     customers c
   ...> JOIN
   ...>     orders o ON c.customer_id = o.customer_id
   ...> JOIN
   ...>     products p ON o.product_id = p.product_id;
Parse error: no such column: o.order_date
  T      c.customer_name,      p.product_name,      o.order_date FROM      custo
                                      error here ---^
sqlite> CREATE TABLE customers (
(x1...>   customer_id INTEGER PRIMARY KEY,
(x1...>   customer_name TEXT
(x1...> );
Parse error: table customers already exists
  CREATE TABLE customers (   customer_id INTEGER PRIMARY KEY,   customer_name TE
               ^--- error here
sqlite> CREATE TABLE products (
(x1...>   product_id INTEGER PRIMARY KEY,
(x1...>   product_name TEXT
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (   product_id INTEGER PRIMARY KEY,   product_name TEXT
               ^--- error here
sqlite> CREATE TABLE orders (
(x1...>   order_id INTEGER PRIMARY KEY,
(x1...>   customer_id INTEGER,
(x1...>   product_id INTEGER,
(x1...>   order_date TEXT,
(x1...>   FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
(x1...>   FOREIGN KEY (product_id) REFERENCES products(product_id)
(x1...> );
Parse error: table orders already exists
  CREATE TABLE orders (   order_id INTEGER PRIMARY KEY,   customer_id INTEGER,
               ^--- error here
sqlite> -- Inserting data into customers
sqlite> INSERT INTO customers (customer_name) VALUES ('Alice');
sqlite> INSERT INTO customers (customer_name) VALUES ('Bob');
sqlite> INSERT INTO customers (customer_name) VALUES ('Charlie');
sqlite>
sqlite> -- Inserting data into products
sqlite> INSERT INTO products (product_name) VALUES ('Product A');
sqlite> INSERT INTO products (product_name) VALUES ('Product B');
sqlite> INSERT INTO products (product_name) VALUES ('Product C');
sqlite>
sqlite> -- Inserting data into orders
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (1, 1, '2024-10-01');  -- Alice ordered Product A
Parse error: table orders has no column named order_date
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (1, 2, '2024-10-02');  -- Alice ordered Product B
Parse error: table orders has no column named order_date
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (2, 1, '2024-10-01');  -- Bob ordered Product A
Parse error: table orders has no column named order_date
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (3, 3, '2024-10-03');  -- Charlie ordered Product C
Parse error: table orders has no column named order_date
sqlite> -- List all tables in the database
sqlite> .tables
customers          employees          product_suppliers  suppliers
departments        orders             products
sqlite>
sqlite> -- Show the schema for the orders table
sqlite> .schema orders
CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  product_id INTEGER,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
sqlite> DROP TABLE IF EXISTS orders;
sqlite> DROP TABLE IF EXISTS products;
sqlite> DROP TABLE IF EXISTS customers;
sqlite> CREATE TABLE customers (
(x1...>   customer_id INTEGER PRIMARY KEY,
(x1...>   customer_name TEXT
(x1...> );
sqlite>
sqlite> CREATE TABLE products (
(x1...>   product_id INTEGER PRIMARY KEY,
(x1...>   product_name TEXT
(x1...> );
sqlite>
sqlite> CREATE TABLE orders (
(x1...>   order_id INTEGER PRIMARY KEY,
(x1...>   customer_id INTEGER,
(x1...>   product_id INTEGER,
(x1...>   order_date TEXT,
(x1...>   FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
(x1...>   FOREIGN KEY (product_id) REFERENCES products(product_id)
(x1...> );
sqlite> -- Inserting data into customers
sqlite> INSERT INTO customers (customer_name) VALUES ('Alice');
sqlite> INSERT INTO customers (customer_name) VALUES ('Bob');
sqlite> INSERT INTO customers (customer_name) VALUES ('Charlie');
sqlite>
sqlite> -- Inserting data into products
sqlite> INSERT INTO products (product_name) VALUES ('Product A');
sqlite> INSERT INTO products (product_name) VALUES ('Product B');
sqlite> INSERT INTO products (product_name) VALUES ('Product C');
sqlite>
sqlite> -- Inserting data into orders
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (1, 1, '2024-10-01');  -- Alice ordered Product A
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (1, 2, '2024-10-02');  -- Alice ordered Product B
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (2, 1, '2024-10-01');  -- Bob ordered Product A
sqlite> INSERT INTO orders (customer_id, product_id, order_date) VALUES (3, 3, '2024-10-03');  -- Charlie ordered Product C
sqlite> SELECT
   ...>     c.customer_name,
   ...>     p.product_name,
   ...>     o.order_date
   ...> FROM
   ...>     customers c
   ...> JOIN
   ...>     orders o ON c.customer_id = o.customer_id
   ...> JOIN
   ...>     products p ON o.product_id = p.product_id;
Alice|Product A|2024-10-01
Alice|Product B|2024-10-02
Bob|Product A|2024-10-01
Charlie|Product C|2024-10-03
sqlite> COMMIT;
Runtime error: cannot commit - no transaction is active
sqlite> COMMIT;
Runtime error: cannot commit - no transaction is active
sqlite> CREATE TABLE authors (
(x1...>     author_id INTEGER PRIMARY KEY,
(x1...>     author_name TEXT NOT NULL
(x1...> );
sqlite> CREATE TABLE books (
(x1...>     book_id INTEGER PRIMARY KEY,
(x1...>     book_title TEXT NOT NULL,
(x1...>     author_id INTEGER,
(x1...>     FOREIGN KEY (author_id) REFERENCES authors(author_id)
(x1...> );
sqlite> INSERT INTO authors (author_name) VALUES ('Agatha Christie');
sqlite> INSERT INTO authors (author_name) VALUES ('Mark Twain');
sqlite> INSERT INTO books (book_title, author_id) VALUES ('Murder on the Orient Express', 1);   -- References Agatha Christie
sqlite> INSERT INTO books (book_title, author_id) VALUES ('The Adventures of Tom Sawyer', 2);   -- References Mark Twain
sqlite> INSERT INTO books (book_title, author_id) VALUES ('And Then There Were None', 1);       -- References Agatha Christie
sqlite> INSERT INTO books (book_title, author_id) VALUES ('Unknown Book', 999);
sqlite> SELECT
   ...>     b.book_title,
   ...>     a.author_name
   ...> FROM
   ...>     books b
   ...> JOIN
   ...>     authors a ON b.author_id = a.author_id;
Murder on the Orient Express|Agatha Christie
The Adventures of Tom Sawyer|Mark Twain
And Then There Were None|Agatha Christie
sqlite> CREATE TABLE categories (
(x1...>     category_id INTEGER PRIMARY KEY,
(x1...>     category_name TEXT NOT NULL
(x1...> );
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     category_id INTEGER,
(x1...>     FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> INSERT INTO categories (category_name) VALUES ('Electronics');
sqlite> INSERT INTO categories (category_name) VALUES ('Furniture');
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Smartphone', 1);  -- Electronics
Parse error: table products has no column named category_id
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Laptop', 1);      -- Electronics
Parse error: table products has no column named category_id
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Sofa', 2);        -- Furniture
Parse error: table products has no column named category_id
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Table', 2);       -- Furniture
Parse error: table products has no column named category_id
sqlite> DELETE FROM categories WHERE category_id = 1;
sqlite> SELECT * FROM products;
1|Product A
2|Product B
3|Product C
sqlite> DROP TABLE IF EXISTS products;
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     category_id INTEGER,
(x1...>     FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
(x1...> );
sqlite> INSERT INTO categories (category_name) VALUES ('Electronics');
sqlite> INSERT INTO categories (category_name) VALUES ('Furniture');
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Smartphone', 1);  -- Electronics
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Laptop', 1);      -- Electronics
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Sofa', 2);        -- Furniture
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Table', 2);       -- Furniture
sqlite> SELECT * FROM products;
1|Smartphone|1
2|Laptop|1
3|Sofa|2
4|Table|2
sqlite> DELETE FROM categories WHERE category_id = 1;  -- This will delete 'Electronics' and its related products.
sqlite> SELECT * FROM products;
1|Smartphone|1
2|Laptop|1
3|Sofa|2
4|Table|2
sqlite> PRAGMA foreign_keys = ON;
sqlite> PRAGMA foreign_keys = ON;
sqlite> DELETE FROM categories WHERE category_id = 1;  -- Delete 'Electronics' category
sqlite> SELECT * FROM products;  -- The products related to 'Electronics' should be gone now.
1|Smartphone|1
2|Laptop|1
3|Sofa|2
4|Table|2
sqlite> PRAGMA foreign_keys;
1
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     category_id INTEGER,
(x1...>     FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> DELETE FROM products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> PRAGMA foreign_keys = OFF;
sqlite> DELETE FROM products;
sqlite> DROP TABLE IF EXISTS products;
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     category_id INTEGER,
(x1...>     FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
(x1...> );
sqlite> PRAGMA foreign_keys = ON;
sqlite> -- Insert into categories
sqlite> INSERT INTO categories (category_name) VALUES ('Electronics');
sqlite> INSERT INTO categories (category_name) VALUES ('Furniture');
sqlite>
sqlite> -- Insert into products
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Smartphone', 1);
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Laptop', 1);
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Sofa', 2);
sqlite> INSERT INTO products (product_name, category_id) VALUES ('Table', 2);
sqlite>
sqlite> -- Delete Electronics category
sqlite> DELETE FROM categories WHERE category_id = 1;
sqlite>
sqlite> -- Check remaining products (Furniture products should remain)
sqlite> SELECT * FROM products;
1|Sofa|2
2|Table|2
sqlite> CREATE TABLE customers (
(x1...>     customer_id INTEGER PRIMARY KEY,
(x1...>     customer_name TEXT
(x1...> );
Parse error: table customers already exists
  CREATE TABLE customers (     customer_id INTEGER PRIMARY KEY,     customer_nam
               ^--- error here
sqlite>
sqlite> INSERT INTO customers (customer_name) VALUES ('Alice');  -- customer_id = 1
sqlite> INSERT INTO customers (customer_name) VALUES ('Bob');    -- customer_id = 2
sqlite> CREATE TABLE orders (
(x1...>     order_id INTEGER PRIMARY KEY,
(x1...>     customer_id INTEGER,
(x1...>     order_date TEXT,
(x1...>     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
(x1...> );
Parse error: table orders already exists
  CREATE TABLE orders (     order_id INTEGER PRIMARY KEY,     customer_id INTEGE
               ^--- error here
sqlite> DROP TABLE IF EXISTS orders;  -- Drop the orders table if it exists
sqlite> DROP TABLE IF EXISTS customers;  -- Drop the customers table if it exists
sqlite> CREATE TABLE customers (
(x1...>     customer_id INTEGER PRIMARY KEY,
(x1...>     customer_name TEXT
(x1...> );
sqlite>
sqlite> CREATE TABLE orders (
(x1...>     order_id INTEGER PRIMARY KEY,
(x1...>     customer_id INTEGER,
(x1...>     order_date TEXT,
(x1...>     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
(x1...> );
sqlite> INSERT INTO customers (customer_name) VALUES ('Alice');  -- customer_id = 1
sqlite> INSERT INTO customers (customer_name) VALUES ('Bob');    -- customer_id = 2
sqlite>
sqlite> INSERT INTO orders (customer_id, order_date) VALUES (1, '2024-10-07');  -- Valid insertion for Alice
sqlite> INSERT INTO orders (customer_id, order_date) VALUES (3, '2024-10-08');  -- This will cause an error since customer_id = 3 doesn't exist
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> -- Insert a valid order for Alice (customer_id = 1)
sqlite> INSERT INTO orders (customer_id, order_date) VALUES (1, '2024-10-07');  -- Valid insertion for Alice
sqlite>
sqlite> -- Insert a valid order for Bob (customer_id = 2)
sqlite> INSERT INTO orders (customer_id, order_date) VALUES (2, '2024-10-08');  -- Valid insertion for Bob
sqlite>
sqlite> -- The following line will fail because customer_id = 3 does not exist in the customers table
sqlite> -- INSERT INTO orders (customer_id, order_date) VALUES (3, '2024-10-09');  -- Invalid insertion
sqlite> CREATE TABLE users (
(x1...>     user_id INTEGER PRIMARY KEY,
(x1...>     user_name TEXT NOT NULL,
(x1...>     email TEXT NOT NULL UNIQUE  -- Unique constraint on the email column
(x1...> );
sqlite> INSERT INTO users (user_name, email) VALUES ('Alice', 'alice@example.com');
sqlite> INSERT INTO users (user_name, email) VALUES ('Bob', 'bob@example.com');
sqlite> -- The following line will fail because the email already exists
sqlite> INSERT INTO users (user_name, email) VALUES ('Charlie', 'alice@example.com');  -- This will cause an error
Runtime error: UNIQUE constraint failed: users.email (19)
sqlite> INSERT INTO users (user_name, email) VALUES ('Charlie', 'charlie@example.com');  -- This will succeed
sqlite> -- Drop the table if it exists to avoid conflicts
sqlite> DROP TABLE IF EXISTS users;
sqlite>
sqlite> -- Create the users table with a unique constraint on the email column
sqlite> CREATE TABLE users (
(x1...>     user_id INTEGER PRIMARY KEY,
(x1...>     user_name TEXT NOT NULL,
(x1...>     email TEXT UNIQUE  -- This ensures that email addresses must be unique
(x1...> );
sqlite>
sqlite> -- Insert valid users
sqlite> INSERT INTO users (user_name, email) VALUES ('Alice', 'alice@example.com');
sqlite> INSERT INTO users (user_name, email) VALUES ('Bob', 'bob@example.com');
sqlite>
sqlite> -- Attempt to insert a user with a duplicate email
sqlite> -- This will fail because 'alice@example.com' is already taken
sqlite> INSERT INTO users (user_name, email) VALUES ('Charlie', 'alice@example.com');  -- This will cause an error
Runtime error: UNIQUE constraint failed: users.email (19)
sqlite> -- Insert another user with a unique email
sqlite> INSERT INTO users (user_name, email) VALUES ('Charlie', 'charlie@example.com');  -- This should succeed
sqlite> SELECT * FROM users;
1|Alice|alice@example.com
2|Bob|bob@example.com
3|Charlie|charlie@example.com
sqlite> -- Drop the table if it exists to avoid conflicts
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> -- Create the products table with a CHECK constraint on the price column
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> -- Drop the table if it exists to avoid conflicts
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> -- Create the products table with a CHECK constraint on the price column
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> -- Insert valid products
sqlite> INSERT INTO products (product_name, price) VALUES ('Laptop', 1000.00);  -- Valid
Parse error: table products has no column named price
sqlite> INSERT INTO products (product_name, price) VALUES ('Smartphone', 700.00);  -- Valid
Parse error: table products has no column named price
sqlite>
sqlite> -- Attempt to insert a product with an invalid price
sqlite> INSERT INTO products (product_name, price) VALUES ('Cheap Gadget', -50.00);  -- This will cause an error
Parse error: table products has no column named price
sqlite> -- Drop the products table if it exists
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> -- Create the products table with a CHECK constraint on the price column
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> -- Drop the products table if it exists
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> -- Create the products table with a CHECK constraint on the price column
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> -- Insert valid products
sqlite> INSERT INTO products (product_name, price) VALUES ('Laptop', 1000.00);  -- Valid
Parse error: table products has no column named price
sqlite> INSERT INTO products (product_name, price) VALUES ('Smartphone', 700.00);  -- Valid
Parse error: table products has no column named price
sqlite>
sqlite> -- Attempt to insert a product with an invalid price
sqlite> INSERT INTO products (product_name, price) VALUES ('Cheap Gadget', -50.00);  -- This will cause an error
Parse error: table products has no column named price
sqlite> -- Drop the products table if it exists to avoid conflicts
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> -- Create the products table with a CHECK constraint on the price column
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> -- Insert valid products
sqlite> INSERT INTO products (product_name, price) VALUES ('Laptop', 1000.00);  -- Valid
Parse error: table products has no column named price
sqlite> INSERT INTO products (product_name, price) VALUES ('Smartphone', 700.00);  -- Valid
Parse error: table products has no column named price
sqlite>
sqlite> -- Attempt to insert a product with an invalid price
sqlite> INSERT INTO products (product_name, price) VALUES ('Cheap Gadget', -50.00);  -- This will cause an error
Parse error: table products has no column named price
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> -- Step 1: Check for foreign keys in dependent tables
sqlite> PRAGMA foreign_key_list(order_items);  -- Check if this table references products
sqlite>
sqlite> -- Step 2: Drop dependent tables
sqlite> DROP TABLE IF EXISTS order_items;  -- Drop the dependent table first
sqlite>
sqlite> -- Step 3: Now drop the products table
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> -- Step 4: Create the products table again
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> .tables
authors            customers          orders             suppliers
books              departments        product_suppliers  users
categories         employees          products
sqlite> PRAGMA foreign_key_list(order_items);  -- Check if this table references products
sqlite> PRAGMA foreign_key_list(inventory);  -- Check another table, if applicable
sqlite> DROP TABLE IF EXISTS order_items;  -- or any other tables that reference products
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> -- Step 1: List tables
sqlite> .tables
authors            customers          orders             suppliers
books              departments        product_suppliers  users
categories         employees          products
sqlite>
sqlite> -- Step 2: Check foreign keys for dependent tables
sqlite> PRAGMA foreign_key_list(order_items);
sqlite> PRAGMA foreign_key_list(inventory);
sqlite> -- Repeat for any other relevant tables
sqlite>
sqlite> -- Step 3: Drop dependent tables
sqlite> DROP TABLE IF EXISTS order_items;  -- Adjust according to your findings
sqlite> DROP TABLE IF EXISTS inventory;     -- Adjust according to your findings
sqlite>
sqlite> -- Step 4: Now drop the products table
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite>
sqlite> -- Step 5: Create the products table again
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> .tables
authors            customers          orders             suppliers
books              departments        product_suppliers  users
categories         employees          products
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> PRAGMA foreign_key_list(order_items);  -- Check if this table references products
sqlite> PRAGMA foreign_key_list(inventory);     -- Check any other potential tables
sqlite> DROP TABLE IF EXISTS order_items;  -- Drop any dependent tables you identified
sqlite> DROP TABLE IF EXISTS inventory;     -- Do the same for others as needed
sqlite> DROP TABLE IF EXISTS products;
Runtime error: FOREIGN KEY constraint failed (19)
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
Parse error: table products already exists
  CREATE TABLE products (     product_id INTEGER PRIMARY KEY,     product_name T
               ^--- error here
sqlite> PRAGMA foreign_key_list(orders);           -- Check if this table references products
0|0|customers|customer_id|customer_id|NO ACTION|NO ACTION|NONE
sqlite> PRAGMA foreign_key_list(order_items);      -- Check if this table references products
sqlite> PRAGMA foreign_key_list(inventory);        -- Check if this table references products
sqlite> PRAGMA foreign_key_list(product_suppliers);-- Check if this table references products
0|0|suppliers|supplier_id|supplier_id|NO ACTION|NO ACTION|NONE
1|0|products|product_id|product_id|NO ACTION|NO ACTION|NONE
sqlite> DROP TABLE IF EXISTS order_items;        -- Drop dependent table first
sqlite> DROP TABLE IF EXISTS product_suppliers;  -- Drop dependent table first
sqlite> DROP TABLE IF EXISTS inventory;           -- Drop dependent table first
sqlite> DROP TABLE IF EXISTS products;
sqlite> CREATE TABLE products (
(x1...>     product_id INTEGER PRIMARY KEY,
(x1...>     product_name TEXT NOT NULL,
(x1...>     price REAL CHECK (price > 0)  -- This ensures that the price must be greater than 0
(x1...> );
sqlite> CREATE TABLE courses (
(x1...>     course_id INTEGER,
(x1...>     course_name TEXT NOT NULL,
(x1...>     department_id INTEGER,
(x1...>     PRIMARY KEY (course_id, department_id)  -- Composite primary key
(x1...> );-- Insert courses into the table
sqlite> INSERT INTO courses (course_id, course_name, department_id) VALUES (101, 'Database Systems', 1);
sqlite> INSERT INTO courses (course_id, course_name, department_id) VALUES (102, 'Data Structures', 1);
sqlite> INSERT INTO courses (course_id, course_name, department_id) VALUES (101, 'Introduction to AI', 2);  -- Same course_id, different department
sqlite> SELECT * FROM courses;
101|Database Systems|1
102|Data Structures|1
101|Introduction to AI|2
sqlite> CREATE TABLE students (
(x1...>     student_id INTEGER PRIMARY KEY,
(x1...>     student_name TEXT NOT NULL
(x1...> );
sqlite> CREATE TABLE courses (
(x1...>     course_id INTEGER PRIMARY KEY,
(x1...>     course_name TEXT NOT NULL
(x1...> );
Parse error: table courses already exists
  CREATE TABLE courses (     course_id INTEGER PRIMARY KEY,     course_name TEXT
               ^--- error here
sqlite> DROP TABLE IF EXISTS courses;
sqlite> CREATE TABLE courses (
(x1...>     course_id INTEGER PRIMARY KEY,
(x1...>     course_name TEXT NOT NULL
(x1...> );
sqlite> CREATE TABLE student_courses (
(x1...>     student_id INTEGER,
(x1...>     course_id INTEGER,
(x1...>     PRIMARY KEY (student_id, course_id),
(x1...>     FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
(x1...>     FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
(x1...> );-- Insert students
sqlite> INSERT INTO students (student_name) VALUES ('Alice');
sqlite> INSERT INTO students (student_name) VALUES ('Bob');
sqlite>
sqlite> -- Insert courses
sqlite> INSERT INTO courses (course_name) VALUES ('Database Systems');
sqlite> INSERT INTO courses (course_name) VALUES ('Data Structures');
sqlite>
sqlite> -- Insert valid student_courses entries
sqlite> INSERT INTO student_courses (student_id, course_id) VALUES (1, 1);  -- Alice enrolled in Database Systems
sqlite> INSERT INTO student_courses (student_id, course_id) VALUES (2, 2);  -- Bob enrolled in Data Structures
sqlite> -- Drop the table if it exists to avoid conflicts
sqlite> DROP TABLE IF EXISTS users;
sqlite>
sqlite> -- Create the users table with NOT NULL constraints on username and email
sqlite> CREATE TABLE users (
(x1...>     user_id INTEGER PRIMARY KEY,
(x1...>     username TEXT NOT NULL,  -- This ensures that the username cannot be null
(x1...>     email TEXT NOT NULL      -- This ensures that the email cannot be null
(x1...> );
sqlite> INSERT INTO users (username, email) VALUES ('Alice', 'alice@example.com');
sqlite> INSERT INTO users (username, email) VALUES ('Bob', 'bob@example.com');
sqlite> SELECT * FROM users;
1|Alice|alice@example.com
2|Bob|bob@example.com
sqlite> SELECT * FROM students;
1|Alice
2|Bob
sqlite> SELECT * FROM courses;
1|Database Systems
2|Data Structures
sqlite> SELECT * FROM student_courses;
1|1
2|2
sqlite> CREATE TABLE IF NOT EXISTS employees (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL
(x1...> );
sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...> SELECT employee_id, employee_name, salary FROM employees;
Parse error: no such table: employees_new
sqlite> DROP TABLE employees;
sqlite> ALTER TABLE employees_new RENAME TO employees;
Parse error: no such table: employees_new
sqlite> -- Step 1: Create the employees table if it doesn't exist
sqlite> CREATE TABLE IF NOT EXISTS employees (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL
(x1...> );
sqlite>
sqlite> -- Step 2: Create a new employees table with the CHECK constraint
sqlite> CREATE TABLE employees_new (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL CHECK (salary > 0)
(x1...> );
sqlite>
sqlite> -- Step 3: Insert some sample data into the original employees table
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Alice', 50000);
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Bob', 60000);
sqlite> -- INSERT INTO employees (employee_name, salary) VALUES ('Charlie', -10000);  -- This would be invalid
sqlite>
sqlite> -- Step 4: Copy data from the old employees table to the new table
sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...> SELECT employee_id, employee_name, salary FROM employees;
sqlite>
sqlite> -- Step 5: Drop the old employees table
sqlite> DROP TABLE employees;
sqlite>
sqlite> -- Step 6: Rename the new table to the original table name
sqlite> ALTER TABLE employees_new RENAME TO employees;
sqlite>
sqlite> -- Now the employees table has a CHECK constraint on salary
sqlite> PRAGMA table_info(employees);
0|employee_id|INTEGER|0||1
1|employee_name|TEXT|1||0
2|salary|REAL|0||0
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Alice', 50000);
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Bob', -5000);
Runtime error: CHECK constraint failed: salary > 0 (19)
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Charlie', 60000);
sqlite> SELECT * FROM employees;
1|Alice|50000.0
2|Bob|60000.0
3|Alice|50000.0
4|Charlie|60000.0
sqlite> sqlite> -- Step 1: Create the employees table if it doesn't exist
   ...> sqlite> CREATE TABLE IF NOT EXISTS employees (
(x1...> (x1...>     employee_id INTEGER PRIMARY KEY,
(x2...> (x1...>     employee_name TEXT NOT NULL,
(x3...> (x1...>     salary REAL
(x4...> (x1...> );
Parse error: near "sqlite": syntax error
  sqlite> -- Step 1: Create the employees table if it doesn't exist sqlite> CREA
  ^--- error here
sqlite> sqlite>
   ...> sqlite> -- Step 2: Create a new employees table with the CHECK constraint
   ...> sqlite> CREATE TABLE employees_new (
(x1...> (x1...>     employee_id INTEGER PRIMARY KEY,
(x2...> (x1...>     employee_name TEXT NOT NULL,
(x3...> (x1...>     salary REAL CHECK (salary > 0)
(x4...> (x1...> );
Parse error: near "sqlite": syntax error
  sqlite> sqlite> -- Step 2: Create a new employees table with the CHECK constra
  ^--- error here
sqlite> sqlite>
   ...> sqlite> -- Step 3: Insert some sample data into the original employees table
   ...> sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Alice', 50000);
Parse error: near "sqlite": syntax error
  sqlite> sqlite> -- Step 3: Insert some sample data into the original employees
  ^--- error here
sqlite> sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Bob', 60000);
Parse error: near "sqlite": syntax error
  sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Bob', 60000);
  ^--- error here
sqlite> sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Charlie', 60000);
Parse error: near "sqlite": syntax error
  sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Charlie', 60000
  ^--- error here
sqlite> sqlite> -- INSERT INTO employees (employee_name, salary) VALUES ('Charlie', -10000);  -- This would be invalid
   ...> sqlite>
   ...> sqlite> -- Step 4: Copy data from the old employees table to the new table
   ...> sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...>    ...> SELECT employee_id, employee_name, salary FROM employees;
Parse error: near "sqlite": syntax error
  sqlite> -- INSERT INTO employees (employee_name, salary) VALUES ('Charlie', -1
  ^--- error here
sqlite> sqlite>
   ...> sqlite> -- Step 5: Drop the old employees table
   ...> sqlite> DROP TABLE employees;
Parse error: near "sqlite": syntax error
  sqlite> sqlite> -- Step 5: Drop the old employees table sqlite> DROP TABLE emp
  ^--- error here
sqlite> sqlite>
   ...> sqlite> -- Step 6: Rename the new table to the original table name
   ...> sqlite> ALTER TABLE employees_new RENAME TO employees;
Parse error: near "sqlite": syntax error
  sqlite> sqlite> -- Step 6: Rename the new table to the original table name sql
  ^--- error here
sqlite> sqlite>
   ...> sqlite> -- Now the employees table has a CHECK constraint on salary
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...>
   ...> CREATE TABLE IF NOT EXISTS employees (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL
(x1...> );
Parse error: near "sqlite": syntax error
  sqlite> sqlite> -- Now the employees table has a CHECK constraint on salary
  ^--- error here
sqlite> CREATE TABLE employees_new (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL CHECK (salary > 0)
(x1...> );
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Alice', 50000);
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Bob', 60000);
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Charlie', 60000);
sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...> SELECT employee_id, employee_name, salary FROM employees;
sqlite> DROP TABLE employees;
sqlite> ALTER TABLE employees_new RENAME TO employees;
sqlite> SELECT * FROM employees;
1|Alice|50000.0
2|Bob|60000.0
3|Alice|50000.0
4|Charlie|60000.0
5|Alice|50000.0
6|Bob|60000.0
7|Charlie|60000.0
sqlite> -- Step 1: Drop the old employees_new table if it exists
sqlite> DROP TABLE IF EXISTS employees_new;
sqlite>
sqlite> -- Step 2: Create the new employees table with a CHECK constraint
sqlite> CREATE TABLE employees_new (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL CHECK (salary > 0)
(x1...> );
sqlite>
sqlite> -- Step 3: Copy data from the old employees table to the new table
sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...> SELECT employee_id, employee_name, salary FROM employees;
sqlite>
sqlite> -- Step 4: Drop the old employees table
sqlite> DROP TABLE employees;
sqlite>
sqlite> -- Step 5: Rename the new table to the original table name
sqlite> ALTER TABLE employees_new RENAME TO employees;
sqlite>
sqlite> -- Step 6: Check the output
sqlite> SELECT * FROM employees;
1|Alice|50000.0
2|Bob|60000.0
3|Alice|50000.0
4|Charlie|60000.0
5|Alice|50000.0
6|Bob|60000.0
7|Charlie|60000.0
sqlite> SELECT * FROM employees;
1|Alice|50000.0
2|Bob|60000.0
3|Alice|50000.0
4|Charlie|60000.0
5|Alice|50000.0
6|Bob|60000.0
7|Charlie|60000.0
sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...> SELECT DISTINCT employee_id, employee_name, salary FROM employees;
Parse error: no such table: employees_new
sqlite> -- Step 1: Drop the old employees table if it exists
sqlite> DROP TABLE IF EXISTS employees;
sqlite>
sqlite> -- Step 2: Create the employees table without CHECK constraint
sqlite> CREATE TABLE employees (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL
(x1...> );
sqlite>
sqlite> -- Step 3: Insert some sample data into the employees table
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Alice', 50000);
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Bob', 60000);
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Charlie', -10000);  -- This should be invalid later
sqlite>
sqlite> -- Step 4: Create the new employees table with the CHECK constraint
sqlite> CREATE TABLE employees_new (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL CHECK (salary > 0)
(x1...> );
sqlite>
sqlite> -- Step 5: Copy data from the old employees table to the new table
sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...> SELECT DISTINCT employee_id, employee_name, salary FROM employees;
Runtime error: CHECK constraint failed: salary > 0 (19)
sqlite>
sqlite> -- Step 6: Drop the old employees table
sqlite> DROP TABLE employees;
sqlite>
sqlite> -- Step 7: Rename the new table to the original table name
sqlite> ALTER TABLE employees_new RENAME TO employees;
sqlite>
sqlite> -- Step 8: Check the final output
sqlite> SELECT * FROM employees;
sqlite>
sqlite>  SELECT * FROM employees;
sqlite> SELECT * FROM employees;
sqlite> -- Step 1: Drop the old employees table if it exists
sqlite> DROP TABLE IF EXISTS employees;
sqlite>
sqlite> -- Step 2: Create the employees table without CHECK constraint
sqlite> CREATE TABLE employees (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL
(x1...> );
sqlite>
sqlite> -- Step 3: Insert some valid sample data into the employees table
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Alice', 50000);
sqlite> INSERT INTO employees (employee_name, salary) VALUES ('Bob', 60000);
sqlite> -- Do not insert an invalid salary
sqlite>
sqlite> -- Step 4: Create the new employees table with the CHECK constraint
sqlite> CREATE TABLE employees_new (
(x1...>     employee_id INTEGER PRIMARY KEY,
(x1...>     employee_name TEXT NOT NULL,
(x1...>     salary REAL CHECK (salary > 0)
(x1...> );
sqlite>
sqlite> -- Step 5: Copy valid data from the old employees table to the new table
sqlite> INSERT INTO employees_new (employee_id, employee_name, salary)
   ...> SELECT employee_id, employee_name, salary FROM employees WHERE salary > 0;
sqlite>
sqlite> -- Step 6: Drop the old employees table
sqlite> DROP TABLE employees;
sqlite>
sqlite> -- Step 7: Rename the new table to the original table name
sqlite> ALTER TABLE employees_new RENAME TO employees;
sqlite>
sqlite> -- Step 8: Check the final output
sqlite> SELECT * FROM employees;
1|Alice|50000.0
2|Bob|60000.0
sqlite> CREATE TABLE IF NOT EXISTS students (
(x1...>     student_id INTEGER PRIMARY KEY,
(x1...>     student_name TEXT NOT NULL
(x1...> );
sqlite> CREATE TABLE IF NOT EXISTS courses (
(x1...>     course_id INTEGER PRIMARY KEY,
(x1...>     course_name TEXT NOT NULL
(x1...> );
sqlite> CREATE TABLE student_courses (
(x1...>     student_id INTEGER,
(x1...>     course_id INTEGER,
(x1...>     PRIMARY KEY (student_id, course_id),
(x1...>     FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
(x1...>     FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
(x1...> );
Parse error: table student_courses already exists
  CREATE TABLE student_courses (     student_id INTEGER,     course_id INTEGER,
               ^--- error here
sqlite> DROP TABLE IF EXISTS student_courses;
sqlite> CREATE TABLE student_courses (
(x1...>     student_id INTEGER,
(x1...>     course_id INTEGER,
(x1...>     PRIMARY KEY (student_id, course_id),
(x1...>     FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
(x1...>     FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
(x1...> );
sqlite> .tables
authors          customers        products         users
books            departments      student_courses
categories       employees        students
courses          orders           suppliers
sqlite> -- Insert sample students
sqlite> INSERT INTO students (student_name) VALUES ('Alice');
sqlite> INSERT INTO students (student_name) VALUES ('Bob');
sqlite>
sqlite> -- Insert sample courses
sqlite> INSERT INTO courses (course_name) VALUES ('Database Systems');
sqlite> INSERT INTO courses (course_name) VALUES ('Data Structures');
sqlite> INSERT INTO student_courses (student_id, course_id) VALUES (1, 1);  -- Alice in Database Systems
sqlite> INSERT INTO student_courses (student_id, course_id) VALUES (2, 2);  -- Bob in Data Structures
sqlite> SELECT * FROM students;       -- Check students table
1|Alice
2|Bob
3|Alice
4|Bob
sqlite> SELECT * FROM courses;        -- Check courses table
1|Database Systems
2|Data Structures
3|Database Systems
4|Data Structures
sqlite> SELECT * FROM student_courses; -- Check student_courses table
1|1
2|2