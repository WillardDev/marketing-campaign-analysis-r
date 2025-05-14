#load the plastic_waste.csv data file
market_data <- read.csv("C:\\Users\\wille\\OneDrive\\Documents\\Whatsapp documents\\processed_marketing_data.csv")
market_data

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# 1. Relationship between Age and Response
plot1 <- ggplot(market_data, aes(x = Age, fill = factor(Response))) +
  geom_histogram(binwidth = 5, position = "dodge") +
  labs(title = "Age Distribution by Response",
       x = "Age",
       y = "Count",
       fill = "Response") +
  theme_minimal()
plot1

# 2. Income Distribution by Response
plot2 <- ggplot(market_data, aes(x = factor(Response), y = Income)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Income Distribution by Response",
       x = "Response",
       y = "Income") +
  theme_minimal()
plot2

# 3. Total Spent vs Response
plot3 <- ggplot(market_data, aes(x = factor(Response), y = TotalSpent)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Total Spent by Response",
       x = "Response",
       y = "Total Spent") +
  theme_minimal()
plot3

# 4. Number of Purchases by Channel and Response
plot4 <- market_data %>%
  select(Response, NumWebPurchases, NumCatalogPurchases, NumStorePurchases) %>%
  gather(key = "Channel", value = "Purchases", -Response) %>%
  ggplot(aes(x = Channel, y = Purchases, fill = factor(Response))) +
  geom_boxplot() +
  labs(title = "Purchase Distribution by Channel and Response",
       x = "Purchase Channel",
       y = "Number of Purchases",
       fill = "Response") +
  theme_minimal()
plot4

# 5. Response Rate by Education
plot5 <- ggplot(market_data, aes(x = Education, fill = factor(Response))) +
  geom_bar(position = "fill") +
  labs(title = "Response Rate by Education Level",
       x = "Education",
       y = "Proportion",
       fill = "Response") +
  theme_minimal()
plot5

# 6. Scatter plot of Total Spent vs Income by Response
plot6 <- ggplot(market_data, aes(x = Income, y = TotalSpent, color = factor(Response))) +
  geom_point(alpha = 0.6) +
  labs(title = "Total Spent vs Income by Response",
       x = "Income",
       y = "Total Spent",
       color = "Response") +
  theme_minimal()
plot6

# 7. Products Distribution by Response
plot7 <- market_data %>%
  select(Response, MntWines, MntFruits, MntMeatProducts, MntFishProducts, MntSweetProducts, MntGoldProds) %>%
  gather(key = "Product", value = "Amount", -Response) %>%
  ggplot(aes(x = Product, y = Amount, fill = factor(Response))) +
  geom_boxplot() +
  labs(title = "Product Spending Distribution by Response",
       x = "Product Category",
       y = "Amount Spent",
       fill = "Response") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
plot7

# 8. Number of Deals vs Response
plot8 <- ggplot(market_data, aes(x = NumDealsPurchases, fill = factor(Response))) +
  geom_histogram(position = "dodge", bins = 30) +
  labs(title = "Number of Deals Purchased by Response",
       x = "Number of Deals Purchased",
       y = "Count",
       fill = "Response") +
  theme_minimal()
plot8

# Summary statistics
summary_stats <- market_data %>%
  group_by(Response) %>%
  summarise(
    avg_age = mean(Age),
    avg_income = mean(Income),
    avg_total_spent = mean(TotalSpent),
    avg_deals = mean(NumDealsPurchases),
    total_customers = n()
  )
summary_stats

rmarkdown::render("C:\\Users\\wille\\OneDrive\\Documents\\Whatsapp documents\\marketing_analysis.Rmd", output_format = "html_document")
