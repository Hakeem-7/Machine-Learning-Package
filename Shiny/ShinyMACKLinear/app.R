#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Load R packages
library(shiny)
library(shinythemes)
library(r2symbols)
library(shinyjs)
library(rsconnect)

# Define UI
ui <- fluidPage(theme = shinytheme("cosmo"),
                
                navbarPage(
                    "MACKLinear_FinalProjectGroup5",
                    
                      mainPanel(style="text-align:justify;",
                      
                                tabsetPanel(
                                tabPanel("Intro",
                                
                                h1("Welcome"),
                                em ("This is an app developed to for our final project in 'R-programming for Data Science' class. We created a package for performing
                                simple and multiple linear regressions and also associated statistical outputs. Confidence intervals and mean square prediction error
                                can be computed. F-tests are able to be conducted and publication quality plots of data are able to be generated"),
                                br(),
                                br(),
                                
                                h1("What our package have"),
                                em("The package must contain:"),
                                tags$li("Confidence intervals: the user must be able to choose the significance level  \\(\\alpha\\) to obtain for the 1-\\(\\alpha\\)
                                confidence intervals for  \\(\\beta\\) and whether,to use the asymptotic or bootstrap approach for this."),
                                tags$li("Plots including:",
                                  tags$ul("- Residuals vs fitted-values"),
                                  tags$ul("- qq-plot of residuals"),
                                  tags$ul("- Histogram (or density) of residuals"),
                                  tags$li("Mean Square Prediction Error (MSPE) computed in matrix form:"),
                                  tags$li("F-test: compute the statistic in matrix form and output the corresponding p-value."),
                                  tags$li("Help documentation for all functions (for example using the roxygen2 package"),
                                
                                  br(),
                                  br(),
                      
                                  
                                 h2("More info"),
                                tags$code(a("Click here", href="https://github.com/AU-R-Programming/Final_Project_Group_5", target="_blank"),
                                          style = "font-size:25px","to find our GitHub repository"),
                      
                                 hr(),
                                 br(),
                      
                      
                      
                      
                      
                      
                                )),
 

                                 #ABA2
                              
                                tabPanel("Meet the team", style="text-align:center;", style = "border: 4px double grey;",
                                         
         
                                                  
          h2(a("Akeem Ajede", href="https://github.com/Hakeem-7", target="_blank"),style = "font-size:25px"),
         tags$img(src='Akeem.png', height = 160, width = 160),
         tags$ul("Creator", "Author" = "font-size:25px"),
         
         h2(a("Cary Burdick", href="https://github.com/clb00635", target="_blank"),style = "font-size:25px"),
         tags$img(src='Cary.png', height = 160, width = 160),
         tags$ul("Author",style = "font-size:25px"),
        
         
         h2(a("Kaelyn Fogelman", href="https://github.com/kaefogelman", target="_blank"),style = "font-size:25px"), 
         tags$img(src='Kaelyn_Fogelman.png', height = 160, width = 160),
         tags$ul("Author",style = "font-size:25px"),
         
         h2(a("Maria Terra", href="https://github.com/MariaTerezaTerra", target="_blank"),style = "font-size:25px"),
         tags$img(src='MariaTerezaTerra.png', height = 160, width = 160),
         tags$ul("Author",style = "font-size:25px")),
         hr(),
         br(),
         
              


                              #ABA3

                              tabPanel("Let's give a try", style="text-align:justify;",style = "border: 4px double grey;",

         h1("F-testLoading"),
         em("Loading..."),

         br(),
         br(),
        
         
         # Define UI for data download app ----
         ui <- fluidPage(
           
           # App title ----
           titlePanel("Downloading Data"),
           
           # Sidebar layout with input and output definitions ----
           sidebarLayout(
             
             # Sidebar panel for inputs ----
             sidebarPanel(
               
               # Input: Choose dataset ----
               selectInput("dataset", "Choose a dataset:",
                           choices = c("rock", "pressure", "cars")),
               
               # Button
               downloadButton("downloadData", "Download")
               
             ),
             
             # Main panel for displaying outputs ----
             mainPanel(
               
               tableOutput("table")
               
           
             
           )
         ),
         
   
         
         hr(),
         br(),
     
)
)
)
#As tres ou duas ultimas de sempre que cada hora eh uma coisa
)
)
)




# Define server function  
server <- function(input, output) {
    # 
    # output$txtout <- renderText({
    #     paste( input$txt1, input$txt2, sep = " " )
    # })


    
    # Reactive value for selected dataset ----
    datasetInput <- reactive({
      switch(input$dataset,
             "rock" = rock,
             "pressure" = pressure,
             "cars" = cars)
    })
    
    # Table of selected dataset ----
    output$table <- renderTable({
      datasetInput()
    })
    
    # Downloadable csv of selected dataset ----
    output$downloadData <- downloadHandler(
      filename = function() {
        paste(input$dataset, ".csv", sep = "")
      },
      content = function(file) {
        write.csv(datasetInput(), file, row.names = FALSE)
      }
    )
    
  
  
  
  } # server






# Create Shiny object
shinyApp(ui = ui, server = server)