# E-commerce Delivery Performance & Fulfilment Bottleneck Analysis

## Project Overview
This project analyzes e-commerce delivery performance using the Brazilian Olist e-commerce dataset. It uses SQL for data exploration and analysis and Power BI to build an interactive dashboard that helps identify delivery delays, monthly trends, state-wise performance, and payment patterns.

## Problem Statement
Late deliveries can reduce customer satisfaction and affect business performance. This project analyzes historical e-commerce orders to understand delivery performance and identify areas where logistics operations may need improvement.

## Objectives
- Analyze order status and delivery performance.
- Measure on-time and late deliveries.
- Track monthly delivery trends.
- Compare delivery performance across states.
- Explore product categories and payment methods.
- Present key findings through a Power BI dashboard.

## Tools & Technologies
- **MySQL:** Data exploration, quality checks, SQL queries, joins, aggregations, and views.
- **Microsoft Power BI:** Dashboard creation, KPI cards, and charts.
- **Dataset:** Brazilian E-commerce Public Dataset by Olist.

## Key Performance Indicators (KPIs)

| KPI | Result |
|---|---:|
| Total Orders | 99,441 |
| Delivered Orders | 96,478 |
| On-Time Delivery | 91.88% |
| Average Delivery Time | 12.50 days |

*Figures are based on the analysis and dashboard calculations in this project.*

## Dashboard Features
- Order status distribution
- Monthly delivery performance trends
- On-time versus late deliveries
- Average delivery time by state
- Order volume by state
- Average delivery time by month
- Orders by payment method
- Payment value by payment method

## SQL Analysis
The SQL script includes:
- Database exploration and order counts
- Data quality checks for missing values and duplicate order IDs
- A delivery analysis view
- On-time and late delivery calculations
- Monthly and state-wise delivery analysis
- Product-category delivery analysis
- Payment method and payment value analysis

## Business Value
The analysis can help e-commerce and logistics teams:
- Identify states with higher delivery delays.
- Monitor changes in delivery performance over time.
- Understand delivery patterns across product categories.
- Support data-driven logistics and fulfilment decisions.

## Project Structure
- `ecommerce_delivery_analysis.sql` — SQL analysis script
- `PowerBI-Dashboard-Screenshots.pdf` — Dashboard screenshots
- `README.md` — Project documentation
- `Power BI Dashboard (.pbix)` — Interactive dashboard file (https://drive.google.com/file/d/1ye4JT721Df03gQ1nELfShckmdj7cZ1wN/view?usp=sharing)

## Future Scope
- Analyze the impact of freight charges and distance on delivery time.
- Investigate possible causes of late deliveries.
- Add interactive filters and drill-through analysis.
- Develop recommendations based on regional delivery patterns.

## Conclusion
This project demonstrates practical use of SQL and Power BI to analyze e-commerce delivery performance, summarize operational KPIs, and present business-focused insights through a dashboard.
