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

# Define UI
ui <- fluidPage(theme = shinytheme("cosmo"),
                
                navbarPage(
                    "MACKLinear_FinalProjectGroup5",
                    
                    tabPanel( tabName = "Intro"),
                      mainPanel(style="text-align:justify;",
                                "Intro",
                                h1("Welcome"),
                                em ("This is an app developed to for our final project in 'R-programming for Data Science' class. We created a package for performing linear
                             regressions and also associated statistical outputs. Confidence intervals and mean square prediction error can be 
                             computed. F-tests are able to be conducted and publication quality plots of data 
                             are able to be generated"),
                                br(),
                                br(),
                                h2("What our package have"),
                                em("The package must contain:"),
                                tags$ul("Confidence intervals: the user must be able to choose the significance level  \\(\\alpha\\) to obtain for the 1-\\(\\alpha\\) confidence intervals for  \\(\\beta\\) and whether,
                            to use the asymptotic or bootstrap approach for this."),
                                tags$ul("Plots including:",
                                  tags$li("Residuals vs fitted-values"),
                                  tags$li("qq-plot of residuals"),
                                  tags$li("Histogram (or density) of residuals")
                                      ),
                                tags$ol(
                                  tags$li("Mean Square Prediction Error (MSPE) computed in matrix form:"),
                                  tags$li("F-test: compute the statistic in matrix form and output the corresponding p-value."),
                                  tags$li("Help documentation for all functions (for example using the roxygen2 package")
                                ),
                      hr(),
                      br(),
                
 

                      #ABA2
                      
tabPanel("Meet the team", tabName = "Meet the team",
         p(a("Akeem Ajede", href="https://github.com/Hakeem-7", target="_blank"),style = "font-size:25px"),
         p("Creator, Author" = "font-size:17px"),
         p(a("Cary Burdick", href="https://github.com/clb00635", target="_blank"),style = "font-size:25px"),
         p("Author",style = "font-size:17px"),
         p(a("Kaelyn Fogelman", href="https://github.com/kaefogelman", target="_blank"),style = "font-size:25px"),
         h6("Pic"),
         tags$img('Kaelyn_Fogelman.png', height = 30, width = 30),
         p("Author",style = "font-size:17px")),
         p(a("Maria Terra", href="https://github.com/MariaTerezaTerra", target="_blank"),style = "font-size:25px"),
         p("Author",style = "font-size:17px")),




#ABA3

tabPanel("Let give a try", tabName = "Let's give a try",

         h1("F-testLoading"),
         em("Loading...")

     

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
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)