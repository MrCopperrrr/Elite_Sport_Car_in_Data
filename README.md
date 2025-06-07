# Probability_and_Statistics_Assignment

## Project Overview:

This project performs statistical analysis on a dataset of elite sports cars to explore the factors that influence their prices. The analysis includes data preprocessing, descriptive statistics, inferential statistics (hypothesis testing), and model building (linear regression).

## 1. Data Source:

The data is sourced from the file `Elite Sports Cars in Data.csv`.

## 2. Data Preprocessing:

*   **Loading Data:** The data is read from the CSV file using `read.csv()`.
*   **Previewing Data:** The first 6 rows of the data are displayed using `head()`.
*   **Selecting Variables:**  A new dataset (`NewData`) is created, focusing on variables relevant to regression analysis with `Price` as the dependent variable.
*   **Variable Inspection:** The structure of the new dataset is checked using `str()`.
*   **Missing Value Handling:**
    *   Total number of missing values is checked with `sum(is.na(NewData))`.
    *   Number of missing values per variable is checked with `colSums(is.na(NewData))`.
*   **Type Conversion:** Categorical variables (Condition, Market\_Demand, Fuel\_Type, Drivetrain, Transmission, Safety\_Rating, Number\_of\_Owners) are converted to factor variables using `as.factor()`.

## 3. Descriptive Statistics:

*   **Numerical Variables:**
    *   A subset of numerical variables (`num_vars`) is created.
    *   Descriptive statistics (Mean, SD, Min, Q1, Median, Q3, Max) are calculated for each numerical variable and stored in a data frame (`summary_stats`).
    *   The summary statistics are printed, rounded to 2 decimal places.
*   **Categorical Variables:** Frequency tables are generated for each categorical variable using `table()`.

## 4. Data Visualization:

*   **Histogram of Price:** A histogram is created to visualize the distribution of the `Price` variable.
*   **Scatter Plots:** Scatter plots are generated to explore the relationships between `Price` and each continuous variable (Horsepower, Torque, Top\_Speed, etc.).
*   **Boxplots:** Boxplots are generated to visualize the relationship between `Price` and each categorical variable (Condition, Market\_Demand, etc.).
*   **Correlation Matrix:**  A Pearson correlation matrix is calculated for numerical variables using `cor()`.
*   **Correlation Plot:** A correlation plot is generated using `corrplot()` to visualize the correlation matrix.

## 5. Inferential Statistics:

*   **Data Splitting:** The dataset is split into training (80%) and testing (20%) sets using `sample()` and `set.seed()` for reproducibility.
*   **Model Building:**
    *   A multiple linear regression model (`model_lm`) is built using all available predictors on the training data.
    *   A reduced multiple linear regression model (`model_lm2`) is built using `Top_Speed` and `Safety_Rating` as predictors.
*   **Model Summary:** The summary of each model is printed using `summary()`.
*   **Model Diagnostics:** Diagnostic plots are generated for the reduced model (`model_lm2`) using `plot()`.
    *   Residuals vs Fitted: Checks for linearity and homoscedasticity.
    *   Normal Q-Q: Checks for normality of residuals.
    *   Scale-Location: Checks for homoscedasticity.
    *   Residuals vs Leverage: Identifies influential points.
*   **Durbin-Watson Test:**  The Durbin-Watson test is performed using `dwtest()` to check for autocorrelation in the residuals.
*   **QQ Plot for Residuals:**  A QQ plot is generated using `qqPlot()` to assess the normality of residuals.
*   **Non-Constant Variance Score Test:** The `ncvTest` is performed to check for non-constant error variance
*   **Prediction and Evaluation:**
    *   Predictions are made on the test data using `predict()`.
    *   Residuals are calculated on the test data.
    *   Evaluation metrics (MAE, MSE, RMSE, R-squared) are calculated.
    *   Results is plotted using `ggplot2`.

## 6. Extensions (Exploratory Analysis):

*Two extensions of the multiple linear regression have been executed:
    *   New variable called Log\_Price is added to the analysis and the first model is built.
    *  After that, the second model is built with Log\_Price as dependent variable, and Top\_Speed+Safety\_Rating as independent variables.
    *   Create Log transformation on every variable of the dataset to fix distribution.

## 7. Hypothesis Testing (One-Sample Test):

*   **Normality Test:**
    *   A QQ plot is generated for the `Price` variable.
    *   The Shapiro-Wilk test for normality is performed using `shapiro.test()`.
*   **T-Test:**  A one-sample t-test is performed to test the hypothesis that the mean price is greater than 200,000 using `t.test()`. The t-critical threshold is given.

## 8. Libraries Used:

*   `dplyr`
*   `ggplot2`
*   `corrplot`
*   `lmtest`
*   `car`
*   `scales`

