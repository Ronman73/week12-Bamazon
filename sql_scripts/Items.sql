USE Bamazon;

INSERT INTO Department (departmentName,overheadCost,totalSales) 

VALUES ("Electronics",10000,20000),("Clothing",60000,100000);

INSERT INTO Products(productName,departmentID,price,stockQuantity) 

VALUES ("tv",1,300.00,5),("laptop",1,1500.00,2),("iPhone",1,900.00,0),
("iPad",1,800.00,3),("applewatch",1,200.00,0),("keyboard",1,20.00,0),("headphones",1,100.00,0),
("jacket",2,50.85,5),("shirt",2,100.85,5),("suit",2,200.99,5);

SELECT p.itemID, p.productName, d.departmentName, p.price, p.stockQuantity 
FROM Products p, Department d 
WHERE p.departmentId = d.departmentID AND p.stockQuantity > 0;