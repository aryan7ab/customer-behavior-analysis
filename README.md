Project Overview

This project analyzes customer purchasing behavior using SQL, Python, MySQL, Plotly, and Streamlit.
The objective is to extract meaningful business insights related to:
	•	Revenue performance
	•	Customer segmentation
	•	Discount effectiveness
	•	Shipping preferences
	•	Product performance
  
This project demonstrates an end-to-end analytics workflow:
MySQL → Python (Pandas + Plotly) → Streamlit Dashboard

Tech Stack
	•	Python
	•	Pandas
	•	NumPy
	•	Plotly
	•	MySQL
	•	SQLAlchemy
	•	PyMySQL
	•	Streamlit
  
Project Workflow
1. Database Setup
	•	Created a MySQL database: customer_behavior
	•	Imported customer dataset into MySQL
	•	Structured data for analytical querying
	•	Connected MySQL directly to Python using SQLAlchemy

2. SQL Analysis 
Key business questions answered using SQL:
	•	Customers who used discounts but spent above average
	•	Top 3 most purchased products within each category
	•	Discount rate per product
	•	Customer segmentation (New / Returning / Loyal)
	•	Category-wise revenue analysis
	•	Product rating analysis
	•	Shipping preference analysis

3. Customer Segmentation Logic
Customers were segmented based on previous_purchases
1–5 as New
6–10 as Returning
11+ as Loyal

4. Dashboard Sections
 Business Overview
	•	Total Revenue
	•	Total Orders
	•	Average Purchase Amount
	•	Revenue by Category
	•	Top Products by Revenue
 Customer Segmnetation
	•	Segment Distribution
	•	Revenue by Segment
	•	Age Group Spending Patterns
 Behavioural Patterns
	•	Discount Impact on Spending
	•	Shipping Preference Heatmap
	•	Purchase Frequency vs Revenue

5. Key Insights
	•	Loyal customers contribute significantly to overall revenue.
	•	Free shipping is the most preferred shipping method across categories.
	•	Discounts increase average purchase amounts.
	•	Certain product categories dominate revenue contribution.
	•	Some products rely heavily on discounts to drive sales.


