-- ============================================
-- Insert Customers
-- ============================================

INSERT INTO customers
(customer_id, customer_name, gender, city, state, signup_date)
VALUES
(1, 'Aman Sharma', 'Male', 'Indore', 'Madhya Pradesh', '2025-01-15'),
(2, 'Priya Verma', 'Female', 'Bhopal', 'Madhya Pradesh', '2025-02-10'),
(3, 'Rahul Patel', 'Male', 'Indore', 'Madhya Pradesh', '2025-02-25'),
(4, 'Sneha Jain', 'Female', 'Ujjain', 'Madhya Pradesh', '2025-03-05'),
(5, 'Rohit Singh', 'Male', 'Jabalpur', 'Madhya Pradesh', '2025-03-18'),
(6, 'Neha Gupta', 'Female', 'Bhopal', 'Madhya Pradesh', '2025-04-02'),
(7, 'Arjun Mehta', 'Male', 'Indore', 'Madhya Pradesh', '2025-04-20'),
(8, 'Pooja Sharma', 'Female', 'Gwalior', 'Madhya Pradesh', '2025-05-12'),
(9, 'Vikas Yadav', 'Male', 'Sagar', 'Madhya Pradesh', '2025-06-08'),
(10, 'Kavya Patel', 'Female', 'Jabalpur', 'Madhya Pradesh', '2025-06-25'),
(11, 'Mohit Jain', 'Male', 'Ujjain', 'Madhya Pradesh', '2025-07-10'),
(12, 'Anjali Verma', 'Female', 'Indore', 'Madhya Pradesh', '2025-07-22'),
(13, 'Deepak Sharma', 'Male', 'Bhopal', 'Madhya Pradesh', '2025-08-15'),
(14, 'Riya Singh', 'Female', 'Gwalior', 'Madhya Pradesh', '2025-09-01'),
(15, 'Karan Patel', 'Male', 'Sagar', 'Madhya Pradesh', '2025-09-18');



-- ============================================
-- Insert Products
-- ============================================

INSERT INTO products
(product_id, product_name, category, sub_category, price)
VALUES
(101, 'Laptop', 'Electronics', 'Computers', 60000),
(102, 'Smartphone', 'Electronics', 'Mobiles', 30000),
(103, 'Headphones', 'Electronics', 'Accessories', 3000),
(104, 'Keyboard', 'Electronics', 'Accessories', 2000),
(105, 'Mouse', 'Electronics', 'Accessories', 1000),
(106, 'Office Chair', 'Furniture', 'Chairs', 8000),
(107, 'Study Table', 'Furniture', 'Tables', 12000),
(108, 'Bookshelf', 'Furniture', 'Storage', 7000),
(109, 'Running Shoes', 'Fashion', 'Footwear', 4000),
(110, 'T-Shirt', 'Fashion', 'Clothing', 1500),
(111, 'Jeans', 'Fashion', 'Clothing', 2500),
(112, 'Backpack', 'Fashion', 'Bags', 2000);



-- ============================================
-- Insert Orders
-- ============================================

INSERT INTO orders
(order_id, customer_id, order_date, payment_method, order_status)
VALUES
(1001, 1, '2025-10-05', 'UPI', 'Delivered'),
(1002, 2, '2025-10-08', 'Credit Card', 'Delivered'),
(1003, 3, '2025-10-15', 'UPI', 'Delivered'),
(1004, 4, '2025-10-22', 'Cash on Delivery', 'Delivered'),
(1005, 5, '2025-11-02', 'Debit Card', 'Delivered'),
(1006, 1, '2025-11-10', 'UPI', 'Delivered'),
(1007, 6, '2025-11-18', 'Credit Card', 'Delivered'),
(1008, 7, '2025-11-25', 'UPI', 'Cancelled'),
(1009, 8, '2025-12-03', 'Debit Card', 'Delivered'),
(1010, 2, '2025-12-10', 'UPI', 'Delivered'),
(1011, 9, '2025-12-18', 'Cash on Delivery', 'Delivered'),
(1012, 10, '2025-12-25', 'UPI', 'Delivered'),
(1013, 3, '2026-01-05', 'Credit Card', 'Delivered'),
(1014, 11, '2026-01-12', 'UPI', 'Delivered'),
(1015, 12, '2026-01-20', 'Debit Card', 'Delivered'),
(1016, 1, '2026-01-28', 'UPI', 'Delivered'),
(1017, 13, '2026-02-05', 'Credit Card', 'Delivered'),
(1018, 14, '2026-02-12', 'UPI', 'Delivered'),
(1019, 5, '2026-02-20', 'Debit Card', 'Delivered'),
(1020, 7, '2026-02-28', 'UPI', 'Delivered'),
(1021, 2, '2026-03-05', 'UPI', 'Delivered'),
(1022, 6, '2026-03-12', 'Credit Card', 'Delivered'),
(1023, 8, '2026-03-18', 'UPI', 'Cancelled'),
(1024, 10, '2026-03-25', 'Debit Card', 'Delivered'),
(1025, 15, '2026-04-02', 'UPI', 'Delivered'),
(1026, 3, '2026-04-10', 'Credit Card', 'Delivered'),
(1027, 4, '2026-04-18', 'UPI', 'Delivered'),
(1028, 1, '2026-04-25', 'Debit Card', 'Delivered'),
(1029, 9, '2026-05-05', 'UPI', 'Delivered'),
(1030, 11, '2026-05-12', 'Credit Card', 'Delivered'),
(1031, 12, '2026-05-20', 'UPI', 'Delivered'),
(1032, 5, '2026-05-28', 'Debit Card', 'Delivered');



-- ============================================
-- Insert Order Items
-- ============================================

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 1, 60000),
(2, 1001, 105, 2, 1000),
(3, 1002, 102, 1, 30000),
(4, 1002, 103, 1, 3000),
(5, 1003, 106, 1, 8000),
(6, 1003, 107, 1, 12000),
(7, 1004, 109, 2, 4000),
(8, 1005, 110, 3, 1500),
(9, 1005, 112, 1, 2000),
(10, 1006, 103, 2, 3000),
(11, 1006, 104, 1, 2000),
(12, 1007, 108, 1, 7000),
(13, 1007, 106, 1, 8000),
(14, 1008, 102, 1, 30000),
(15, 1009, 111, 2, 2500),
(16, 1009, 110, 2, 1500),
(17, 1010, 101, 1, 60000),
(18, 1011, 109, 1, 4000),
(19, 1011, 112, 2, 2000),
(20, 1012, 107, 1, 12000),
(21, 1013, 102, 1, 30000),
(22, 1013, 103, 1, 3000),
(23, 1014, 104, 2, 2000),
(24, 1014, 105, 2, 1000),
(25, 1015, 106, 1, 8000),
(26, 1015, 108, 1, 7000),
(27, 1016, 101, 1, 60000),
(28, 1016, 105, 1, 1000),
(29, 1017, 102, 1, 30000),
(30, 1017, 103, 2, 3000),
(31, 1018, 110, 3, 1500),
(32, 1018, 111, 1, 2500),
(33, 1019, 107, 1, 12000),
(34, 1019, 108, 1, 7000),
(35, 1020, 109, 2, 4000),
(36, 1020, 112, 1, 2000),
(37, 1021, 102, 1, 30000),
(38, 1021, 104, 1, 2000),
(39, 1022, 106, 1, 8000),
(40, 1022, 105, 2, 1000),
(41, 1023, 101, 1, 60000),
(42, 1024, 111, 2, 2500),
(43, 1024, 110, 2, 1500),
(44, 1025, 107, 1, 12000),
(45, 1025, 106, 1, 8000),
(46, 1026, 101, 1, 60000),
(47, 1026, 103, 1, 3000),
(48, 1027, 108, 1, 7000),
(49, 1027, 112, 2, 2000),
(50, 1028, 102, 1, 30000),
(51, 1028, 105, 2, 1000),
(52, 1029, 109, 1, 4000),
(53, 1029, 111, 1, 2500),
(54, 1030, 106, 1, 8000),
(55, 1030, 107, 1, 12000),
(56, 1031, 101, 1, 60000),
(57, 1032, 103, 2, 3000),
(58, 1032, 104, 2, 2000);