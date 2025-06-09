# SQL-Sales-CRM

# 📊 SQL Sales CRM Analysis

**Project Path:** `SQL-Sales-CRM`  
**Status:** Completed  
**Tools Used:** SQL (MySQL/PostgreSQL)

## 🚀 Overview

This project analyzes a simulated CRM sales dataset to extract actionable insights into sales performance, account development, product trends, and pipeline dynamics. It integrates four primary tables—`accounts`, `products`, `sales_team`, and `sales_pipeline`—to create a 360-degree view of organizational sales efficiency.

## 🧠 Objectives

- Evaluate sales funnel performance by managers, agents, and industry sectors.
- Identify high-value accounts, top-selling products, and revenue-driving sectors.
- Track monthly pipeline trends and close rates.
- Detect underperformance across regions, products, and sales reps.
- Enable leadership with data-backed strategy recommendations.

## 🗃️ Dataset Structure

- **`accounts`** – Customer company profiles including industry sector and location.
- **`products`** – Details of each product and its series.
- **`sales_team`** – Mapping of sales agents to their respective managers and regions.
- **`sales_pipeline`** – Central table capturing opportunity data, win/loss stages, and deal values.

## 📌 Key Business Questions Addressed

1. **Which accounts have generated revenue from won deals?**
2. **Sales agent performance breakdown: total, won, and lost deals.**
3. **Top-ranked sales agents by office region.**
4. **Top-selling products by series.**
5. **Average deal closing time per sector.**
6. **Most recent deal per account for re-engagement potential.**
7. **Revenue trends over time by sales agent.**
8. **Account win rate analysis—identify underperformers (<60%).**
9. **Monthly win/loss trends to detect seasonality.**
10. **Accounts with lost deals but increasing deal value.**
11. **Manager and team-level performance benchmarking.**
12. **Sector-wise product performance by series—revenue, adoption, top accounts.**

## 🧮 Sample SQL CRM Query

```sql
SELECT ACCOUNT_NAME, SUM(CLOSE_VALUE) AS TOTAL_REVENUE
FROM sales_pipeline
WHERE deal_stage = "Won"
GROUP BY ACCOUNT_NAME
ORDER BY TOTAL_REVENUE DESC;
