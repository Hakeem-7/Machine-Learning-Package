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
library(bs4Dash)

# Define UI
ui <- fluidPage(theme = shinytheme("united"),
                
                navbarPage(
                    
                    #ABA PRINCIPAIL
                    "MACKLinear_FinalProjectGroup5",
                    
                    MainPanel(style="text-align:justify;",
                              
                              tabPanel("Intro",
                                       
                                       h1("Welcome"),
                                       em ("This is an app developed to for our final project in 'R-programming for Data Science' class. We created a package for performing linear
                             regressions and also associated statistical outputs. Confidence intervals and mean square prediction error can be 
                             computed. F-tests are able to be conducted and publication quality plots of data 
                             are able to be generated"),
                                       br(),
                                       br(),
                                       
                                       h2("What our package have"),
                                       em("The package must contain"), 
                                       tags$ul("Confidence intervals: the user must be able to choose the significance level ?? to obtain for the 1???$/alpha$ ?? confidence intervals for ?? and whether,
                            to use the asymptotic or bootstrap approach for this."),
                                       tags$ul("Plots including:"),
                                       tags$ol(
                                           tags$li("Residuals vs fitted-values"),
                                           tags$li("qq-plot of residuals"),
                                           tags$li("Histogram (or density) of residuals"),
                                       ),
                              ),
                              tags$li("Mean Square Prediction Error (MSPE) computed in matrix form:"),
                              tags$li("F-test: compute the statistic in matrix form and output the corresponding p-value."),
                              tags$li("Help documentation for all functions (for example using the roxygen2 package"),)
                    
                    hr(),
                    br(),
                ) #MainPanel
                
), #Intro

#ABA2
tabPanel("Meet the team",
         fluidRow(
             column(6,
                    bs4UserCard(
                        title = "Compiler","App Creator",
                        subtitle = "Maria Terra",
                        status = "info",
                        width = 12,
                        #src = "www/pic_with_r_logo_github.jpg",
                        bs4ListGroup(
                            width = 12,
                            bs4ListGroupItem(
                                "Github: mariaterezaterra",
                                type = "action",
                                #src = "https://github.com/MariaTerezaTerra"
                            )
                        )
                    )
             ),
             
             column(6,
                    bs4UserCard(
                        title = "Creator","Author",
                        subtitle = "Akeem Ajede",
                        status = "info",
                        width = 12,
                        #src = "www/pic_with_r_logo_github.jpg",
                        bs4ListGroup(
                            width = 12,
                            bs4ListGroupItem(
                                "Github: Hakeem-7",
                                type = "action",
                                #src = "https://github.com/Hakeem-7"
                            )
                        )
                    )
             ),   
             column(6,
                    bs4UserCard(
                        title = "Author",
                        subtitle = "Cary Burdick",
                        status = "info",
                        width = 12,
                        #src = "www/pic_with_r_logo_github.jpg",
                        bs4ListGroup(
                            width = 12,
                            bs4ListGroupItem(
                                "Github: clb0063",
                                type = "action",
                                #src = "https://github.com/clb0063"
                            )
                        )
                    )
             ),   
             column(6,
                    bs4UserCard(
                        title = "Conytibutor",
                        subtitle = "Kaelyn Fogelman",
                        status = "info",
                        width = 12,
                        #src = "www/pic_with_r_logo_github.jpg",
                        bs4ListGroup(
                            width = 12,
                            bs4ListGroupItem(
                                "Github: kaefogelman",
                                type = "action",
                                #src = "https://github.com/kaefogelman"
                            )
                        )
                    )
             ),
             
         ), #fluidrow
         
         
         
         
), #Meet the team







#ABA3
tabPanel("Let's try", 
         
         h1("F-testLoading"),
         em("Loading..."
            
            
            
            
         )      
)   
)

# Define server function  
server <- function(input, output) {
    
    output$txtout <- renderText({
        paste( input$txt1, input$txt2, sep = " " )
    })
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)