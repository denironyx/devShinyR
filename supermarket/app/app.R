# Load packages
library(shiny)
library(bs4Dash)
library(thematic)
library(waiter)
library(shinyjs)
library(plotly)

source("scripts/data_wrangle.R")
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
          column(3, picker_branch),
          column(3, picker_customer_type),
          column(3, picker_product_line),
          column(3, daterange)
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
              title = "Map of City vs Total Income",
              width = 6,
              status = "purple",
              closable = FALSE,
              maximizable = TRUE,
              collapsible = FALSE,
              leaflet::leafletOutput("map_income")
            ),
            box(
              id = "payment_chart",
              title = "Pie Chart - Payment Type",
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
    output$user <- renderUser({
      dashboardUser(
        name = "Dennis Irorere",
        image = "dee.png",
        title = "Senior R developer", 
        subtitle = "Author",
        footer = p("The footer", class = "text-center")
      )
    })
  }
)