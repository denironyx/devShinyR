df_supermarket <- readRDS('data/df_supermarket.rds')

## Metrics
# Total price
# Total quantity
# Gross Income
# Total product


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

library(leaflet)

df_supermarket %>% 
  group_by(branch, total, lat, lon) %>% 
  summarise(total_income = sum(total))
  leaflet() %>% 
  addTiles()

map_data <- 
  df_supermarket %>% 
    group_by(branch, total, quantity, lat, lon) %>% 
    summarise(total_income = sum(total),
              total_quantity = sum(quantity)) %>%

df_supermarket %>% 
  group_by(branch, total, quantity, lat, lon) %>% 
  summarise(total_income = sum(total),
            total_qty = sum(quantity)) %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 6,
    color = "blue",
    popup = paste("Branch:", branch, "<br>",
                  "Total Income:", total_income, "<br>",
                  "Total Quantity:", quantity)
  )
  
  
  
  
leaflet_mapmap_data <- df_supermarket %>% 
  group_by(branch, total, quantity, lat, lon) %>% 
  summarise(total_income = sum(total))

leaflet_map <- leaflet(map_data) %>% 
  addTiles() %>% 
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 6,
    color = "blue",
    popup = paste("Branch:", branch, "<br>",
                  "Total Income:", total_income, "<br>",
                  "Total Quantity:", quantity)
  )

leaflet_map
  

leaflet_map <- leaflet(map_data) %>% 
  addTiles() %>% 
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 6,
    color = "blue",
    popup = paste("Branch:", branch, "<br>",
                  "Total Income:", total_income, "<br>",
                  "Total Quantity:", quantity)
  )

leaflet_map

df_supermarket %>% 
  group_by(branch, total, quantity, lat, lon) %>% 
  summarise(total_income = sum(total),
            total_qty = sum(quantity), .groups = "keep") %>% 
  ungroup() %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 6,
    color = "blue",
    popup = paste("Branch:", branch, "<br>",
                  "Total Income:", total_income, "<br>",
                  "Total Quantity:", quantity)
  )



df_supermarket %>% 
  group_by(branch, total, quantity, lat, lon) %>% 
  summarise(total_income = sum(total),
            total_qty = sum(quantity)) %>% 
  ungroup()


df_supermarket %>% 
  group_by(branch, lat, lon) %>% 
  summarise(total_income = sum(total),
            total_qty = sum(quantity), .groups = "keep") %>% 
  ungroup() %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 4,
    color = "#605ca8",
    opacity = 5.0,
    popup = ~paste("Branch:", branch, "<br>",
                   "Total Income:", scales::dollar(total_income), "<br>",
                   "Total Quantity:", total_qty)
  )


df_supermarket %>% 
  group_by(branch, lat, lon) %>% 
  summarise(total_income = sum(total),
            total_qty = sum(quantity), .groups = "keep") %>% 
  ungroup() %>% 
  leaflet() %>% 
  addTiles() %>%
  addMarkers(
    lng = ~lon,
    lat = ~lat,
    popup = ~paste("Branch:", branch, "<br>",
                   "Total Income:", scales::dollar(total_income), "<br>",
                   "Total Quantity:", total_qty)
  )
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 4,
    color = "#605ca8",
    opacity = 5.0,
    popup = ~paste("Branch:", branch, "<br>",
                   "Total Income:", scales::dollar(total_income), "<br>",
                   "Total Quantity:", total_qty)
  )df_supermarket %>% 
  group_by(branch, lat, lon) %>% 
  summarise(total_income = sum(total),
            total_qty = sum(quantity), .groups = "keep") %>% 
  ungroup() %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 4,
    color = "#605ca8",
    opacity = 5.0,
    popup = ~paste("Branch:", branch, "<br>",
                   "Total Income:", scales::dollar(total_income), "<br>",
                   "Total Quantity:", total_qty)
  )
df_supermarket %>% 
  group_by(branch, lat, lon) %>% 
  summarise(total_income = sum(total),
            total_qty = sum(quantity), .groups = "keep") %>% 
  ungroup() %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(
    lng = ~lon, 
    lat = ~lat,
    radius = 4,
    color = "#605ca8",
    weight = 10,
    fill = TRUE,
    opacity = 5.0,
    popup = ~paste("Branch:", branch, "<br>",
                   "Total Income:", scales::dollar(total_income), "<br>",
                   "Total Quantity:", total_qty)
  )


