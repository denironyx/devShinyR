df_supermarket <- readRDS('data/df_supermarket.rds')

## Metrics
# Total price
# Total quantity
# Gross Income
# Total product

df_supermarket %>%
  group_by(customer_type, product_line, branch) %>% 
  summarise(n=())



df_supermarket %>% 
  #select(total) %>% 
  summarise(total_amount = sum(total))

df_supermarket %>% 
  #select(total) %>% 
  summarise(total_amount = sum())

df_supermarket %>%
  select(branch, customer_type, gender, product_line, quantity, unit_price, date, payment, gross_income) %>% 
  summarise(
    total_sales <- sum(unit_price),
    total_quantity <- sum(quantity)
  )

df


df_supermarket %>% 
  select(product_line) %>% 
  distinct() %>% 
  count()


df_supermarket %>% 
  select(gender) %>%
  group_by(gender) %>% 
  summarise(
    prop = round(n()/sum(n())*100)
  ) %>% 
  pull()


total_male_count <- df_supermarket %>% 
  filter(gender == 'Male') %>% 
  count()

total_female_count <- df_supermarket %>% 
  filter(gender == 'Female') %>% 
  count()

total_count = total_female_count + total_male_count

total_female_count/total_count * 100

library(plotly)






# Get Manufacturer
mtcars$manuf <- sapply(strsplit(rownames(mtcars), " "), "[[", 1)

df <- mtcars
df <- df %>% group_by(manuf)
df <- df %>% summarize(count = n())
fig <- df %>% plot_ly(labels = ~manuf, values = ~count)
fig <- fig %>% add_pie(hole = 0.6)
fig <- fig %>% layout(title = "Donut charts using Plotly",  showlegend = F,
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig






df_supermarket %>% 
  group_by(payment) %>% 
  summarise(count_pay = n()) %>% 
  plot_ly(labels = ~payment, values = ~count_pay) %>% 
  add_pie(hole=0.6)


fig <- fig %>% add_pie(hole = 0.6)
%>% 
  plot_ly(labels=~payment, value = ~count_pay) %>% 
  add_pie(hole = 0.6)

fig

geom_












