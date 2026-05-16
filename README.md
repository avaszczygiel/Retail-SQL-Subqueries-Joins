# Retail Operations SQL: Subqueries & Table Joins

## Project Overview
This project applies intermediate-to-advanced SQL techniques including subqueries, correlated subqueries, and multiple JOIN types to a retail operations database. Queries answer real business questions about customer order behavior, product sales volume, and customer activity, while demonstrating when to use each type of join and subquery pattern.

---

## Business Questions Answered

| Part | # | Question |
|------|---|----------|
| 1 – Warm-up | 1.1 | Which products have 'jet' anywhere in their description? |
| 1 – Warm-up | 1.2 | What would all product prices look like with a $0.50 increase? |
| 1 – Warm-up | 1.3 | Which price points appear most frequently in order line items? |
| 2 – Subqueries | 2.1 | Which customers placed orders containing at least one item priced $10+? |
| 2 – Subqueries | 2.2 | Which customers ordered product FB (Bird seed), and when? |
| 2 – Subqueries | 2.3 | What is the total quantity sold for each product across all orders? |
| 3 – Joins | 3.1 | Which customers have placed orders? (INNER JOIN) |
| 3 – Joins | 3.2 | Same as 3.1 using shorthand JOIN syntax |
| 3 – Joins | 3.3 | Which customers exist in the system, including those with no orders? (LEFT OUTER JOIN) |

---

## Key Concepts Demonstrated

### Subquery Types
| Type | Used In | Purpose |
|------|---------|---------|
| `IN` subquery | 2.1, 2.2 | Filter outer query rows based on a list from an inner query |
| Correlated subquery | 2.3 | Inner query references outer query's row — runs once per row |

### JOIN Types
| Join Type | Behavior |
|-----------|----------|
| `INNER JOIN` | Returns only rows with matching keys in both tables |
| `JOIN` | Shorthand for INNER JOIN — identical behavior in MySQL |
| `LEFT OUTER JOIN` | Returns all rows from the left table; NULLs where no match exists |

---

## Database Schema

```
customers         orders            orderitems         products          vendors
-----------       ----------        -----------        ----------        ----------
cust_id       ←→  cust_id           order_num      ←→  prod_id       ←→  vend_id
cust_name         order_num     ←→  order_item         vend_id           vend_name
cust_address      order_date        prod_id            prod_name         vend_address
cust_city                           quantity           prod_price        vend_city
cust_state                          item_price         prod_desc         vend_state
cust_zip                                                                 vend_country
cust_country
cust_contact
cust_email
```

---

## Files

```
retail-sql-subqueries-joins/
├── README.md
├── queries/
│   └── analysis_queries.sql    ← All queries with business context comments
└── data/
    └── database_schema.sql     ← Full schema and seed data
```

---

## How to Run

1. Install [MySQL](https://dev.mysql.com/downloads/) or use MySQL Workbench
2. Run `data/database_schema.sql` to create and populate the database (skip if already loaded)
3. Open `queries/analysis_queries.sql` and run each section individually

---

## Tools Used
- **MySQL 8.0**
- **MySQL Workbench**

---

## About
Academic project completed as part of MBA coursework in Business Analytics at Bryant University.
