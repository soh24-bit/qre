#' Title
#'
#' @param x
#' @param ...
#'
#' @returns
#' @export
#'
#' @examples
#' @importFrom dplyr %>%
plot.qre_fit <- function(x, ...) {

  # Lambda range
  lambda_seq <- seq(x$lambda * 0.1, x$lambda * 10, length.out = 100)

  # Compute QRE for each lambda
  qre_data <- lapply(lambda_seq, function(lam) {
    qre <- solve_qre(lam, x$payoffs_p1, x$payoffs_p2)

    data.frame(
      lambda = lam,
      strategy = c(rownames(x$payoffs_p1), colnames(x$payoffs_p2)),
      probability = c(qre$p1, qre$p2),
      player = rep(c("Player 1", "Player 2"), c(length(qre$p1), length(qre$p2)))
    )
  })

  qre_data <- do.call(rbind, qre_data)

  player1_graph <- qre_data %>%
    filter(player == "Player 1") %>%
    ggplot(aes(x = lambda, y = probability, color = strategy)) +
    geom_line() + geom_vline(xintercept = x$lambda, linetype = "dashed") +
    labs(title = "Player 1 Strategy Convergence", color = "Strategy") +
    xlab(expression(lambda)) + ylab("Probability") +
    annotate("text", x = x$lambda + 0.05, y = 0.03, label = "hat(lambda)", parse = TRUE, color = "red") +
    theme_minimal()

  player2_graph <- qre_data %>%
    filter(player == "Player 2") %>%
    ggplot(aes(x = lambda, y = probability, color = strategy)) +
    geom_line() + geom_vline(xintercept = x$lambda, linetype = "dashed") +
    labs(title = "Player 2 Strategy Convergence", color = "Strategy") +
    xlab(expression(lambda)) + ylab("Probability") +
    annotate("text", x = x$lambda + 0.05, y = 0.03, label = "hat(lambda)", parse = TRUE, color = "red") +
    theme_minimal()

  player1_graph + player2_graph

}
