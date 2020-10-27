shinyUI(navbarPage(
  
  # Application title
  "shinygamer: Rで学ぶゲーム理論",
  
  
  # Normal-form games
  tabPanel("標準型（戦略型）ゲーム",
    h1("標準型（戦略型）ゲーム"),
    
    # First row
    fluidRow(
      column(6,
             textInput("p1_name",
                       h4("プレイヤー1 (P1)の名前"),
                       value = "Player 1")
      ),
      column(6,
             textInput("p2_name",
                       h4("プレイヤー2 (P2)の名前"),
                       value = "Player2")
      )
    ),
    
    # Second row
    fluidRow(
      column(12,
             h3("利得表"),
             p("以下の表をゲームに応じて書き換えてください。"),
             p("P1の戦略を行名（P1-s1, P1-s2, ...）に、P2の戦略を列名（P2-s1, P2-s2, ...）に入力してください。"),
             p("各セルに、P1とP2の利得をカンマ区切りで入力してください（例：3, 4）。"),
             p("行数、列数は必要に応じて増やすことができます（既存の行または列が埋まると自動的に増えます）。"),
             matrixInput("payoffs",
                         value = matrix("0, 0", 2, 2,
                                        dimnames = list(
                                          c("P1-s1", "P1-s2"),
                                          c("P2-s1", "P2-s2"))),
                         rows = list(
                           names = TRUE,
                           editableNames = TRUE,
                           extend = TRUE),
                         cols = list(
                           names = TRUE,
                           editableNames = TRUE,
                           extend = TRUE))
      )
    ),
    
    # Third row
    fluidRow(
      column(3,
             checkboxInput("mark_br",
                           h4("最適反応に印を付ける"),
                           value = FALSE),
             actionButton("do",
                          h4("ゲームを表示する")),
             p(),
             downloadButton("save_table",
                            "ゲームの表をPNGで保存")
      ),
      column(9,
             mainPanel(
               h3("標準型ゲーム"),
               gt::gt_output("game_table")
             )
      )
    ),
    
    # Fourth row
    fluidRow(
      h1(""),
      column(3,
             actionButton("show_PSNE",
                          "純粋戦略ナッシュ均衡を表示する")
      ),
      column(9,
             mainPanel(
               h3(""),
               textOutput("print_PSNE")
             )
      )
    ),
    
    # Fifth row
    fluidRow(
      column(3,
             h3(""),
             actionButton("br_do",
                          "最適反応を図示する"),
             p(),
             downloadButton("save_brplot",
                            "最適反応曲線をPNGで保存")
      ),
      column(9,
             h3(""),
             mainPanel(
               plotOutput("br_plot")
             )
      )
    ),
    
    # Sixth row
    fluidRow(
      column(3,
             actionButton("show_MSNE",
                          "混合戦略ナッシュ均衡を表示する")
      ),
      column(9,
             mainPanel(
               h3(""),
               textOutput("print_MSNE")
             )
      )
    )
    
  ),
      
  
  
  # Extensive-form games
  tabPanel("展開型（逐次）ゲーム",
    h1("展開型（逐次）ゲーム")
  )  
  
))
