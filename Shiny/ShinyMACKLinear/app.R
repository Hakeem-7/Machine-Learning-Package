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
library(macklinear)

#DATA
data("cars")
n = 300
mydata <- cars
y <- mydata$dist


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

                                h1("Our package"),
                                em("The package must contain:"),
                                tags$li("Confidence intervals: the user must be able to choose the significance level  \\(\\alpha\\) to obtain for the 1-\\(\\alpha\\)
                                confidence intervals for  \\(\\alpha\\) and whether,to use the asymptotic or bootstrap approach for this."),
                                tags$li("Plots including:",
                                  tags$ul("- Residuals vs fitted-values"),
                                  tags$ul("- qq-plot of residuals"),
                                  tags$ul("- Histogram (or density) of residuals"),
                                  tags$li("Mean Square Prediction Error (MSPE) computed in matrix form:"),
                                  tags$li("F-test: compute the statistic in matrix form and output the corresponding p-value."),
                                  tags$li("Help documentation for all functions (for example using the roxygen2 package"),

                                  br(),
                                  br(),

                                h1("Usage"),
                                em("There are two functions contained in the package:"),
                                tags$li("my_lm() for building a linear regression model and outputting related statistics,"),
                                tags$li("plot_func() for creating plots of some of these statistics from linear regression."),
                                  br(),
                                em("The full form of each function with each argument and default value, if any, is listed below:"),
                                  br(),
                                  br(),
                                tags$code("my_lm(response, covariates, alpha = 0.05, method = asymptotic, intercept = 1", style = "color: blue"),
                                br(),
                                tags$code("plot_func(lm)", style = "color: blue"),
                                  br(),
                                br(),
                                tags$li("response: a one-dimensional vector of numerical y values used as the response variable in the regression equation."),
                                tags$li("covariates: a matrix of numerical x values used as the explanatory variable(s) in the regression equation. Can be one-dimensional
                                        if running simple linear regression or two-dimensional if running multiple linear regression."),
                                tags$li("alpha: a value between 0 and 1 that specifies the alpha level with which to form the two-tailed confidence interval for beta.hat.
                                        The default value is 0.05."),
                                tags$li("method: a string value indicating the method used for generating the confidence intervals for beta.hat. The asymptotic method
                                        will be performed if asymptotic or `a` are specified. The bootstrap method will be performed if `bootstrap` or `b are specified.
                                        The default value is `asymptotic`."),
                                tags$li("intercept: a binary value of either 1 or -1 specifying if the model should estimate the intercept.
                                        A value of 1 will include the intercept while -1 will exclude the intercept. The default value is 1."),


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

         h2(a("Cary Burdick", href="https://github.com/clb0063", target="_blank"),style = "font-size:25px"),
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

                                       h2("Loading"),


                                       sidebarLayout(
                                         sidebarPanel(
                                           sliderInput("alpha", "Alpha value:",
                                                       value = 0.05,
                                                       min = 0.01,
                                                       max = 0.1),
                                           br(),
                                           br(),
                                           radioButtons("method","Method:",
                                                        c("asymptotic" = "Asymptoic",
                                                          "bootstrap" = "Bootstrap")),
                                           br(),
                                           br(),
                                           actionButton("button", "Show graph"),
                                         ),


                                         # Show a plot:
                                         mainPanel(
                                           plotOutput("FinalPlot")
                                         )
                                       )
                              ),



         hr(),
         br(),




)
)
#As tres ou duas ultimas de sempre que cada hora eh uma coisa
)
)





# Define server function
server <- function(input, output) {


    fit_my_lm <- my_lm(mydata$dist,myData,
                       alpha = input$alpha, method = input$method,
                       intercept = 1)


    output$FinalPlot = renderPlot({
      plot(fit_my_lm)
    })



  } # server



# Create Shiny object
shinyApp(ui = ui, server = server)
