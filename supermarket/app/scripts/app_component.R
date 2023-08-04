library(shinyWidgets)

source("scripts/data_wrangle.R")

# create an empty dataframe
time_range_table <- data.frame()

time_range <- df_supermarket %>% 
  summarise(first_date = min(date),
            last_date = max(date))

# picker values
# product type
# branches
# customer type

get_distinct_df <- function(data, column_name){
  distinct_values <- data %>% 
    select({{column_name}}) %>% 
    distinct() %>% 
    collect()
  
  return(as.data.frame(distinct_values))
}
  
# Product line
product_line_input_values <- get_distinct_df(df_supermarket, product_line)

# Branch
branch_input_values <- get_distinct_df(df_supermarket, branch)

# Customer type
customer_type_input_values <- get_distinct_df(df_supermarket, customer_type)

# Picker input: Product line
picker_product_line <- pickerInput(
  inputId = "picker_product_line",
  label = "Product line",
  choices = product_line_input_values,
  selected = product_line_input_values$product_line,
  multiple = TRUE,
  options = pickerOptions(
    noneSelectedText = "Please select an option!!!",
    size = 10,
    noneResultsText = 'No results matched'
  )
)


# Picker input: Branch
picker_branch <- pickerInput(
  inputId = "picker_branch",
  label = "Company branch",
  choices = branch_input_values,
  selected = branch_input_values$branch,
  multiple = TRUE,
  options = pickerOptions(
    noneSelectedText = "Please select an option!!!",
    size = 10,
    noneResultsText = 'No results matched'
  )
)

# Picker input: Customer type
picker_customer_type <- pickerInput(
  inputId = "picker_customer_type",
  label = "Customer type",
  choices = customer_type_input_values,
  selected = customer_type_input_values$customer_type,
  multiple = TRUE,
  options = pickerOptions(
    noneSelectedText = "Please select an option!!!",
    size = 10,
    noneResultsText = 'No results matched'
  ),
  width = "100%"
)


# Picker date range
daterange <- shinyWidgets::airDatepickerInput(
  inputId = 'daterange',  
  label = 'Date range:',
  value = c(time_range$first_date, time_range$last_date),
  minDate = time_range$first_date,
  maxDate = time_range$last_date,
  multiple = TRUE, range = TRUE, todayButton = FALSE,
  #clearButton = TRUE,
  update_on = 'close', addon = 'none', width = "370px",
  clearButton = TRUE
  # make_inline is a custom css that's found in the utils_BaseSettings.R script
)



# CSS

# function to make shiny inputs inline, 'pi-inline-input' is a css class within the dashboard.css
# To Do: Everything in dashboard.css should go into custom.css
make_inline <- function(x) {
  y <- shiny::tagAppendAttributes(x, class = 'inline-input')
  if (length(y$children) >= 3) {
    if (y$children[[2]]$name == 'br') {
      y$children[[2]] <- NULL
    }
  }
  y
}










