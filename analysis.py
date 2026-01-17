import pandas as pd
# 1. Load the Excel file into a DataFrame
file_path = "online_retail_II.xlsx"  # Make sure the file is in your project folder
df = pd.read_excel(file_path)

# Perform a quick initial check to understand the dataset
print("Initial dataset shape:", df.shape)
print("Columns:", df.columns)
print("Missing values per column:\n", df.isnull().sum())

# 2. Remove canceled orders (Invoice codes starting with 'C')
df = df[~df['Invoice'].astype(str).str.startswith('C')]
# 3. Remove rows where Customer ID is missing
df = df.dropna(subset=['Customer ID'])
# 4. Remove rows where Description is missing
df = df.dropna(subset=['Description'])
# 5. Create a Revenue column by multiplying Quantity and Price
df['Revenue'] = df['Quantity'] * df['Price']
# 6. Extract Year and Month from InvoiceDate for potential analysis
df['Year'] = df['InvoiceDate'].dt.year
df['Month'] = df['InvoiceDate'].dt.month
# 7. Perform a quick check after cleaning
print("\nAfter cleaning:")
print("Dataset shape:", df.shape)
print("Missing values per column:\n", df.isnull().sum())
print("\nFirst 5 rows:")
print(df.head())
# 8. Save the cleaned dataset as a CSV file for SQL or Tableau analysis
df.to_csv("online_retail_II_cleaned.csv", index=False)
print("\nCleaned dataset saved as 'online_retail_II_cleaned.csv'.")
