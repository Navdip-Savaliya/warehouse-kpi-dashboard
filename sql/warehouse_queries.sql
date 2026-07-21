-- ===========================================
-- Warehouse KPI Dashboard
-- Warehouse Operations Analytics
-- ===========================================

------------------------------------------------
-- 1. View Current Inventory
------------------------------------------------

SELECT *
FROM inventory;

------------------------------------------------
-- 2. Inventory by Category
------------------------------------------------

SELECT
    Category,
    SUM(On_Hand) AS Total_On_Hand,
    SUM(Available) AS Available_Stock,
    SUM(Damaged) AS Damaged_Stock
FROM inventory
GROUP BY Category
ORDER BY Total_On_Hand DESC;

------------------------------------------------
-- 3. Inventory by Warehouse Zone
------------------------------------------------

SELECT
    Zone,
    SUM(On_Hand) AS Total_Inventory
FROM inventory
GROUP BY Zone
ORDER BY Zone;

------------------------------------------------
-- 4. Low Stock Products
------------------------------------------------

SELECT
    SKU,
    Product,
    Available
FROM inventory
WHERE Available < 100
ORDER BY Available;

------------------------------------------------
-- 5. Total Orders Shipped
------------------------------------------------

SELECT
    COUNT(Order_ID) AS Orders_Shipped
FROM orders
WHERE Status = 'Shipped';

------------------------------------------------
-- 6. Products Ordered
------------------------------------------------

SELECT
    Product,
    SUM(Quantity) AS Total_Ordered
FROM orders
GROUP BY Product
ORDER BY Total_Ordered DESC;

------------------------------------------------
-- 7. Supplier Receipts
------------------------------------------------

SELECT
    Supplier,
    SUM(Quantity) AS Quantity_Received
FROM receipts
GROUP BY Supplier
ORDER BY Quantity_Received DESC;

------------------------------------------------
-- 8. Inventory Accuracy
------------------------------------------------

SELECT
    SKU,
    Product,
    System_Qty,
    Physical_Qty,
    ABS(System_Qty - Physical_Qty) AS Variance
FROM cycle_counts
ORDER BY Variance DESC;
