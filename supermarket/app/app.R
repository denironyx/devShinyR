# Load packages
library(shiny)
library(bs4Dash)
library(thematic)
library(waiter)

# Load up a font
system('fc-cache -f ~/.fonts')
#thematic_shiny()
purple_1 = "#393B98"
# Shiny App Layout
shinyApp(
  ui = bs4DashPage(
    #preloader = list(html = spin_2(), color = "#800080"),
    preloader = list(html = tagList(spin_1(), "loading ..."), color = "#393B98"),
    dark = NULL,
    header = bs4DashNavbar(
      
      # navbar
      skin = "light",
      border = FALSE,
      #sidebarIcon = icon("bars"),
      #compact = TRUE,
      disable = FALSE,
      title = dashboardBrand(
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
      fixed = TRUE,
      skin = "light",
      status = "light",
      bs4SidebarUserPanel(
        name = " XYZ Customer"
      ),
      
      # Side bar Menu
      
      bs4SidebarMenu(
        bs4SidebarMenuItem(
          text = "Overview",
          tabName = "overview",
          icon = icon("dashboard")
        ),
        bs4SidebarMenuItem(
          text = "Table",
          tabName = "table",
          icon = icon("table")
        )
      )
    ),
    body = bs4DashBody(),
    controlbar = bs4DashControlbar(),
    footer = bs4DashFooter(
      fixed = FALSE,
      left = a(
        href = "https://twitter.com/denironyx",
        target = "_blank", "Dennis Irorere"
      ),
      right = "2023"
    ),
    title = "bs4Dash Showcase"
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