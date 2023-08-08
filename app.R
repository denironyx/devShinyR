# Load packages
library(shiny)
library(bs4Dash)
library(thematic)
library(waiter)
library(shinyjs)
library(plotly)
library(DT)
library(leaflet)

#source("scripts/data_wrangle.R")
source("scripts/app_component.R")
# Load up a font
system('fc-cache -f ~/.fonts')
#thematic_shiny()
purple_1 = "#605ca8"
# Shiny App Layout
shinyApp(
  ui = bs4DashPage(
    #preloader = list(html = spin_2(), color = "#800080"),
    preloader = list(html = tagList(spin_1(), "loading ..."), color = "#605ca8"),
    dark = NULL,
    header = bs4DashNavbar(
      # navbar
      skin = "light",
      status = "white",
      border = FALSE,
      #sidebarIcon = icon("bars"),
      #compact = TRUE,
      disable = FALSE,
      title = bs4DashBrand(
          title = "Velion, Inc", 
          color = "white",
          href = "https://www.linkedin.com/in/dennis-irorere/",
          # create a www folder to add your image to it
          image = "velion_01.jpg",
          opacity = 0.8
        ),
        fixed = TRUE,
        rightUi = tagList(
          dropdownMenu(),
          userOutput("user")
          )
        ),
    sidebar = bs4DashSidebar(
      skin = "light",
      status = "purple",
      brandColor = NULL,
      
      bs4SidebarUserPanel(
        name = h4("XYZ Customer", style = "font-style:italic; justify-content: center;")
      ),
      
      # Side bar Menu
      
      bs4SidebarMenu(
        bs4SidebarMenuItem(
          text = "Overview",
          tabName = "overview",
          icon = icon("dashboard")
        ),
        bs4SidebarMenuItem(
          text = "Inventory",
          tabName = "inventory",
          icon = icon("table")
        )
      )
    ),
    body = bs4DashBody(
      # Body ----------------------------
      
      # using shinyjs
      useShinyjs(),
      # custom CSS
      includeCSS("www/devShinyRStyle.css"),
      
      div(
        fluidRow(
          column(2, picker_branch),
          column(2, picker_customer_type),
          column(2, picker_product_line),
          column(2, start_daterange),
          column(2, end_daterange)#,
         # column(2, action_button)
        ),
        
        fluidRow(
          # Summary cards
          bs4Card(
            title = "Summaries",
            closable = FALSE,
            width = 12,
            status = "purple",
            headerBorder = FALSE,
            fluidRow(
              bs4ValueBox(
                elevation = 2,
                width = 3,
                value = h4(bs4ValueBoxOutput("total_income", "$")),
                subtitle = "Total Income",
                icon = icon("money-bill")
              ),
              bs4ValueBox(
                elevation = 2,
                width = 3,
                value = h4(bs4ValueBoxOutput("total_quantity","")),
                subtitle = "Total Quantity",
                icon = icon("calculator")
              ),
              bs4ValueBox(
                elevation = 2,
                width = 3,
                value = h4(bs4ValueBoxOutput("gross_income", "$")),
                subtitle = "Gross Income",
                icon = icon("money-bill")
              ),
              bs4ValueBox(
                elevation = 2,
                width = 3,
                value = h4(bs4ValueBoxOutput("total_products", "")),
                subtitle = "Total Products",
                icon = icon("shop")
              )
            )
          )
        )
        
      ),
      
      bs4TabItems(
        #Overview tab
        bs4TabItem(
          tabName = "overview",
          
          
          # fluid row 
          fluidRow(
            box(
              id = "map",
              title = "Map",
              width = 6,
              status = "purple",
              closable = FALSE,
              maximizable = TRUE,
              collapsible = FALSE,
              leafletOutput("map_viz")
            ),
            box(
              id = "payment_chart",
              title = "Donut Chart - Payment Type",
              width = 6, 
              status = "purple",
              closable = FALSE,
              maximizable = TRUE,
              collapsible = FALSE,
              plotlyOutput("payment_type")
            )
          ),
          
          fluidRow(
            bs4Card(
              title = "Daily Sales",
              closable = FALSE,
              width = 12,
              status = "purple",
              collapsible = FALSE,
              maximizable = FALSE,
              fluidRow(
                plotlyOutput("daily_sales")
              )
            )
          )
        ),
        
        # Data table tab
        bs4TabItem(
          tabName = "inventory",
          
          fluidRow(
            bs4Card(
              title = "Data Table",
              closable = FALSE,
              width = 12,
              collapsible = FALSE,
              status = "purple",
              maximizable = FALSE,
              fluidRow(
                DT::DTOutput("datatable")
              )
            )
          )
        )
      )
      
    ),
    controlbar = bs4DashControlbar(),
    footer = bs4DashFooter(
      fixed = FALSE,
      left = a(
        href = "https://twitter.com/denironyx",
        target = "_blank", "Velion Enterprise"
      ),
      right = "@2023"
    ),
    title = "Dashboard Showcase"
  ),
  
  server = function(input, output, session){
    
    ## REACTIVE EVENTS
    # filtered_data <- eventReactive(
    #   eventExpr = req(input$apply),
    #   
    #   valueExpr = {
    #     df_supermarket %>% 
    #       filter(product_line %in% input$picker_product_line,
    #              branch %in% input$picker_branch,
    #              customer_type %in% input$picker_customer_type,
    #              date >= input$start_daterange[1] & date <= input$end_daterange[1]) %>% 
    #       as_tibble()
    #   }
    # )
    
    filtered_data <- reactive({
      df_supermarket %>%
        filter(product_line %in% input$picker_product_line,
               branch %in% input$picker_branch,
               customer_type %in% input$picker_customer_type,
               date >= input$start_daterange[1] & date <= input$end_daterange[1]) %>%
        as_tibble()
    })
    
    
    output$total_income <- renderText(
      filtered_data() %>% 
        summarise(total_income = sum(total)) %>% 
        pull() %>% 
        round(digits = 0) %>% 
        scales::dollar()
    )
    
    output$total_quantity <- renderText(
      filtered_data() %>% 
        summarise(total_quantity = sum(quantity)) %>% 
        pull() %>% 
        round(digits = 0)
    )
    
    # summary
    output$gross_income <- renderText(
      filtered_data() %>% 
        summarise(gross_income = sum(gross_income)) %>% 
        pull() %>% 
        round(digits = 0) %>% 
        scales::dollar()
    )
    
    output$total_products <- renderText(
      filtered_data() %>% 
        select(product_line) %>% 
        distinct() %>% 
        count() %>% 
        pull()
    )
    
    
    output$daily_sales <- renderPlotly(
      filtered_data() %>% 
        group_by(date) %>% 
        summarize(
          total_income = sum(total)
        ) %>% 
        mutate(label_text = str_glue("Date: {date}
                                     Total income: {total_income}")) %>% 
        ggplot(aes(x=date, y=total_income)) +
        geom_line(size = 0.6, color = "#605ca8") +
        scale_x_date(date_breaks = "1 day") +
        labs(
          x = "Date",
          y = "Duration" 
        ) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
    )
    
    ## Data table server side
    output$datatable <- DT::renderDataTable({
      datatable(filtered_data() %>% 
                  transmute(
                    `Invoice ID` = invoice_id,
                    `Branch` = branch,
                    `Customer Type` = customer_type,
                    `Gender` = gender,
                    `Product` = product_line,
                    `Unit price` = unit_price,
                    `Quantity` = quantity,
                    `Total Price` = total,
                    `Payment Type` = payment,
                    `Gross Income` = gross_income
                  ),
                rownames = FALSE
                , options = list(pageLength = 20))
    })
    
    ## Donut chart - server side
    output$payment_type <- renderPlotly({
      filtered_data() %>% 
        group_by(payment) %>% 
        summarise(count_pay = n()) %>% 
        plot_ly(labels = ~payment, values = ~count_pay) %>% 
        add_pie(hole=0.6)
    }
    )
    
    ## Map visualization using leaflet - server side
    output$map_viz <- renderLeaflet({
      filtered_data() %>% 
        group_by(branch, lat, lon) %>% 
        summarise(total_income = sum(total),
                  total_qty = sum(quantity), .groups = "keep") %>% 
        ungroup() %>% 
        leaflet() %>% 
        addTiles() %>% 
        addCircleMarkers(
          lng = ~lon, 
          lat = ~lat,
          radius = 7,
          color = "#605ca8",
          weight = 10,
          opacity = 1.0,
          popup = ~paste("Branch:", branch, "<br>",
                         "Total Income:", scales::dollar(total_income), "<br>",
                         "Total Quantity:", total_qty)
        )
    })
     
    ## user dropdown section - server side
    output$user <- renderUser({
      dashboardUser(
        name = "Dennis Irorere",
        image = "dee.png",
        title = "Senior R developer", 
        subtitle = "Author"
      )
    })
  }
)