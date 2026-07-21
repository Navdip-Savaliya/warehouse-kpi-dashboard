/*=========================================================
 FreshBox Foods
 Warehouse Operations Analytics
 Author: Navdip Savaliya

 This SQL script demonstrates warehouse operational analysis
 using the same datasets visualized in the Excel dashboard.
=========================================================*/


/*=========================================================
1. CURRENT INVENTORY
=========================================================*/

SELECT
    SKU,
    Product,
    Category,
    Zone,
    On_Hand,
    Reserved,
    Available,
    Damaged
FROM Inventory
ORDER BY Product;



/*=========================================================
2. INVENTORY BY CATEGORY
Matches Dashboard: Inventory by Category
=========================================================*/

SELECT
    Category,
    SUM(On_Hand) AS Total_Inventory
FROM Inventory
GROUP BY Category
ORDER BY Total_Inventory DESC;



/*=========================================================
3. INVENTORY BY WAREHOUSE ZONE
Matches Dashboard: Inventory by Zone
=========================================================*/

SELECT
    Zone,
    SUM(On_Hand) AS Inventory
FROM Inventory
GROUP BY Zone
ORDER BY Zone;



/*=========================================================
4. TOP 10 INVENTORY ITEMS
Matches Dashboard: Top 10 Inventory
=========================================================*/

SELECT
    Product,
    On_Hand
FROM Inventory
ORDER BY On_Hand DESC
LIMIT 10;



/*=========================================================
5. LOW STOCK ITEMS
=========================================================*/

SELECT
    SKU,
    Product,
    Available
FROM Inventory
WHERE Available < 50
ORDER BY Available;



/*=========================================================
6. RESERVED INVENTORY
=========================================================*/

SELECT
    Product,
    Reserved
FROM Inventory
WHERE Reserved > 0
ORDER BY Reserved DESC;



/*=========================================================
7. DAMAGED INVENTORY
=========================================================*/

SELECT
    Product,
    Damaged
FROM Inventory
WHERE Damaged > 0
ORDER BY Damaged DESC;



/*=========================================================
8. CUSTOMER ORDERS
=========================================================*/

SELECT
    Order_Date,
    COUNT(Order_ID) AS Orders_Placed,
    SUM(Quantity) AS Total_Items
FROM Orders
GROUP BY Order_Date
ORDER BY Order_Date;



/*=========================================================
9. SHIPPED ORDERS
=========================================================*/

SELECT
    Status,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Status;



/*=========================================================
10. TOP ORDERED PRODUCTS
=========================================================*/

SELECT
    Product,
    SUM(Quantity) AS Total_Ordered
FROM Orders
GROUP BY Product
ORDER BY Total_Ordered DESC;



/*=========================================================
11. SUPPLIER RECEIPTS
Matches Dashboard: Supplier Receipts
=========================================================*/

SELECT
    Supplier,
    SUM(Quantity) AS Total_Received
FROM Receipts
GROUP BY Supplier
ORDER BY Total_Received DESC;



/*=========================================================
12. DAILY RECEIPTS
=========================================================*/

SELECT
    Receipt_Date,
    SUM(Quantity) AS Total_Received
FROM Receipts
GROUP BY Receipt_Date
ORDER BY Receipt_Date;



/*=========================================================
13. INVENTORY ACCURACY
=========================================================*/

SELECT
    Product,
    System_Qty,
    Physical_Qty,
    Variance
FROM CycleCounts
ORDER BY ABS(Variance) DESC;



/*=========================================================
14. INVENTORY ACCURACY %
=========================================================*/

SELECT
ROUND(
100 -
(
SUM(ABS(Variance))
/
SUM(System_Qty)
*100
),
2
) AS Inventory_Accuracy_Percentage
FROM CycleCounts;



/*=========================================================
15. WAREHOUSE EXECUTIVE SUMMARY
=========================================================*/

SELECT
(SELECT COUNT(*) FROM Inventory) AS Total_SKUs,

(SELECT SUM(On_Hand)
 FROM Inventory) AS Total_Inventory,

(SELECT COUNT(*)
 FROM Orders) AS Total_Orders,

(SELECT SUM(Quantity)
 FROM Receipts) AS Total_Received,

(
SELECT ROUND(
100 -
(
SUM(ABS(Variance))
/
SUM(System_Qty)
*100
),
2
)
FROM CycleCounts
) AS Inventory_Accuracy;
