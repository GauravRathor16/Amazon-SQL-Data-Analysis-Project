# Amazon-SQL-Data-Analysis-Project
This project demonstrates SQL-based data cleaning, transformation, and business analysis on an Amazon sales dataset containing information about users, products, and reviews.



## 📂 Files Included

- `Amazon_data_analysis.sql` – Full SQL script used for:
  - Data cleaning
  - Duplicate handling
  - Review and user analysis
  - Business insights extraction

---

## 🔧 Database Used

- **SQL Server** (T-SQL syntax)

---

## 🧹 Data Cleaning Steps

- Removed duplicate `review_id` and `user_id` entries
- Removed junk usernames like `'??????'`, `'$'`, `'@'`, `'sic'`, etc.
- Checked for invalid/malformed usernames
- Ensured referential integrity between `User`, `Review`, and `Product` tables

---

## 🧠 Business Analysis Covered

| # | Problem | Output |
|--|---------|--------|
| 1 | List all products with category & price | Product catalog |
| 2 | Find users who posted reviews | Active users |
| 3 | Count products in each category | Category-wise inventory |
| 4 | Show average rating per product | Product feedback |
| 5 | Join reviews with product & user names | Full review context |
| 6 | Top 5 products by average rating (min 5 reviews) | Quality leaderboard |
| 7 | Users who reviewed > 3 products | Engaged users |
| 8 | Categories with avg. discount > 20% | Pricing insights |
| 9 | Products with rating > 4.5 & discount > 30% | Best deal products |
| 10 | Top 3 most reviewed products per category | Category popularity |
| 11 | Product count per final category | Inventory breakdown |
| 12 | Products with >6 reviews & rating <3.5 | Poor performing items |
| 13 | Average price per category | Price benchmarking |
| 14 | Top 5 products by rating count | Popular products |
| 15 | Estimated revenue per product | Sales estimation |
| 16 | Users who reviewed >5 distinct products | Power users |
| 17 | Top 5 products with highest discount per category | Best offers |
| 18 | Products with low rating but high review volume | Reputation risks |

---

## 📌 How to Use

1. Open the `Amazon_data_analysis.sql` file in SQL Server Management Studio (SSMS) or Azure Data Studio.
2. Run scripts step-by-step to:
   - Clean the dataset
   - Generate insights
3. Adjust table/database names as per your setup.

---

## 👨‍💻 Author

**Gaurav Rathor**  
🔗 [GitHub](https://github.com/GauravRathor16) | 🔗 [LinkedIn](https://www.linkedin.com/in/gaurav1608/)

---

## ⭐ Give a Star!

If this helped you, feel free to ⭐ the repo!

