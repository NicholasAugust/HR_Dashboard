# 📊 HR Analytics Dashboard (Power BI + SQL)

This project is an interactive HR Analytics Dashboard developed using Power BI, with backend data transformation and metric calculations performed in SQL. The goal is to deliver actionable workforce insights from raw employee data using a structured and analytical approach.

---

## 🔍 Project Overview

The dashboard answers key HR questions such as:

- 🧑‍🤝‍🧑 What is our current headcount across departments?
- 📈 How many employees joined or exited each month?
- 🧮 What is the attrition rate and how does it trend over time?
- ⚖️ What is the gender distribution across active employees?
- 🏢 Which departments are experiencing the highest turnover?
- ⏳ How long do employees typically stay (tenure distribution)?
- 🔮 Can we forecast headcount trends for the coming months?

These insights were developed using structured SQL queries followed by interactive dashboards built in Power BI.

---

## 🧠 Business Questions Solved Using SQL

The following metrics were calculated directly in SQL:

| SQL Query | Business Question |
|-----------|-------------------|
| **Headcount** | How many active employees are there currently? |
| **Joiners by Month** | How many new hires joined each month? |
| **Leavers by Month** | How many employees exited each month? |
| **Gender Ratio** | What is the gender breakdown of current employees? |
| **Attrition Rate** | What percentage of employees leave the organization monthly? |
| **Department Headcount** | Which departments have the most employees? |
| **Top 5 by Attrition** | Which departments are losing the most people? |
| **Tenure Buckets** | How long are employees staying before leaving? |
| **Turnover Rate** | What is the rate at which employees are being replaced? |
| **Net Growth** | What’s the net increase or decrease in workforce over time? |

All these queries were written in **SQLite** and used as input tables in Power BI.

---

## 🧰 Tools & Technologies

- **Power BI**: Dashboard creation, DAX for metrics, forecasting
- **SQLite**: Metric calculation, data transformation
- **Excel**: Initial data formatting
- **GitHub**: Version control and portfolio hosting

---

## 📂 Repository Contents

| File/Folder | Description |
|-------------|-------------|
| `HR_Analytics_Dashboard.pbix` | Final Power BI file |
| `employee_data.sqlite` | Database file with raw employee data |
| `SQL_queries.sql` | SQL file with all metric queries |
| `Screenshots/` | Dashboard preview images |
| `README.md` | This documentation file |

---

## 🗂 Dataset Source

The data was sourced from a public dataset available on **[Kaggle](https://www.kaggle.com/)**.  
All records are anonymized and used for educational purposes only.

---

## 📸 Dashboard Preview
![Dashboard Preview]
![Dashboard Preview_1](https://github.com/user-attachments/assets/50f219db-9a26-414a-9261-70534428c57e)
![Dashboard Preview_2](https://github.com/user-attachments/assets/4c5e1be8-f8f6-45a4-bf3d-4a2ffabbdc36)

---

## 🚀 How to Use

1. Clone or download this repository
2. Open `HR_Analytics_Dashboard.pbix` in Power BI Desktop
3. If needed, update the data source path to the local `.sqlite` file
4. Explore insights using filters and interact with the visuals

---

## 🙌 Acknowledgements

Special thanks to **Kaggle** for providing the dataset and to the open-source community for continuous learning support.

---

## 📬 Let's Connect

Feel free to reach out via [LinkedIn](https://www.linkedin.com/in/nicholas-anil-koshy/) if you’d like to collaborate or have feedback.

---
