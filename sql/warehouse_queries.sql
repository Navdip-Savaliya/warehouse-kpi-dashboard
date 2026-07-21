-- ===========================================
-- Warehouse KPI Dashboard
-- Sample SQL Analysis
-- ===========================================

-- View all inventory records
SELECT *
FROM inventory;

-- Total inventory by category
SELECT
    Category,
    SUM(On_Hand) AS Total_On_Hand
FROM inventory
GROUP BY Category
ORDER BY Total_On_Hand DESC;

-- Available inventory by product
SELECT
    SKU,
    Product,
    Available
FROM inventory
ORDER BY Available DESC;

-- Products with damaged inventory
SELECT
    SKU,
    Product,
    Damaged
FROM inventory
WHERE Damaged > 0
ORDER BY Damaged DESC;

-- Total inventory by warehouse zone
SELECT
    Zone,
    SUM(On_Hand) AS Total_Inventory
FROM inventory
GROUP BY Zone
ORDER BY Zone;

-- Products with low available inventory
SELECT
    SKU,
    Product,
    Available
FROM inventory
WHERE Available < 100
ORDER BY Available;
