#3. TIEN XU LY SO LIEU

# Doc du lieu tu file CSV
CarData <- read.csv("D:/BTL XSTK/Elite Sports Cars in Data.csv")

# Xem truoc 6 dong dau cua du lieu
head(CarData)

# Tai thu vien dplyr de xu ly du lieu
library(dplyr)
# Tao bo du lieu moi chi gom cac bien quan trong de phan tich hoi quy voi Price
NewData <- CarData %>%
  select(Price,
         Horsepower, Torque, Top_Speed, Acceleration_0_100, Engine_Size,
         Fuel_Efficiency, CO2_Emissions, Weight,
         Mileage, Condition, Market_Demand,
         Insurance_Cost, Production_Units,
         Safety_Rating, Number_of_Owners,
         Fuel_Type, Drivetrain, Transmission)

# Kiem tra cau truc cua du lieu moi
str(NewData)

# Kiem tra tong so gia tri khuyet
sum(is.na(NewData))

# Kiem tra so luong gtri khuyet theo tung bien
colSums(is.na(NewData))

# Chuyen doi cac bien phan loai sang kieu factor
NewData$Condition <- as.factor(NewData$Condition)
NewData$Market_Demand <- as.factor(NewData$Market_Demand)
NewData$Fuel_Type <- as.factor(NewData$Fuel_Type)
NewData$Drivetrain <- as.factor(NewData$Drivetrain)
NewData$Transmission <- as.factor(NewData$Transmission)
NewData$Safety_Rating <- as.factor(NewData$Safety_Rating)
NewData$Number_of_Owners <- as.factor(NewData$Number_of_Owners)

#4. THONG KE MO TA

# Lay cac bien lien tuc
num_vars <- NewData[sapply(NewData, is.numeric)]

# Tinh thong ke mo ta
summary_stats <- data.frame(
  Mean = sapply(num_vars, mean),
  SD = sapply(num_vars, sd),
  Min = sapply(num_vars, min),
  Q1 = sapply(num_vars, function(x) quantile(x, 0.25)),
  Median = sapply(num_vars, median),
  Q3 = sapply(num_vars, function(x) quantile(x, 0.75)),
  Max = sapply(num_vars, max)
)
# In ket qua thong ke mo ta
print(round(summary_stats, 2))

# Bang tan so cho cac bien phan loai
table(NewData$Condition)
table(NewData$Market_Demand)
table(NewData$Fuel_Type)
table(NewData$Drivetrain)
table(NewData$Transmission)
table(NewData$Safety_Rating)
table(NewData$Number_of_Owners)

# Thu vien ve do thi
library(ggplot2)
ggplot(NewData, aes(x = Price)) +
  geom_histogram(binwidth = 20000, fill = "steelblue", color = "white") +
  labs(title = "Histogram of Price", x = "Price", y = "Tần số") +
  scale_x_continuous(labels = scales::comma)

# Scatter plots giua Price va cac bien lien tuc
ggplot(NewData, aes(x = Horsepower, y = Price)) + geom_point() + labs(title = "Price vs Horsepower")
ggplot(NewData, aes(x = Torque, y = Price)) + geom_point() + labs(title = "Price vs Torque")
ggplot(NewData, aes(x = Top_Speed, y = Price)) + geom_point() + labs(title = "Price vs Top Speed")
ggplot(NewData, aes(x = Acceleration_0_100, y = Price)) + geom_point() + labs(title = "Price vs Acceleration 0-100")
ggplot(NewData, aes(x = Engine_Size, y = Price)) + geom_point() + labs(title = "Price vs Engine Size")
ggplot(NewData, aes(x = Fuel_Efficiency, y = Price)) + geom_point() + labs(title = "Price vs Fuel Efficiency")
ggplot(NewData, aes(x = CO2_Emissions, y = Price)) + geom_point() + labs(title = "Price vs CO2 Emissions")
ggplot(NewData, aes(x = Weight, y = Price)) + geom_point() + labs(title = "Price vs Weight")
ggplot(NewData, aes(x = Mileage, y = Price)) + geom_point() + labs(title = "Price vs Mileage")
ggplot(NewData, aes(x = Insurance_Cost, y = Price)) + geom_point() + labs(title = "Price vs Insurance Cost")
ggplot(NewData, aes(x = Production_Units, y = Price)) + geom_point() + labs(title = "Price vs Production Units")

# Boxplots cua Price theo bien phan loai
ggplot(NewData, aes(x = Condition, y = Price)) + geom_boxplot(fill = "orange") + labs(title = "Price theo Condition")
ggplot(NewData, aes(x = Market_Demand, y = Price)) + geom_boxplot(fill = "orange") + labs(title = "Price theo Market_Demand")
ggplot(NewData, aes(x = Safety_Rating, y = Price)) + geom_boxplot(fill = "orange") + labs(title = "Price theo Safety_Rating")
ggplot(NewData, aes(x = Number_of_Owners, y = Price)) + geom_boxplot(fill = "orange") + labs(title = "Price theo Number_of_Owners")
ggplot(NewData, aes(x = Fuel_Type, y = Price)) + geom_boxplot(fill = "orange") + labs(title = "Price theo Fuel_Type")
ggplot(NewData, aes(x = Drivetrain, y = Price)) + geom_boxplot(fill = "orange") + labs(title = "Price theo Drivetrain")
ggplot(NewData, aes(x = Transmission, y = Price)) + geom_boxplot(fill = "orange") + labs(title = "Price theo Transmission")

# Tinh ma tran tuong quan Pearson
cor_data <- cor(num_vars, use = "complete.obs")
print(round(cor_data, 2))
# Ve bieu do tuong quan
library(corrplot)
corrplot(cor_data, method = "color", type = "upper",
         tl.col = "black", tl.srt = 45, 
         addCoef.col = "black", number.cex = 0.7)

#5. THONG KE SUY DIEN

# Chia tap du lieu thanh train va test
set.seed(9) 
n <- nrow(NewData)
train_index <- sample(1:n, size = 0.8 * n) 
train_data <- NewData[train_index, ]
test_data  <- NewData[-train_index, ]

# Xay dung mo hinh hoi quy tuyen tinh boi
model_lm <- lm(Price ~ ., data = train_data)
# Tom tat mo hinh
summary(model_lm)

# Xay dung mo hinh hoi quy tuyen tinh rut gon
model_lm2 <- lm(Price ~ Top_Speed+Safety_Rating, data = train_data)
# Tom tat mo hinh
summary(model_lm2)

# Kiem tra dieu kien cac mo hinh
par(mfrow = c(2, 2))  # Ve 4 bieu do trong 1 cua so
plot(model_lm2)       # Bieu do chan doan mo hinh

#Residuals vs Fitted – Kiểm định sai số có kỳ vọng bằng 0. Sai số có kì vọng bằng 0 thỏa mãn.
#Normal Q-Q – Kiểm tra phân phối chuẩn của những sai số. Sai số có phân phối chuẩn không thỏa
#Scale-Location – Kiểm tra phương sai của các sai số. Phương sai của các sai số là hằng số 
#Residuals vs Leverage – Vẽ ra những điểm gây ảnh hưởng cao. Không có những điểm ảnh hưởng cao 

# Kiem tra he so tuong quan Durbin-Watson
library(lmtest)
dwtest(model_lm2)
#=> Phần dư không có mối liên quan đáng kể (khá độc lập)

# Kiem tra phan phoi chuan cua phan du
library(car)
qqPlot(model_lm2, main = "QQ Plot - Kiem tra pp chuan cua phan du")
#=> Phần dư có phân phối chuẩn không thỏa

# Kiem tra phuong sai dong nhat (homoscedasticity)
ncvTest(model_lm2)
#=> không có bằng chứng cho thấy phương sai thay đổi theo giá trị dự đoán 

# Du bao gia tri tren tap test
predictions <- predict(model_lm2, newdata = test_data)
# Tinh sai so du bao
residuals_test <- test_data$Price - predictions
# Tinh cac chi so danh gia
MAE <- mean(abs(residuals_test))                    # MAE sai so tuyet doi trung binh
MSE <- mean(residuals_test^2)                       # MSE sai so binh phuong trung binh
RMSE <- sqrt(MSE)                                   # RMSE can cua sai so bình phuong trung binh 
R2 <- 1 - sum(residuals_test^2) / sum((test_data$Price - mean(test_data$Price))^2)  # R-squared
# In ket qua danh gia
cat("MAE:", round(MAE, 2), "\n")
cat("MSE:", round(MSE, 2), "\n")
cat("RMSE:", round(RMSE, 2), "\n")
cat("R-squared on test_data:", round(R2, 4), "\n")
#=> mô hình dự báo tệ

# Ve bieu do thuc te vs du bao
library(ggplot2)
library(scales)  # Để dùng label_comma
df_result <- data.frame(Actual = test_data$Price, Predicted = predictions)
ggplot(df_result, aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Actual Value & Predicted Value",
       x = "Actual Value", y = "Predicted Value") +
  scale_x_continuous(labels = label_comma()) +
  scale_y_continuous(labels = label_comma()) +
  theme_minimal()
#=>không thể áp dụng thực tế



#6. MO RONG

# Mo rong 1

# Tao bo du lieu chi bao gom cac bien can thiet
NewData <- CarData %>%
  select(Log_Price,
         Horsepower, Torque, Top_Speed, Acceleration_0_100, Engine_Size,
         Fuel_Efficiency, CO2_Emissions, Weight, Log_Mileage,
         Condition, Market_Demand, Insurance_Cost, Production_Units,
         Safety_Rating, Number_of_Owners,
         Fuel_Type, Drivetrain, Transmission)

# Chuyen doi cac bien phan loai sang factor
NewData$Condition <- as.factor(NewData$Condition)
NewData$Market_Demand <- as.factor(NewData$Market_Demand)
NewData$Fuel_Type <- as.factor(NewData$Fuel_Type)
NewData$Drivetrain <- as.factor(NewData$Drivetrain)
NewData$Transmission <- as.factor(NewData$Transmission)
NewData$Safety_Rating <- as.factor(NewData$Safety_Rating)
NewData$Number_of_Owners <- as.factor(NewData$Number_of_Owners)

# Chia tap du lieu thanh train va test theo ty le 80:20
set.seed(9)
n <- nrow(NewData)
train_index <- sample(1:n, size = 0.8 * n)
train_data <- NewData[train_index, ]
test_data  <- NewData[-train_index, ]

# Xay dung mo hinh hoi quy tuyen tinh boi
model_lm <- lm(Log_Price ~ ., data = train_data)

# Tom tat ket qua mo hinh
summary(model_lm)

# Xay dung mo hinh hoi quy tuyen tinh boi
model_lm2 <- lm(Log_Price ~ Top_Speed+Safety_Rating, data = train_data)

# Tom tat mo hinh
summary(model_lm2)

# Mo rong 2
# Tao du lieu moi chi giu Log_Price, Log_Mileage va log bien lien tuc khac
NewData_Log <- CarData %>%
  select(Log_Price,
         Horsepower, Torque, Top_Speed, Acceleration_0_100, Engine_Size,
         Fuel_Efficiency, CO2_Emissions, Weight,
         Log_Mileage,  # giu nguyen Log_Mileage
         Condition, Market_Demand,
         Insurance_Cost, Production_Units,
         Safety_Rating, Number_of_Owners,
         Fuel_Type, Drivetrain, Transmission) %>%
  mutate(across(c(Horsepower, Torque, Top_Speed, Acceleration_0_100, Engine_Size,
                  Fuel_Efficiency, CO2_Emissions, Weight,
                  Insurance_Cost, Production_Units),
                ~ log(. + 1), .names = "log_{.col}")) %>%
  select(Log_Price, Log_Mileage, starts_with("log_"),
         Condition, Market_Demand, Safety_Rating, Number_of_Owners,
         Fuel_Type, Drivetrain, Transmission)

# Chuyen cac bien phan loai sang factor
NewData_Log$Condition <- as.factor(NewData_Log$Condition)
NewData_Log$Market_Demand <- as.factor(NewData_Log$Market_Demand)
NewData_Log$Fuel_Type <- as.factor(NewData_Log$Fuel_Type)
NewData_Log$Drivetrain <- as.factor(NewData_Log$Drivetrain)
NewData_Log$Transmission <- as.factor(NewData_Log$Transmission)
NewData_Log$Safety_Rating <- as.factor(NewData_Log$Safety_Rating)
NewData_Log$Number_of_Owners <- as.factor(NewData_Log$Number_of_Owners)

# Chia du lieu thanh train va test theo ty le 80:20
set.seed(9)
n <- nrow(NewData_Log)
train_index <- sample(1:n, size = 0.8 * n)
train_data <- NewData_Log[train_index, ]
test_data <- NewData_Log[-train_index, ]

# Xay dung mo hinh hoi quy tuyen tinh boi
model_lm_log <- lm(Log_Price ~ ., data = train_data)
# Tom tat ket qua mo hinh
summary(model_lm_log)

# Xay dung mo hinh hoi quy tuyen tinh boi
model_lm_log2 <- lm(Log_Price ~ log_Top_Speed+Safety_Rating, data = train_data)
# Tom tat ket qua mo hinh
summary(model_lm_log2)














# KIEM DINH GIA THUYET 1 MAU (One-sample test)
# Lay lai du lieu goc chua log de kiem dinh
NewData_1 <- read.csv("D:/BTL XSTK/Elite Sports Cars in Data.csv")  
NewData_1 <- na.omit(NewData_1)
# Ve bieu do QQ cho bien Price
qqnorm(NewData_1$Price)
qqline(NewData_1$Price)
# Kiem tra normality voi Shapiro-Wilk
shapiro.test(NewData_1$Price)
# Kiem dinh trung binh > 200,000
t.test(NewData_1$Price, mu = 200000, alternative = "greater")
n <- length(NewData_1$Price)                     # Kích thước mẫu
t_critical <- qt(p = 0.05, df = n - 1, lower.tail = FALSE)
cat("Ngưỡng t một phía (alpha = 0.05):", t_critical, "\n")