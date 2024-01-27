# load packages ---- 
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)


# user interface ----
ui <- fluidPage(
  
  # app title ----
  tags$h1("Practice App"), # format with tags; h1 = header level 1
  
  # app subtitle ----
  h4(strong("Exploring Antarctic Penguin Data")),   #shortcuts: h4 = header level 4; strong = bold
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g):",
              min = 2700, max = 6300, value = c(3000, 4000)),  # can either set this or use min/max functions

  #body mass plot output ----
  plotOutput(outputId = "bodyMass_scatterplot_output"),
  
  # year input ----
  checkboxGroupInput(input = "year_input", label = "Select year(s):", 
                     choices = c("2007", "2008", "2009"),
                     select = c("2007", "2008")),
  
  #DT output ----
  DT::dataTableOutput(outputId = "penguin_DT_output")
                
)

#server ----
server <- function(input, output) {  # should be singular, not plural
  
  # filter body masses ----
  body_mass_df <- reactive({    # reactive df is updateable
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  })   

  
  # render penguin scatter plot ----
  output$bodyMass_scatterplot_output <- renderPlot({   #code to generate plot  #save to output saved in ui
    
    # add ggplot code here
    # create scatterplot ----
    ggplot(na.omit(body_mass_df()),  # needs additional set of () to work
           aes(x = flipper_length_mm, y = bill_length_mm,
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange","Chinstrap" = "purple","Gentoo" = "cyan4")) +  # assigning categories to colors and shapes keeps them the same when slider changes. colors/shapes now static.
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper Length (mm)", y = "Bill Length (mm)", color = "Penguin species",
           shape = "Penguin species") +
      theme_minimal() +
      theme(legend.position = c(0.85, 0.2),
            legend.background = element_rect(color = "white"))
    
  })  
  
  years_df <- reactive({
    
    penguins %>%
       filter(year %in% c(2007:2008))
    
  }
    
    
  
  # render DT table ----
  output$penguin_DT_output <- DT::renderDataTable({
    
    DT::datatable(penguins)
    
    
  })
  
  
}

# combine UI & server into app ----
shinyApp(ui = ui, server = server)  # this line is not necessary in the two-file system. Shiny knows what to do.
