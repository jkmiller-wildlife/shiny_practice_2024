# user interface ----
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # Page 1 - intro tabPanel ----
  tabPanel(title = "About this page",
           # intro text fluidRow
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md"),
             column(1))
           
  ), # END intro text fluidRow
  
  
  hr(),
  
  includeMarkdown("text/footer.md")
  
  
  
  
), # END Page 1 - intro tabPanel

# Page 2 - data viz tabPanel ----
tabPanel(title = "Explore the data",
         
         
         #tabsetPanel to contain tabs for data viz; "inputs and outputs live here"
         tabsetPanel(
           
           #create trout tabPanel
           tabPanel(title = "Trout",
                    # trout sidebarLayout ----
                    sidebarLayout(
                      
                      # trout sidebarPanel
                      sidebarPanel(
                        
                        # channel type pickerInput; "trout inputs will live here"
                        pickerInput(inputId = "channel_type_input",
                                    label = "Select Channel Type(s):",
                                    choices = unique(clean_trout$channel_type),
                                    selected = c("cascade", "pool"),
                                    options = pickerOptions(actionsBox = TRUE),
                                    multiple = TRUE #select multiple options at once
                        ), # END channel pickerInput
                        
                        
                        # section checkboxGroupButtons ----
                        checkboxGroupButtons(inputId = "section_input",
                                             label= "Select a sampling section(s):",
                                             choices = c("clear cut forest", "old growth forest"), 
                                             selected = c("clear cut forest", "old growth forest"),
                                             individual = FALSE, 
                                             justified = TRUE,  # width of buttons take up same width as element. Here it is the sidebarPanel.
                                             size = "sm",
                                             checkIcon = list(yes = icon("check"),
                                                              no = icon("xmark")) # uses the Font Awesome library
                        ) #END section checkboxGroupButtons
                        
                        
                      ), # END trout sidebarPanel
                      
                      # trout mainPanel
                      mainPanel(
                        
                        #trout scatterplot output
                        plotOutput(outputId = "trout_scatterplot_output" #|>
                                    # withSpinner(color = "magenta", type = 1)
                                   
                        ) # END trout scatterplot output
                        
                        
                      ) #END trout mainPanel
                      
                      
                    ) # END trout sidebarLayout
                    
           ), # END trout tabPanel
           
           
           # penguin tabPanel ----
           tabPanel(title ="Penguin",
                    
                    # penguin sidebarLayout
                    sidebarLayout(
                      
                      # penguin sidebarPanel
                      sidebarPanel(
                        
                        # island  pickerInput; select island
                        pickerInput(inputId = "penguin_island_input",
                                    label = "Select an Island(s):",
                                    choices = unique(penguins$island),
                                    selected = unique(penguins$island),
                                    options = pickerOptions(actionsBox = TRUE),
                                    multiple = TRUE #select multiple options at once
                        ), # END island pickerInput
                        
                        #bin number sliderInput
                        sliderInput(inputId = "bin_num_input",
                                    label = "Select number of bins",
                                    value = 25, max = 100, min = 1
                        ) # END bin number SliderInput
                        
                        
                        
                      ), # END penguin sidebarPanel
                      
                      # penguin mainPanel
                      mainPanel(
                        
                        # penguin histogram output
                        plotOutput(outputId = "flipperLength_histogram_output" #|>
                                   #  withSpinner(color = "green", type = 4, size = 2)
                        ) # END penguin histogram output
                        
                      )  # END penguin mainPanel                        
                      
                    ), # END penguin sidebarLayout
                    
                    
           ) # END penguin tabPanel
           
           
         ) # END tabsetPanel
         
), # END Page 2 - data viz tabPanel



) # END navbarPage