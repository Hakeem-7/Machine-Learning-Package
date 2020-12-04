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

                                       vars <- setdiff(names(iris), "Species"),

                                       pageWithSidebar(
                                         headerPanel('Iris k-means clustering'),
                                         sidebarPanel(
                                           selectInput('xcol', 'X Variable', vars),
                                           selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
                                           numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
                                         ),
                                         mainPanel(
                                           plotOutput('plot1')
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





# Define server function
server <- function(input, output, session) {

  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })

  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })



  } # server



# Create Shiny object
shinyApp(ui = ui, server = server)
