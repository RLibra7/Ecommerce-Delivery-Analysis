# E-commerce Delivery Performance & Fulfilment Bottleneck Analysis

## 1. Project Overview

This project analyses e-commerce order and delivery data to understand delivery performance, identify fulfilment bottlenecks, and explore factors that affect customer order delivery.

Using MySQL for data analysis and Microsoft Power BI for visualisation, the project presents key performance indicators (KPIs) and interactive charts to support data-driven business decisions.

## 2. Problem Statement

E-commerce businesses need to deliver orders on time while maintaining efficient fulfilment operations. Delays can affect customer satisfaction and operational performance.

This project analyses historical order data to measure delivery performance, identify regions with longer delivery times, and understand monthly delivery trends.

## 3. Project Objectives

- Analyse order status and delivery performance.
- Measure on-time and late deliveries.
- Calculate average delivery time.
- Compare delivery performance across states.
- Analyse monthly delivery trends.
- Explore orders and payment values by payment method.
- Present insights through an interactive Power BI dashboard.

## 4. Tools and Technologies

- **MySQL Workbench:** SQL queries, data exploration and analysis.
- **Microsoft Power BI:** Data visualisation and dashboard development.
- **SQL:** Data aggregation, filtering, joins and analytical queries.
- **Olist E-commerce Dataset:** Historical e-commerce order data.

## 5. Key Performance Indicators

The dashboard currently displays the following metrics:

| KPI | Value |
|---|---:|
| Total Orders | 99.441K |
| Delivered Orders | 96,478 |
| On-Time Delivery | 91.88% |
| Average Delivery Time | 12.50 days |

*These values should be interpreted according to the filters and definitions used in the dashboard.*

## 6. Dashboard Analysis

The Power BI dashboard covers:

1. Order status distribution.
2. Monthly delivery performance trends.
3. On-time versus late deliveries.
4. Average delivery time by state.
5. Order volume by state.
6. Average delivery time by month.
7. Orders by payment method.
8. Payment value by payment method.

## 7. Business Value

The analysis can help e-commerce teams:

- Identify states with comparatively longer delivery times.
- Monitor delivery performance over time.
- Understand the distribution of successful and unsuccessful orders.
- Compare order volume across regions and payment methods.
- Investigate areas that may require further operational improvement.

## 8. Project Structure

```text
Ecommerce-Delivery-Analysis/
├── SQL/
├── PowerBI/
├── Screenshots/
└── Documentation/
    └── README.md
```

## 9. Conclusion

This project demonstrates how SQL and Power BI can be used together to analyse e-commerce delivery performance. It transforms raw order data into measurable KPIs and visual insights that can support operational monitoring and further investigation of fulfilment bottlenecks.

## 10. Future Scope

- Analyse delivery delays by seller and product category.
- Investigate the relationship between estimated and actual delivery dates.
- Add customer review analysis.
- Develop predictive models for delivery delays.
- Automate data refresh and reporting.
