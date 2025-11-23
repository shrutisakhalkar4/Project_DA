import pandas as pd

df = pd.read_csv("Retail_sales.csv", encoding="latin1")   # or your filename
df.head() 

df.isnull().sum()

customer_sales = df.groupby("Customer ID")["Sales"].sum().sort_values(ascending=False)
customer_sales.head(10)

df["Order Date"] = pd.to_datetime(df["Order Date"], format="mixed")
df["Order Date"].dtype
df["Order Date"].head(10)
df["Order Date"].isnull().sum()

#monthly revenue
monthly_sales = df.resample("M", on="Order Date")["Sales"].sum()
monthly_sales.head()

#moving average
moving_avg = monthly_sales.rolling(3).mean()
moving_avg.head()

# total sales per customer
customer_sales = df.groupby("Customer ID")["Sales"].sum()
customer_sales.head()

# 4. Customer Segmentation (based on spending)
segments = pd.cut(
    customer_sales,
    bins=[0, 2000, 5000, float("inf")],
    labels=["Regular", "Premium", "VIP"]
)

segments.value_counts()

# Top 10 customers (Lifetime Value)
top_10 = customer_sales.sort_values(ascending=False).head(10)
top_10