# 🍽️ Danny’s Diner — SQL Challenge (8 Week SQL Challenge)

This project contains my solution to Case Study #1: Danny’s Diner, part of the 8 Week SQL Challenge by @DataWithDanny.
The challenge focuses on querying customer behavior data for a fictional Japanese restaurant using SQL.

# 📘 Overview

Danny wants to better understand his customers’ visiting patterns, spending habits, and membership behaviors.
Using three datasets — sales, menu, and members — the goal is to answer analytical questions about customer purchases and loyalty programs.

This repository includes:

# 📂 SQL queries for each question

# 🗂️ Datasets
1. sales
column	type	description
customer_id	text	Customer identifier
order_date	date	Date of purchase
product_id	integer	Menu item purchased
2. menu
column	type	description
product_id	integer	Menu item identifier
product_name	text	Name of the dish
price	integer	Price of the dish
3. members
column	type	description
customer_id	text	Customer identifier
join_date	date	Membership start date

# 📁 Repository Structure
📦 dannys-diner-sql
 ┣ 📜 README.md
 ┣ 📂 sql
 │   ┣ 01_total_spend.sql
 │   ┣ 02_visit_days.sql
 │   ┣ 03_first_purchase.sql
 │   ┣ 04_popular_items.sql
 │   ┣ 05_pre_post_membership.sql
 │   ┣ 06_loyalty_points.sql
 │   ┗ 07_bonus_summary.sql
 ┣ 📂 data
 │   ┣ sales.csv
 │   ┣ menu.csv
 │   ┗ members.csv
 ┗ 📄 schema.sql

# 🛠️ Technologies Used

SQL (PostgreSQL / MySQL / SQLite — depending on setup)

DB visualizing tools (optional):

DBeaver / pgAdmin / SQLPad / BigQuery console

# 🚀 How to Use

Clone the repository:

git clone https://github.com/<your-username>/dannys-diner-sql.git


Load the schema and datasets into your SQL environment.

Run the SQL files in the sql/ directory to reproduce the answers.
