#' @export
MC_gui = function(){
  appDir = system.file("my_lm", package = "macklinear")
  shiny::runApp(appDir, display.mode = "normal")
}
