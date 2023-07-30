# Load packages
library(shiny)
library(bs4Dash)
library(thematic)

thematic_shiny()
shinyApp(
  ui = dashboardPage(
    #preloader = list(html = tagList(spin_2(), "loading ..."), color = "#343a40"),
    dark = TRUE,
    help = FALSE,
    header = dashboardHeader(
      title = dashboardBrand(
          title = "Velion, Inc", 
          color = "primary",
          href = "",
          opacity = 0.8,
        ),
        fixed = TRUE),
    sidebar = dashboardSidebar(
      fixed = TRUE,
      skin = "light",
      status = "primary",
      id = "sidebar",
      sidebarUserPanel(
        image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png",
        name = "Welcome Onboard!"
      ),
      sidebarMenu(
        id = "sidebar_tab",
        flat = FALSE,
        compact = FALSE,
        sidebarHeader("Overview")
      )
    ),
    body = dashboardBody(),
    controlbar = dashboardControlbar(),
    footer = dashboardFooter(
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
    
  }
)