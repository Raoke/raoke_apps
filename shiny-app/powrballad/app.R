library(shiny)
#if(!require(powrballad))devtools::install_github("Raoke/powrballad")
#library(powrballad)


server <- function(input, output) {
    load("ballads.rda")
    select_powerballad <- function(){
        # read in latest songs
        # select a random song from ballads
        possible_values <- seq_len(nrow(ballads))
        sample(possible_values, size = 1)
        # return a random sample
        ballads[sample(possible_values,size = 1),]
    }

    shiny::observeEvent(
        input$random_song_selector, {
            output$song <- shiny::renderText({select_powerballad()} )
        }
    )

    output$song <- shiny::renderText({select_powerballad()} )
}

ui <- shiny::fluidPage(titlePanel("Karaoke |R-aoke Songselector"),
    p("It is Karaoke time! Use the button below to get a song. "),
    shiny::actionButton("random_song_selector", "Random Song Selector"),
            shiny::h3(textOutput("song")),
    img(src ="Raoke_titlepage.png", style = "width:50%")

)

shiny::shinyApp(ui = ui, server = server)



