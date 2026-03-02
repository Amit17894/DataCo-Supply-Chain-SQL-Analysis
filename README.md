# Supply Chain Logistics & Profitability Audit
**Tools Used:** MySQL Workbench, SQL (CTEs, Window Functions, DDL/DML)

### 📌 Project Overview
An end-to-end SQL audit of the DataCo Supply Chain dataset (~180k rows) to identify bottlenecks 
in lead times and their correlation with profit margins.

### 🚀 Key Technical Challenges
* **Data Ingestion:** Handled Error 1366 (encoding) and 2013 (timeouts) during bulk loading.
* **Date Normalization:** Resolved inconsistent US-format date strings using `STR_TO_DATE` and `REPLACE`.

### 📊 Business Insights
1. **Systemic Delay:** Discovered a **54% constant late-delivery rate**, suggesting a process failure rather than seasonality.
2. **Geographic Bottlenecks:** Isolated 20+ cities with a persistent **3-4 day gap** between scheduled and actual shipping.
3. **Profit Decoupling:** Proved that profit margins remain stable despite delays, suggesting the business has "priced-in" its operational inefficiencies.