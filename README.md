# Data Science using Stata
Material for the YouTube course "Data Science using Stata: Complete Beginners Course" is available here including slides, data sets, and Stata do files. You can find the course on the channel 
#### [YUNIKARN](https://www.youtube.com/channel/UCb0qAKEAwNC0FNatapc-yZg) 

## INTRO:
#### [YouTube Video 1](https://youtu.be/rJfsuEoTPP8)

## Lecture 1: Introduction to statistical models and Stata
We explore statistical models and start playing with Stata. I show you how to load data into Stata from Excel or csv files.
#### [YouTube Video 2](https://youtu.be/zB5y16bfz64)

## Lecture 2: Exploring data 
I cover data types, sampling issues, outliers, and missing values.
#### [YouTube Video 3](https://youtu.be/CgBLnSP6wSw)

### 2a: Transforming variables 
I discuss whether you should transform variables (e.g., log transformation), how transformation affects linear relationships, and whether variables should be normally distributed for regression analysis. I show you how to AVOID COMMON MISTAKES when transforming variables.
#### [YouTube Video 4](https://youtu.be/TRlppNXqfMo)

### 2b: Exporting tables
I introduce the estpost and esttab commands, which enable you to export tables from Stata to Word, Excel, or other applications. I show you how to modify formats and optimise the layout. This produces production-ready tables for your dissertation project, consulting report or academic paper. NO NEED TO ADJUST TABLES BY HAND - LET STATA TAKE CARE OF IT!
#### [YouTube Video 5](https://youtu.be/3gR83QE6704)

## Workshop 1: Descriptive Analysis: Worked Example
Now it is your turn! Download the data and try to answer the questions for Workshop 1 (see slides). This video will walk you through a Descriptive Data Analysis step-by-step. We generate new variables, display descriptive statistics, and explore large survey data. 
#### [YouTube Video 6](https://youtu.be/16qaab1S0WY)

## Lecture 3: Regression analysis
This video explains Regression Analysis without using theory. We will conduct a regression analysis in Stata and interpret the output. In particular, we explore correlations, scatter plots, linear models, OLS, dummies, and predictions.
#### [YouTube Video 7](https://youtu.be/38GXnMGp_-I)

**Chapters**
- 0:00 Welcome & Overview
- 1:19 Correlations & Scatter Plots
- 6:23 Distributions & Transformations
- 7:04 Linear Model
- 9:48 Ordinary Least Squares (OLS)
- 16:59 Application using Stata
- 38:12 Regression Output & Interpretation
- 46:53 Dummy Variables
- 52:52 Fitted Values
- 55:55 Model Assumptions

### 3a: What are Degrees of Freedom?
This video explains the concept of degrees of freedom.  Using artificial data, we illustrate the minimum number of observations needed to determine a regression line in two dimensions (or higher dimensions). We show the impact on R-squared and demonstrate the adjusted R-squared. Using examples, we highlight the impact of additional observations and explanatory variables on degrees of freedom and R-squared.
#### [YouTube Video 8](https://youtu.be/W88W1GT4Gy8)

## Lecture 4: Post estimation analysis

### 4a: What is Multicollinearity?
This video explains multicollinearity and its consequences for regression analysis. We discuss how to detect multicollinearity and how to address the problem. Finally, we demonstrate multicollinearity using data on commodity prices. 
#### [YouTube Video 9](https://youtu.be/oRD6Dk7O3vE)

**Chapters**
- 0:00 Multicollinearity
- 0:24 What is the problem?
- 2:43 How to fix it?
- 4:50 How to detect multicollinearity?
- 7:30 Example in Stata

### 4b: What is Heteroskedasticity?
This video explains heteroskedasticity and its consequences for regression analysis. We discuss how to detect heteroskedasticity and how to address the problem. Finally, we demonstrate heteroskedasticity using data on yields in farming. 
#### [YouTube Video 10](https://youtu.be/cF01A1w2zTQ)

**Chapters**
- 0:00 Welcome
- 0:44 Impact on p-values
- 2:07 Detecting the problem
- 4:56 How to fix it?
- 5:42 Worked example in Stata

### 4c: How to fix an Omitted Variable Bias?
This video explains how to detect and fix an omitted variable bias. If you forget to include an important explanatory variable in your regression model, an omitted variable bias can occur. I explain how you can detect this problem using the Ramsey RESET test. This test also indicates non-linear relationships. We will explore how we can distinguish between non-linear effects and omitted variables using fitted values. 
#### [YouTube Video 11](https://youtu.be/iHEpPusChpE)

**Chapters**
- 0:00 Omitted Variable Bias
- 1:34 Worked Example in Stata
- 3:55 Log Transformation
- 5:08 Regression Model
- 6:50 Ramsey RESET Test
- 9:10 Higher Orders
- 15:36 Collapse Command
- 17:01 Visualisation

### 4d: Detecting Endogeneity
This video explains how to detect endogeneity. Endogeneity is a common problem in regression analysis. I explain how you can detect this problem using an auxiliary regression approach. We discuss strategies to address endogeneity. 
#### [YouTube Video 12](https://youtu.be/RBHDPEimW_Y)

**Chapters**
- 0:00 Welcome
- 0:15 What is Endogeneity?
- 1:42 Detecting Endogeneity
- 3:08 Worked Example in Stata
- 11:33 How to fix Endogeneity?

## Lecture 5: Analysing panel data
### 5a: Introduction to Panel Data
This video explains how to work with panel data. We discuss the benefits of using panel data, including Granger causality and the assessment of policy changes. We introduced fixed and random effects models, which we implement in Stata. The regression otuputs are explained and compared.  
#### [YouTube Video 13](https://youtu.be/BsCCUYTfiHQ)

**Chapters**
- 0:00 Introduction to Panel Data
- 0:26 Benefits of Panel Data
- 1:23 Analysing Policy Changes
- 1:58 Causality
- 3:01 Time Lags
- 3:19 Panel Data Models
- 3:59 SOLS or POLS
- 4:20 Fixed & Random Effects
- 7:11 Worked Example in Stata
- 8:40 Panel Regressions in Stata
- 9:36 The tsset Command
- 11:07 Interpretation of Output
- 13:46 Model Comparison

### 5b: Fixed or Random Effects? Does the Hausman Test fail?
This video discusses whether you should use fixed or random effects for your panel data analysis. We explain how the Hausman test works and - most importantly - when the Hausman test fails! We cover biased estimators, the efficiency of estimators, and the implementation in Stata. Again, I focus on an intuitive understanding of the methods - no theory - just data fun!
#### [YouTube Video 14](https://youtu.be/ywgrQCO5rHE)

**Chapters**
- 0:00 Fixed or Random Effects
- 0:26 Worked Example
- 0:53 How does the Hausman Test work?
- 1:12 Bias
- 1:45 Efficiency
- 3:21 Implementation in Stata
- 4:42 Interpretation of Output
- 6:23 Warning: Hausman Test fails!

### 5c: Serial Correlation in Panel Data
This video explains the impact of serial correlation in panel data analysis. We discuss the underlying reasons for serial correlation. Then we introduce a test based on Wooldridge (2002). To fix serial correlation, we explore the Newey-West Estimator (robust estimation) and Dynamic Panel Data Estimation. Finally, we have some fun in Stata. 
#### [YouTube Video 15](https://youtu.be/Tqp-s8UK1g0)

**Chapters**
- 0:00 Serial Correlation in Panel Data
- 0:40 Reasons for Serial Correlation
- 1:19 Testing for Serial Correlation
- 2:46 Newey-West Estimator
- 3:47 Dynamic Panel Data Estimation
- 4:12 Worked Example in Stata
- 5:26 Interpretation of Output
- 6:13 Solutions in Stata

### 5d: Interaction Effects in Panel Data
This video explains interaction effects in panel data. It is common that certain groups of observations (e.g., companies, countries) exhibit differences in behaviour. These differences can be modelled using interaction effects. We explore shifts in the intercept and slope coefficient. In addition, I demonstrate how these models can be implemented in Stata.
#### [YouTube Video 16](https://youtu.be/PaWgU3Zqceg)

**Chapters**
- 0:00 Interaction Effects
- 1:13 Shift in Intercept
- 2:21 Illustration of Shift
- 2:40 Interaction Term
- 4:08 Illustration of Interaction Effect
- 4:31 Implementation in Stata

### 5e: How does the Test for Serial Correlation work?
This video comes with a TRIGGER WARNING! It contains mathematics, which some viewers might find distressing. I explain how the serial correlation test developed by Wooldridge (2002) can be derived. We cover the null hypothesis and related assumptions, iid distributed error terms, covariance and variance formulas. We also highlight linear operators and their properties. There is a little surprise at the end of the video!
#### [YouTube Video 17](https://youtu.be/_TiVIly-QIg)


## Lecture 6: Binary choice models
### 6a: Logistic Regression: An Introduction using Stata 
This video introduces logistic regressions. We discuss binary choice models, where the dependent variable is either a positive or negative outcome (e.g., a decision). The problem is illustrated graphically - how to map a linear model to an interval suitable for modelling a probability. Most decision processes remain unobserved; hence, we briefly discuss latent variables. Finally, I demonstrate how these models can be implemented in Stata. Predicted probabilities are plotted to visualise the model, and we explore classifications. 
#### [YouTube Video 18 - 18/04/2022 at 10am GMT](https://youtu.be/RH7FAM4gCf0)

**Chapters**
- 0:00 Binary Choice
- 1:34 Illustration of Problem
- 5:38 Latent Variable
- 9:48 Implementation in Stata
- 14:43 Plot Predicted Probabilities
- 17:51 Classification


## Lecture 7: Model specification

## Lecture 8: Measuring the immeasurable: CFA and SEM!
