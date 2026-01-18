import pandas as pd

# Load Excel without converting date
file_path = "online_retail_II.xlsx"
df = pd.read_excel(file_path, dtype={'InvoiceDate': str})

# Rename column
df.columns = ['Invoice', 'StockCode', 'Description', 'Quantity', 
              'InvoiceDate', 'Price', 'CustomerID', 'Country']

# Drop rows with missing critical fields (except InvoiceDate)
df = df.dropna(subset=['StockCode', 'CustomerID', 'Description'])

# Remove canceled orders
df = df[~df['Invoice'].astype(str).str.startswith('C')]

# Create Revenue column
df['Revenue'] = df['Quantity'] * df['Price']
# error check
print("\nAfter cleaning:")
print("Dataset shape:", df.shape)
print(df.head())

# Save cleaned CSV
df.to_csv("online_retail_II_cleaned.csv", index=False)
print("\nCleaned dataset saved as 'online_retail_II_cleaned.csv'.")