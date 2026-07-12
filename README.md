# Beauty-Salon-Database
<h1 align="center"> Beauty Salon Database System</h1>

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/SQL-Database_Design-orange?style=flat-square"/>
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square"/>
</p>
---

## Overview

A relational database system designed and implemented in **MySQL** to manage core operations of a beauty salon: customer records, product inventory, and appointment scheduling. Built for the *Introduction to Database System* course, the project covers the full database design cycle — from ER modeling and relational schema design to writing aggregate queries, joins, subqueries, and views.

###  Problem It Solves

Small beauty salons often track customers, product sales, and appointments manually or across disconnected spreadsheets, making it hard to answer simple business questions (which services generated the most revenue? which customers bought premium products?) or to enforce basic data rules (e.g. stock can't go negative). This project models a clean, normalized relational schema that solves both problems.

### Project Objectives

1. Create an organized digital system for managing salon operations
2. Track customer appointments and purchase history
3. Manage product inventory and sales

---

##  Tech Stack

| Category | Tools |
|---|---|
| Database | MySQL |
| Design | ER Modeling, Relational Schema Design |
| Querying | DDL/DML, Aggregate Functions, Joins, Subqueries, Views |

---

##  Database Structure

The system consists of **three core tables**:

| Table | Description |
|---|---|
| **Customer** | Stores customer info: `Customer_ID` (PK), `Customer_name`, `Phone` (unique), `Email` (unique), `Join_date` |
| **Products** | Stores product info: `Product_ID` (PK), `Product_name`, `Brand`, `Price`, `Stock` (checked to never go negative) |
| **Appointments** | Links customers to the products/services used in their visit: `Appointment_ID` (PK), `Customer_ID` (FK → Customer), `Product_ID` (FK → Products), `Service_type`, `Service_price`, `Date_time` |

**Relationships:** 
ER Diagram Entity Relationship:

<img width="762" height="398" alt="image" src="https://github.com/user-attachments/assets/cc1c1928-6d39-43f1-b0ff-74dd34adc998" />

A customer can have many appointments (1–N), and each appointment references one product used during that service (1–N from Products).

```
Customer (1) ──── (N) Appointments (N) ──── (1) Products
```
Relational Schema:

<img width="582" height="525" alt="image" src="https://github.com/user-attachments/assets/960ab273-b6a0-4b7d-924e-4858141a8249" />


---

##  Project Structure

```
beauty-salon-database-system/
├── beauty_salon_db.sql   # Full script: schema, sample data, and all queries/views
└── README.md
```

> This project is intentionally kept as a single well-commented `.sql` file, mirroring how it was built and taught — organized into clearly numbered sections (database creation, table creation, data insertion, queries, views).

---

##  Installation

```bash
# 1. Clone the repository
git clone https://github.com/miranamoh/beauty-salon-database-system.git
cd beauty-salon-database-system

# 2. Run the full script in MySQL (creates the DB, tables, sample data, and views)
mysql -u root -p < beauty_salon_db.sql
```

Or open `beauty_salon_db.sql` directly in **MySQL Workbench** and run it section by section.

---

## Usage Examples

**Count total appointments:**
```sql
SELECT COUNT(*) AS total_appointments FROM Appointments;
```

**Highest & lowest priced product per brand:**
```sql
SELECT brand, MAX(price) AS max_price, MIN(price) AS min_price
FROM Products
GROUP BY brand;
```

**Full appointment details (JOIN across all three tables), with total amount charged:**
```sql
SELECT c.Customer_name, a.Service_type, a.Service_price, a.Date_time,
       p.Product_name, p.Price AS Product_price,
       (a.Service_price + p.Price) AS Total_amount
FROM Appointments a
JOIN Customer c ON a.Customer_ID = c.Customer_ID
JOIN Products p ON a.Product_ID = p.Product_ID;
```

**Subquery — customers who purchased products priced above 80:**
```sql
SELECT Customer_name, Phone
FROM Customer
WHERE Customer_ID IN (
    SELECT Customer_ID FROM Appointments
    WHERE Product_ID IN (
        SELECT Product_ID FROM Products WHERE Price > 80
    )
);
```

**View — expensive services (service price > 250):**
```sql
CREATE VIEW expensive_services AS
SELECT * FROM Appointments WHERE Service_price > 250;

SELECT * FROM expensive_services;
```

---

##  Results

Sample dataset used for testing:

| Table | Rows |
|---|---|
| Customer | 4 |
| Products | 7 |
| Appointments | 4 |

**Implemented query types:** `COUNT`, `MAX`/`MIN` with `GROUP BY`, multi-table `JOIN` with computed columns, nested subqueries (`WHERE IN`), and two `VIEW`s (`expensive_services`, `appointments_detail`) for simplified reporting.

---

##  Future Work

- [ ] Add a `Staff` table with appointment-staff assignment
- [ ] Add a front-end interface (e.g. Streamlit) on top of the schema
- [ ] Add indexing on frequently queried columns (`Customer_ID`, `Date_time`) for performance
- [ ] Expand service catalog beyond product-linked services
- [ ] Add stored procedures for common operations (e.g. booking an appointment)

---

## Team & Course

Developed as a team project for the course **Introduction to Database System**, supervised by **Dr. Muna Ali**.
