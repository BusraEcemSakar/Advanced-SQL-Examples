## Advanced SQL Examples

### Sales Analysis Query
This query analyzes the average sales per month for each product category and compares sales performance across different years. (OVER PARTITION BY)

### Explanation
MonthlySales CTE: Aggregates total sales per month for each product category.

YearlySales CTE: Computes average monthly sales per category per year.

SalesComparison CTE: Compares current year sales with previous year's sales.

Final SELECT Statement: Calculates growth percentage and handles cases with no previous year data.

