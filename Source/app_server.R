library("ggplot2")
library("tidyverse")
library("dplyr")
library("plotly")
data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
write.csv(data,file = "owid-co2-data.csv")
df <- read.csv("owid-co2-data.csv")

server <- function(input, output) {
  output$plot <- renderPlotly({
    #filter the dataset to user selected countries
    data <- df %>% 
      filter(country %in% input$input_country)
    
    #change name as y variable changes
    if (input$y_var == "CO₂") {
      name <- "CO₂ Emissions (millions tones)"
    } else {
      name <- "Tonnes of CO₂ per person (tones)"
    }
    
    #plot the line chart 
    chart <- ggplot(data) +
      aes(x = year, y = get(input$y_var), color = country) +
      geom_line() +
      scale_x_log10() +
      labs(
        x = "Year",
        y = name,
        title = paste0(name, " of Selected Country (1750-2021)")
      )
    
    return(chart)  
  })
}

CO2_2021 <- df %>% 
  filter(year == 2021) %>%
  select(co2)  
average_CO2_2021 <- round(mean(CO2_2021$co2,na.rm = T),2)

max_CO2_year <- df %>% 
  filter(country == "United States") %>% 
  filter(co2 == max(co2, na.rm = T)) %>% 
  pull(year)

max_CO2 <- df %>% 
  filter(country == "United States") %>% 
  filter(co2 == max(co2, na.rm = T)) %>% 
  pull(co2)

min_CO2_year <- df %>% 
  filter(country == "United States") %>% 
  filter(co2 == min(co2, na.rm = T)) %>% 
  pull(year)

min_CO2 <- df %>% 
  filter(country == "United States") %>% 
  filter(co2 == min(co2, na.rm = T)) %>% 
  pull(co2)

min_world_CO2 <- df %>% 
  filter(country == "World") %>% 
  filter(year == min(year)) %>% 
  pull(co2)

max_world_CO2 <- df %>% 
  filter(country == "World") %>% 
  filter(year == max(year)) %>% 
  pull(co2)

CO2_world_change <- max_world_CO2 - min_world_CO2

CO2_per_capita_2021 <- df %>% 
  filter(year == 2021) %>%
  select(co2_per_capita)  
average_CO2_per_capita_2021 <- round(mean(CO2_per_capita_2021$co2_per_capita,na.rm = T),2)

max_CO2_per_capita_year <- df %>% 
  filter(country == "United States") %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = T)) %>% 
  pull(year)

max_CO2_per_capita <- df %>% 
  filter(country == "United States") %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = T)) %>% 
  pull(co2_per_capita)

min_CO2_per_capita_year <- df %>% 
  filter(country == "United States") %>% 
  filter(co2_per_capita == min(co2_per_capita, na.rm = T)) %>% 
  pull(year)

min_CO2_per_capita <- df %>% 
  filter(country == "United States") %>% 
  filter(co2_per_capita == min(co2_per_capita, na.rm = T)) %>% 
  pull(co2_per_capita)

min_world_CO2_per_capita <- df %>% 
  filter(country == "World") %>% 
  filter(year == min(year)) %>% 
  pull(co2_per_capita)

max_world_CO2_per_capita <- df %>% 
  filter(country == "World") %>% 
  filter(year == max(year)) %>% 
  pull(co2_per_capita)

CO2_per_capita_world_change <- max_world_CO2_per_capita - min_world_CO2_per_capita
