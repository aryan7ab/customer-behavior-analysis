import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
from sqlalchemy import create_engine
import os

st.set_page_config(page_title="Customer Behavior Dashboard", layout="wide")

st.title("📊 Customer Behavior Analysis Dashboard")


# --- MySQL Connection ---
username = "root"
password = "aryan123"
host = "localhost"
port = "3306"
database = "customer_behavior"

engine = create_engine(
    f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}"
)

# Load data from MySQL
query = "SELECT * FROM customer"
df = pd.read_sql(query, engine)

df["previous_purchases"] = pd.to_numeric(df["previous_purchases"], errors="coerce")

conditions = [
    df["previous_purchases"].between(1, 5),
    df["previous_purchases"].between(6, 10),
    df["previous_purchases"] >= 11
]

choices = ["New", "Returning", "Loyal"]

df["customer_segment"] = np.select(conditions, choices, default="Other")

st.sidebar.header("🔎 Filters")

selected_category = st.sidebar.multiselect(
    "Select Category",
    options=df["category"].unique(),
    default=df["category"].unique()
)

selected_segment = st.sidebar.multiselect(
    "Select Customer Segment",
    options=df["customer_segment"].unique(),
    default=df["customer_segment"].unique()
)

df = df[
    (df["category"].isin(selected_category)) &
    (df["customer_segment"].isin(selected_segment))
]

st.subheader("📌 Business Overview")

col1, col2, col3 = st.columns(3)

col1.metric("Total Revenue", f"${df['purchase_amount'].sum():,.0f}")
col2.metric("Total Orders", len(df))
col3.metric("Avg Purchase", f"${df['purchase_amount'].mean():.2f}")

category_rev = df.groupby("category")["purchase_amount"].sum().reset_index()

fig1 = px.bar(category_rev,
              x="category",
              y="purchase_amount",
              title="Revenue by Category")

st.plotly_chart(fig1, use_container_width=True)

st.subheader("👥 Customer Segmentation")

segment_counts = df["customer_segment"].value_counts().reset_index()
segment_counts.columns = ["customer_segment", "count"]

fig2 = px.pie(segment_counts,
              names="customer_segment",
              values="count",
              title="Customer Segment Distribution")

st.plotly_chart(fig2, use_container_width=True)

st.subheader("🧠 Behavioral Insights")

discount_spend = df.groupby("discount_applied")["purchase_amount"].mean().reset_index()

fig3 = px.bar(discount_spend,
              x="discount_applied",
              y="purchase_amount",
              title="Discount Impact on Spending")

st.plotly_chart(fig3, use_container_width=True)