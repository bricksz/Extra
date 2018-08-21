require(lubridate)
library(lubridate)
library(dplyr)
data <- data.frame("Date" = seq(as.Date("2000/1/1"), as.Date("2018/8/15"), by=1))
data$Week <- ifelse(months(data$Date) == "December", as.numeric(format(data$Date-4, "%U"))+1, 
                    as.numeric(format(data$Date+3, "%U")))
data$FWeek <- ((data$test + 26) %% 52) + 1



is.thu <- function(x) weekdays(x) == "Thursday"
jan1 <- function(x) as.Date(cut(x, "year"))

nextthu <- function(d) 7 * ceiling(as.numeric(d) / 7)

week4a <- function(d) (as.numeric(d) - nextthu(jan1(d))) %/% 7 + 1

data$test<- week4a(data$Date)
data$Day <- weekdays(data$Date)
data$month <- months(data$Date)
data$`CY` <- as.numeric(format(data$Date, "%Y"))
data$`Fiscal Year` <- as.numeric(format(data$Date, "%Y"))

data <- data %>%
  mutate(`Fweek` = case_when((as.numeric(format(data$Date, "%Y")) %% 4 == 0 & data$Week < 27) ~ ((data$test + 27) %% 53) + 1,
                             (as.numeric(format(data$Date, "%Y")) %% 4 == 0 & data$Week >= 27) ~ ((data$test + 26) %% 52) + 1,
                             as.numeric(format(data$Date, "%Y")) %% 4 != 0 ~ ((data$test + 26) %% 52) + 1,
                             
                             ))
(as.numeric(format(data$Date, "%Y")) %% 4 == 0 & data$Week < 27)
as.numeric(format(data$Date, "%Y")) %% 4 == 0

data <- data %>%
  mutate(`Fiscal Year` = case_when(month(data$Date) >= 7 ~ as.numeric(format(data$Date, "%Y")) + 1,
                                   month(data$Date) < 7 ~ as.numeric(format(data$Date, "%Y"))))
data <- data %>%
  mutate(`Fweek` = case_when(as.numeric(format(data$Date, "%Y")) == 2018 ~ ((data$Week + 26) %% 52) + 1,
                             as.numeric(format(data$Date, "%Y")) == 2017 ~ ((data$Week + 26) %% 52),
                             as.numeric(format(data$Date, "%Y")) == 2016 ~ ((data$Week + 26) %% 52),
                             as.numeric(format(data$Date, "%Y")) == 2015 ~ ((data$Week + 26) %% 52) + 1,
                             as.numeric(format(data$Date, "%Y")) == 2014 ~ ((data$Week + 26) %% 52) + 1,
                             as.numeric(format(data$Date, "%Y")) == 2013 ~ ((data$Week + 26) %% 52) + 1,
                             as.numeric(format(data$Date, "%Y")) == 2012 ~ ((data$Week + 26) %% 52),
                             as.numeric(format(data$Date, "%Y")) == 2011 ~ ((data$Week + 26) %% 52),
                             as.numeric(format(data$Date, "%Y")) == 2010 ~ ((data$Week + 26) %% 52),
                             as.numeric(format(data$Date, "%Y")) == 2009 ~ ((data$Week + 26) %% 52),
                             as.numeric(format(data$Date, "%Y")) == 2008 ~ ((data$Week + 26) %% 52) + 1,
                             as.numeric(format(data$Date, "%Y")) == 2007 ~ ((data$Week + 26) %% 52) + 1,
                             as.numeric(format(data$Date, "%Y")) == 2006 ~ ((data$Week + 26) %% 52),
                             
                             ))
         