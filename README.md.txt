# Superstore Sales & Profit Analysis

## Project Overview

This project analyzes Superstore sales data to understand sales performance, profitability, customer behavior, product performance, and regional trends. The goal is to turn raw retail data into actionable business insights using Python, SQL, and Power BI.

## Business Objectives

* Analyze sales and profit across product categories.
* Identify profitable and loss-making products.
* Understand the relationship between discounts and profitability.
* Compare performance across regions and customer segments.
* Analyze yearly sales trends and shipping performance.

## Tools & Technologies

* **Python:** Data cleaning and exploratory data analysis
* **Pandas & NumPy:** Data manipulation and analysis
* **MySQL:** Business queries and aggregations
* **Power BI:** Interactive dashboard and visualizations
* **GitHub:** Project documentation and portfolio

## Dataset

The project uses the Sample Superstore retail dataset.

* **Rows:** 9,994
* **Columns after preparation:** 25
* **Missing values after cleaning:** 0
* **Duplicate rows after cleaning:** 0

## Project Workflow

1. Loaded the dataset using Python and Pandas.
2. Cleaned the data and standardized column names.
3. Created additional date-related and shipping-duration columns.
4. Performed exploratory data analysis.
5. Loaded the prepared data into MySQL.
6. Wrote SQL queries to analyze categories, regions, customers, products, discounts, and shipping modes.
7. Built an interactive Power BI report.

## Power BI Dashboard

The report contains three pages:

### 1. Executive Overview

Summarizes sales, profit, profit margin, orders, quantity, category performance, yearly trends, and regional performance.

### 2. Product & Profitability

Highlights top-performing products, loss-making products and subcategories, category profitability, and discount patterns.

### 3. Customers & Operations

Explores top customers, profit by shipping mode, and average shipping duration.


## Dashboard Screenshots

### 1. Executive Overview

![Executive Overview](screenshots/executive_overview.png)

### 2. Product & Profitability

![Product & Profitability](screenshots/product_profitability.png)

### 3. Customers & Operations

![Customers & Operations](screenshots/customers_operations.png)


## Key Business Insights

* **Technology** generated approximately $836K in sales and $145K in profit.
* **Furniture** had a relatively low profit margin of approximately 2.49%.
* The **West** region generated the highest total profit among the four regions.
* Sales increased from approximately $484K in 2014 to $733K in 2017.
* The **Tables** subcategory recorded a loss of approximately $17.7K.
* Several products with high average discounts also recorded significant losses.

These findings show where the business could investigate pricing, discount policies, and product profitability further.

## Recommendations

* Review discount policies for products with recurring losses.
* Investigate the causes of losses in Tables and other underperforming subcategories.
* Study successful categories and regions to identify practices that could be replicated.
* Monitor profit margin alongside sales instead of judging performance by revenue alone.

## How to Run

1. Open the cleaned dataset `superstore_cleaned.csv` using Python or a spreadsheet application.
2. Run the analysis scripts or notebooks, if included.
3. Import the prepared data into MySQL if you want to reproduce the SQL analysis.
4. Open the Power BI report file (`.pbix`) in Power BI Desktop to explore the dashboard.

## Project Status

Completed the initial data cleaning, exploratory analysis, SQL analysis, and Power BI dashboard.

## Author

Data Analytics Portfolio Project

