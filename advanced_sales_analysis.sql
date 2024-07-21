WITH MonthlySales AS (
    SELECT
        p.category,
        DATE_TRUNC('month', s.sale_date) AS sale_month,
        SUM(s.quantity * s.price) AS total_sales
    FROM
        sales s
    JOIN
        products p ON s.product_id = p.product_id
    GROUP BY
        p.category, DATE_TRUNC('month', s.sale_date)
),
YearlySales AS (
    SELECT
        category,
        EXTRACT(YEAR FROM sale_month) AS sale_year,
        AVG(total_sales) AS avg_monthly_sales
    FROM
        MonthlySales
    GROUP BY
        category, EXTRACT(YEAR FROM sale_month)
),
SalesComparison AS (
    SELECT
        category,
        sale_year,
        avg_monthly_sales,
        LAG(avg_monthly_sales) OVER (PARTITION BY category ORDER BY sale_year) AS prev_year_sales
    FROM
        YearlySales
)
SELECT
    category,
    sale_year,
    avg_monthly_sales,
    COALESCE(prev_year_sales, avg_monthly_sales) AS prev_year_sales,
    ROUND((avg_monthly_sales - COALESCE(prev_year_sales, avg_monthly_sales)) / NULLIF(COALESCE(prev_year_sales, avg_monthly_sales), 0) * 100, 2) AS sales_growth_percentage
FROM
    SalesComparison
ORDER BY
    category, sale_year;
