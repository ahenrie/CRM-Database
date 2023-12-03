CREATE DATABASE GamersRUs;
USE GamersRUs;

-- DDL
-- Locations Table
-- Got rid of continent
CREATE TABLE Locations (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    Address1 VARCHAR(100),
    Address2 VARCHAR(25),
    City VARCHAR(50),
    Province VARCHAR(50),
    ZIP VARCHAR(10),
    Country VARCHAR(60)
);

-- Department Table
CREATE TABLE Department (
    DepartID INT AUTO_INCREMENT PRIMARY KEY,
    ManagerID INT,
    DepartName VARCHAR(25)
);

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmpFName VARCHAR(20),
    EmpLName VARCHAR(20),
    DOB DATE,
    MobileNum VARCHAR(12),
    Landline VARCHAR(12),
    Ext VARCHAR(4),
    DepartID INT,
    HireDate DATE,
    ExitDate DATE,
    FOREIGN KEY (DepartID) REFERENCES Department(DepartID)
);

-- CustomerType Table
CREATE TABLE CustomerType (
    CuTypeID INT AUTO_INCREMENT PRIMARY KEY,
    CuType VARCHAR(25)
);

-- Company Table
CREATE TABLE Company (
    CompanyID INT AUTO_INCREMENT PRIMARY KEY,
    CompanyName VARCHAR(25),
    YearEst INT, # Year established changed to int
    LocationID INT,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Customer Table 
-- Changed ethnicity VARCHAR to 50 and MobileNum to 12
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustFName VARCHAR(20),
    CustLName VARCHAR(20),
    Gender CHAR(1),
    DOB DATE,
    Ethnicity VARCHAR(50),
    MobileNum VARCHAR(12),
    Email VARCHAR(100),
    LocationID INT,
    CuOwner INT,
    CuType INT,
    CompanyID INT,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (CuOwner) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CuType) REFERENCES CustomerType(CuTypeID),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

-- Task Table
CREATE TABLE Task (
    TaskID INT AUTO_INCREMENT PRIMARY KEY,
    ContactMode VARCHAR(20),
    Memo VARCHAR(500),
    StartTime DATETIME,
    EndTime DATETIME,
    EmpID INT,
    CustomerID INT,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Sale Table
CREATE TABLE Sale (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    SaleDate DATE,
    TotalSaleAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Product Table
CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(20),
    ProductColor VARCHAR(30),
    ProductPrice DECIMAL(10, 2)
);

-- SalesProducts Table
CREATE TABLE SalesProducts (
    SaleID INT,
    ProductID INT,
    PRIMARY KEY (SaleID, ProductID),
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Activity Table
CREATE TABLE Activity (
    ActivityID INT AUTO_INCREMENT PRIMARY KEY,
    ActivityType VARCHAR(50),
    ActivityDate DATETIME,
    Notes TEXT,
    EmployeeID INT,
    CustomerID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Opportunity Table
CREATE TABLE Opportunity (
    OpportunityID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    Status VARCHAR(50),
    ExpectedCloseDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Lead Table
CREATE TABLE Leads (
    LeadID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone CHAR(10),
    Status VARCHAR(50),
    Source VARCHAR(50)
);

-- Communication Table
CREATE TABLE Communication (
    CommunicationID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    CustomerID INT,
    CommunicationDateTime DATETIME,
    CommunicationType VARCHAR(50),
    Content TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Invoice Table
CREATE TABLE Invoice (
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT,
    CustomerID INT,
    InvoiceDate DATE,
    DueDate DATE,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

-- Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    FeedbackDateTime DATETIME,
    Rating INT,
    Comments TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
