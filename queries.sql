
-- Trigger Creation
SELECT EmployeeId 
FROM Employee
WHERE DepartID = (
                SELECT DepartID 
                FROM Department 
                WHERE DepartName = 'Sales');
                
SELECT COUNT(*) FROM Customer
WHERE CuOwner IN (SELECT EmployeeId 
FROM Employee
WHERE DepartID = (
                SELECT DepartID 
                FROM Department 
                WHERE DepartName = 'Sales'));
                
                
-- All employees that have not quit and their departments
SELECT Employee.*, Department.DepartName
FROM Employee
JOIN Department ON Employee.DepartID = Department.DepartID
WHERE Employee.ExitDate IS NULL;

-- Top ten spenders
SELECT Customer.CustomerID, Customer.CustFName, Customer.CustLName, SUM(Sale.TotalSaleAmount) AS TotalAmountSpent
FROM Customer
JOIN Sale ON Customer.CustomerID = Sale.CustomerID
GROUP BY Customer.CustomerID, Customer.CustFName, Customer.CustLName
ORDER BY 4 DESC
LIMIT 10;

-- List products by amount sold
SELECT p.ProductName, SUM(s.TotalSaleAmount) AS 'Total Sales'
FROM Product p
JOIN SalesProducts ON p.ProductID = SalesProducts.ProductID
JOIN Sale s ON SalesProducts.SaleID = s.SaleID
GROUP BY p.ProductName
ORDER BY 2 DESC;

-- Get the latest communication with each customer
SELECT DISTINCT c.CustomerID, com.CommunicationDateTime, com.Content
FROM Customer c
JOIN Communication com ON c.CustomerID = com.CustomerID
ORDER BY 2 DESC;

-- Get the top 10 sales reps (with either closed or open sales amounts)
SELECT E.EmployeeID, E.EmpFname, E.EmpLname, SUM(I.TotalAmount) AS TotalAmount
FROM Employee E
JOIN Customer C ON E.EmployeeID = C.CuOwner
JOIN Invoice I ON C.CustomerID = I.CustomerID
WHERE E.DepartID = (SELECT DepartID FROM Department WHERE DepartName = 'Sales')
GROUP BY E.EmployeeID, E.EmpFname, E.EmpLname
HAVING TotalAmount IS NOT NULL  -- exluded no invoices
ORDER BY TotalAmount DESC;

-- Get the total sales for each company ordered by total sales amount.
SELECT c.CompanyName, SUM(s.TotalSaleAmount)
FROM Company c 
JOIN Customer cu ON c.CompanyID = cu.CompanyID
JOIN Sale s ON cu.CustomerID = s.CustomerID
GROUP BY c.CompanyName
ORDER BY 2 DESC;

-- Who are my managers?
SELECT EmployeeID, EmpFname, EmpLname
FROM Employee  
WHERE EmployeeID IN (SELECT ManagerID FROM Department);

-- Which company has the most employees in our system?
SELECT c.CompanyName, COUNT(cu.CustomerID)
FROM Company c
JOIN Customer cu ON c.CompanyID = cu.CompanyID
GROUP BY c.CompanyName
ORDER BY 2 DESC;

-- How many customers and companies exists in each country 
SELECT l.Country, COUNT(cu.CustomerID), COUNT(c.CompanyID)
FROM Locations l
JOIN Customer cu ON l.LocationID = cu.LocationID
JOIN Company c ON cu.CompanyID = c.CompanyID
GROUP BY l.Country
ORDER BY l.Country DESC;

-- Organize our customers
SELECT
    Customer.CustomerID,
    Customer.CustFName,
    Customer.CustLName,
    SUM(Sale.TotalSaleAmount) AS TotalAmountSpent,
    CASE
        WHEN SUM(Sale.TotalSaleAmount) >= 300 THEN 'High Spender'
        WHEN SUM(Sale.TotalSaleAmount) >= 100 AND SUM(Sale.TotalSaleAmount) < 300 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS SpendingCategory
FROM
    Customer
JOIN
    Sale ON Customer.CustomerID = Sale.CustomerID
GROUP BY
    Customer.CustomerID, Customer.CustFName, Customer.CustLName
ORDER BY
    TotalAmountSpent DESC;












