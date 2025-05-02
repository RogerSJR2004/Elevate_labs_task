USE sales_analysis;
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM
    orders
GROUP BY
    YEAR(order_date), MONTH(order_date)
ORDER BY
    YEAR(order_date), MONTH(order_date);
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM
    orders
WHERE
    YEAR(order_date) = 2024
GROUP BY
    YEAR(order_date), MONTH(order_date)
ORDER BY
    month;
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(amount) AS total_revenue,
    LAG(SUM(amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) AS prev_month_revenue,
    ROUND(
        (SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date))) /
        LAG(SUM(amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) * 100, 2
    ) AS revenue_growth_percent
FROM
    orders
GROUP BY
    YEAR(order_date), MONTH(order_date)
ORDER BY
    year, month;
SELECT * FROM orders;
