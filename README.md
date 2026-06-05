# E-Commerce Funnel Analysis
## Olist Brazilian E-Commerce Platform

## Problem Statement
Olist, a Brazilian e-commerce platform, wanted to identify
where customers are dropping off in the order fulfillment
funnel, quantify revenue loss, and improve customer
satisfaction using data-driven insights.

## Dataset
- Source: Kaggle — Olist Brazilian E-Commerce Public Dataset
- Size: 99,441 orders across 5 related tables
- Time Period: 2016 - 2018

## Tools & Technologies
| Tool | Purpose |
|------|---------|
| Python (Pandas, Seaborn, Matplotlib) | EDA & Visualizations |
| PostgreSQL & pgAdmin4 | SQL Analysis |
| Power BI | Interactive Dashboard |

## Project Structure


## Key Findings
1. Highest funnel drop-off at Shipped to Carrier stage
   — 1,623 orders never reached customers
2. 8.11% orders delivered late — 7,826 orders affected
3. Total revenue generated: R$16,008,872
   — Average order value: R$160.99
4. Late delivery avg review score: 2.57 vs
   On-time delivery avg: 4.29
5. R$269,735 revenue lost from cancelled
   and unavailable orders

## Business Impact
- Identified R$269,735 revenue loss from cancellations
- Late deliveries reduce customer satisfaction by 40%
  (review score drops from 4.29 to 2.57)
- 11,424 customers gave 1-star review — mostly
  late delivery related

## Business Recommendations
1. Audit carrier performance — fix last-mile delivery
2. Set SLA with logistics partners to reduce late deliveries
3. Offer compensation vouchers to late delivery customers
4. Target cancelled order customers with recovery offers
5. Proactively notify customers about delayed orders
