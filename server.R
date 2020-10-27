shinyServer(function(input, output) {
  
 s_game <- eventReactive(input$do, {
   payoff_matrix <- input$payoffs
   n_row <- nrow(payoff_matrix) - 1
   n_col <- ncol(payoff_matrix) - 1
   payoff_matrix <- payoff_matrix[1:n_row, 1:n_col]
   s1 <- row.names(payoff_matrix)
   s2 <- colnames(payoff_matrix)
   cells <- as.vector(payoff_matrix)
   n_cells <- length(cells)
   p1 <- p2 <- rep(NA, n_cells)
   for (i in seq_along(cells)) {
     cell <- cells[i] %>% 
       str_split(pattern = ",") %>% 
       unlist() %>% 
       as.numeric()
     p1[i] <- cell[1]
     p2[i] <- cell[2]
   }
   
   game <- normal_form(
     players = c(ifelse(is.null(input$p1_name),
                        "Player 1", input$p1_name),
                 ifelse(is.null(input$p2_name),
                      "Player 2", input$p2_name)),
     s1 = s1,
     s2 = s2,
     p1 = p1,
     p2 = p2)
   solve_nfg(game,
             show_table = FALSE,
             mark_br = input$mark_br,
             plot = FALSE, 
             mixed = TRUE)
   
  })
  
  output$game_table <- gt::render_gt({
    s_game()$table
  })
  
  
  PSNE <- eventReactive(input$show_PSNE, {
    return(s_game()$psNE)
  })
  
  output$print_PSNE <- renderText({
    out <- PSNE()
    if (length(out) > 1) out <- paste(out, collapse = ", ")
    paste("純粋戦略ナッシュ均衡：", out)
  })
  
 
  br_plot <- eventReactive(input$br_do, {
    s_game()$br_plot
  })
  
  output$br_plot <- renderPlot({
    br_plot()
  })
  
  MSNE <- eventReactive(input$show_MSNE, {
    return(s_game()$msNE)
  })
  
  output$print_MSNE <- renderText({
    out <- MSNE()
    p1_out <- stringi::stri_join(MASS::fractions(out[[1]]), 
                                 collapse = ", ")
    p2_out <- stringi::stri_join(MASS::fractions(out[[2]]), 
                                 collapse = ", ")
    out <- paste0("[(", p1_out, "), (", p2_out, ")]")
    paste("混合戦略ナッシュ均衡：", out)
  })
  
  output$save_table <- downloadHandler(
    filename = function() {
      paste0("normal_form_game_", Sys.Date(), ".png")
    },
    content = function(file) {
      gt:::gtsave(s_game()$table, file)
    }
  )
  
  output$save_brplot <- downloadHandler(
    filename = function() {
      paste0("best_response_", Sys.Date(), ".png")
    },
    content = function(file) {
      png(file)
      print(s_game()$br_plot)
      dev.off()
    }
  )

})
