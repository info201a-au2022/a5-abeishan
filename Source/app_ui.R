library("shiny")
library("plotly")
library("shinyWidgets")

source("app_server.R")

#Page 1
intro_page <- tabPanel(
  "Introduction",
  h1("Data Analysis on CO₂ Emissions", style = " font-size: 40px ; font-family: 'times'; font-si16pt"),
  br(),
  p(paste0("CO₂ is in the air we are living in. Understanding the trend of that could better protect ourselves from living 
    in an unhealthy environment. This data set collects CO₂ emission and related data from 1750 to 2021. In this report,
    two variables, the annual total CO₂ emissions, and tones of CO₂ per person, are analyzed. From the description of data collectors, 
    the CO₂ variable is annual total production-based emissions of carbon dioxide (CO₂), excluding land-use change, measured in million tones. 
    The second variable is annual total production-based emissions of carbon dioxide (CO₂), excluding land-use change, measured in tones per person. 
    Both variables are based on territorial emissions, which do not account for emissions embedded in traded goods. In year 2021, the average CO₂ emission
    across all countries is ",average_CO2_2021, " millions tones. In United States, the year that produced most CO₂ is ", max_CO2_year, ", and the amount is "
    , max_CO2, " millions of tones. The corresponding minimum data are year ", min_CO2_year, " and amount ",min_CO2," millions tones. 
    From year 1750 to year 2021, the amount of CO₂ produced has increased ",CO2_world_change," millions tones. Similarly, the surprising trend also applies
    to the other variable. The fast speed of increase of CO₂ emitted shocked me and motivated me to do this report.
") ,style = "font-family: 'times'; font-si16pt ; font-size:22px;"),
  br()
)
  
#Page 2
plot_sidebar <- sidebarPanel(
  radioButtons(
    inputId = "y_var",
    label = "Y Variable",
    choices = c("CO₂ Emissions" = "co2", "Tones of CO₂ per person" = "co2_per_capita"),
    selected = "co2"
  ),
  selectInput(
    inputId = "input_country",
    label = "Country",
    choices = df$country,
    selected = "Africa",
    multiple = TRUE,
    selectize = TRUE
  )
)

plot_main <- mainPanel(
  plotlyOutput(outputId = "plot")
)

plot_page <- tabPanel(
  "Plot",
  h1("Trends of CO₂ Emissions and CO₂ Per Person", style = "font-family: 'times'; font-si16pt"),
  p("From the visualizations, we can see that almost all countries have an increasing trend of CO₂ emissions. And some countries
  even have a drastic speed of increasing like China. Those trends warm people, manufactories, and governments that our planet is being 
  destroyed by us. It is necessary and urgent to protect our planet and protect ourselves. The good news is that the CO₂ produced per person 
  is decreasing after year 2005 in most developed countries. But the amount they emitted in recent years are still very large. And this trend does
  not apply to all countries. We can see that there are more environmentally friendly products being developed as our technology improved, and this is highly 
  encouraged and worth to be learned by all countries. Everyone in this planet has responsibility to reduce CO₂ emitted, so we all need to work together to live 
  in a healthy environment." , style = "font-family: 'times'; font-si16pt ; font-size:19px;"),
  hr(style = "border-top: 1px solid #000000;"),
  sidebarLayout(
    plot_sidebar,
    plot_main
  )
)

ui <- navbarPage(
  "CO₂ in Our Life",
  setBackgroundColor("#f9f7f1"),
  intro_page,
  plot_page
)