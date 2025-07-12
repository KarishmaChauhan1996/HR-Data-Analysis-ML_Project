# HR-Data-Analysis-Project

## Overview

This project presents a comprehensive analysis of employee attrition using SQL, Python, and Power BI. 
The goal is to identify key drivers of attrition and build a predictive model to proactively flag at-risk employees.

## Objectives

Employee turnover is a critical challenge for organizations. This project aims to:
- Perform exploratory and statistical analysis to uncover key factors associated with employee attrition.
- Visualize trends and patterns using an interactive Power BI dashboard.
- Develop a logistic regression model to predict the likelihood of attrition.
- Address class imbalance using SMOTE to improve prediction quality.
- Enable early detection of high-risk individuals.
- Support strategic HR interventions through insights and predictive modeling.

## Data Overview

The analysis is based on the following datasets (merged via `EmployeeNumber`):

- **Attrition Data** (`df_attrition`): Attrition flag (Yes/No)
- **Employee Demographics** (`df_employee_info`): Age, Gender, Marital Status, Education, etc.
- **Job Details** (`df_job_details`): Department, Business Travel, Overtime, Salary, etc.
- **Satisfaction Survey** (`df_job_satisfaction`): Job Satisfaction, Environment Satisfaction, Work-Life Balance, etc.

## Tools & Technologies

- **SQL** – Data extraction, transformation, and aggregation
- **Python** – Data preprocessing, EDA, correlation analysis, and predictive modeling
- **Libraries:** Pandas, NumPy, scikit-learn, imblearn, statsmodels, matplotlib, seaborn
- **Power BI** – Interactive dashboard creation for HR insights

## Data Analysis Highlights

- Used SQL and Python for Data Analysis. Identified **OverTime**, **Job Satisfaction**, **Marital Status (Single)**, and **Environment Satisfaction** as the most positively correlated features with attrition.
- Used Python-based EDA (heatmaps, bar plots, distribution charts) to assess patterns across job levels, roles, and performance metrics.
- Detected class imbalance (84% No Attrition vs. 16% Yes), which significantly affected model performance in early experiments.

---

## Predictive Modeling

#### Model Used
- **Logistic Regression** (interpretable and baseline model)
- Addressed class imbalance using **SMOTE** (Synthetic Minority Oversampling Technique)

#### Modeling Pipeline
1. Categorical encoding & feature scaling
2. Train-test split (stratified)
3. SMOTE resampling on training data
4. Logistic regression model training
5. Model evaluation using multiple metrics

#### Results

| Metric                  | Value (Test Set)        |
|-------------------------|-------------------------|
| Accuracy                | 83%                     |
| F1-Score (Attrition)    | 0.34                    |
| ROC-AUC Score           | 0.77                    |
| Recall (Attrition Class)| ↑ from 19% to **45%**   |

The model improved the ability to identify actual attrition cases while maintaining reasonable overall accuracy.


## Power BI Dashboard

An interactive Power BI dashboard was developed to support:
- **Attrition Breakdown by Department, Gender, Job Role**
- **Attrition Rate vs. Overtime, Salary, and Tenure**
- **Slicer filters** for Education, Business Travel, Work-Life Balance, and other factors
- **Dynamic KPI cards** to track overall attrition and high-risk categories

## Project Structure

├── data/ # Raw and processed datasets
├── notebooks/ # Jupyter notebooks for EDA and modeling
├── scripts/ # Python scripts for cleaning and prediction
├── powerbi/ # Power BI dashboard file (.pbix)
├── outputs/ # Plots, reports, and metrics
├── README.md # Project documentation

## Key Learnings

- Importance of addressing class imbalance in classification problems
- Trade-offs between recall and precision in HR risk prediction
- Integration of analytics tools (SQL, Python, Power BI) for full-cycle insight delivery

---

## Potential Enhancements

- Incorporate advanced models like **Random Forest** or **XGBoost** with hyperparameter tuning
- Build a web-based HR tool for real-time attrition risk scoring
- Conduct **SHAP/feature attribution** for model interpretability
- Deploy the model using Flask or Streamlit for internal HR access
