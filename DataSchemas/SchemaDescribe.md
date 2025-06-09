# CRM Sales Data Schema

This document outlines the schema of the interconnected tables used in the CRM Sales Data project for analyzing sales performance, product adoption, and account development trends.

## Table Relationships

The project utilizes four main tables with the following relationships:

* `ACCOUNTS` **(One-to-Many)** to `SALES_PIPELINE` on `account_name`
* `PRODUCTS` **(One-to-Many)** to `SALES_PIPELINE` on `product`
* `SALES_TEAM` **(One-to-Many)** to `SALES_PIPELINE` on `sales_agent`

## Table Details

### 1. `ACCOUNTS` Table

Contains key information about customer companies.
**Primary Key:** `account_name` 

| Column Name   | Description                           | Data Type (Inferred) |
| :------------ | :------------------------------------ | :------------------- |
| `account_name`| Unique identifier for the account     | Text / VARCHAR       |
| `sector`      | Industry sector of the account        | Text / VARCHAR       |
| `year_established`| Year the company was established    | Integer              |
| `revenue`     | Company's reported revenue            | Decimal / Numeric    |
| `employee`    | Number of employees                   | Integer              |
| `office_loc`  | Primary office location (country)     | Text / VARCHAR       |
| `sub_office`  | Sub-office location (if applicable)   | Text / VARCHAR       |

### 2. `PRODUCTS` Table

Contains details of the products offered by the company.
**Primary Key:** `product` 

| Column Name   | Description                   | Data Type (Inferred) |
| :------------ | :---------------------------- | :------------------- |
| `product`     | Specific product name         | Text / VARCHAR       |
| `series`      | Product series (e.g., GTK, GTX) | Text / VARCHAR       |
| `sales_price` | Standard sales price of the product | Decimal / Numeric    |

### 3. `SALES_TEAM` Table

Maps sales agents to their managers and operational regions.
**Primary Key:** `sales_agent` 

| Column Name   | Description                             | Data Type (Inferred) |
| :------------ | :-------------------------------------- | :------------------- |
| `sales_agent` | ID or name of the sales agent           | Text / VARCHAR       |
| `manager`     | Name of the sales agent's manager       | Text / VARCHAR       |
| `regional_off`| Operational regional office of the agent| Text / VARCHAR       |

### 4. `SALES_PIPELINE` Table

Captures all sales activities, opportunities, and closed deals.
**Primary Key:** `opportunity_id` 
**Foreign Keys:** `sales_agent` (references `SALES_TEAM`), `product` (references `PRODUCTS`), `account` (references `ACCOUNTS`) 

| Column Name     | Description                               | Data Type (Inferred) |
| :-------------- | :---------------------------------------- | :------------------- |
| `opportunity_id`| Unique identifier for each sales opportunity | Text / VARCHAR       |
| `sales_agent`   | Sales agent responsible for the deal      | Text / VARCHAR       |
| `product`       | Product involved in the deal              | Text / VARCHAR       |
| `account_name`  | Customer account associated with the deal | Text / VARCHAR       |
| `deal_stage`    | Current stage of the deal (e.g., Won, Lost) | Text / VARCHAR       |
| `engage_date`   | Date of initial engagement for the deal   | Date                 |
| `close_date`    | Date the deal was closed                  | Date                 |
| `close_value`   | Monetary value of the closed deal         | Decimal / Numeric    |
