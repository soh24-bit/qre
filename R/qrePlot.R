#' A plot showing Convergence of Strategies
#'
#' @param x fit object
#' @param ...
#'
#' @returns A plot showing convergence to Mixed Strategy Nash Equilibrium labeled with estimated Lambda
#' @export
#'
#' @examples
#' # Battle of the Sexes: coordination game with asymmetric preferences
#' # Multiple Nash equilibria: (Opera, Opera) and (Football, Football)
#' # Also has mixed strategy Nash: P1 plays Opera 2/3, P2 plays Football 2/3
#' payoffs_p1 <- matrix(c(2, 0, 0, 1), nrow = 2, byrow = TRUE)
#' payoffs_p2 <- matrix(c(1, 0, 0, 2), nrow = 2, byrow = TRUE)
#' rownames(payoffs_p1) <- c("Opera", "Football")
#' colnames(payoffs_p2) <- c("Opera", "Football")
#'
#' # Simulate data with coordination attempts
#' set.seed(456)
#' observed_data <- data.frame(
#'   p1_choice = sample(c("Opera", "Football"), 150, replace = TRUE, prob = c(0.60, 0.40)),
#'   p2_choice = sample(c("Opera", "Football"), 150, replace = TRUE, prob = c(0.45, 0.55))
#' )
#'
#' # Plot QRE
#' fit <- estimate_qre(payoffs_p1, payoffs_p2, observed_data)
#' plot(fit)
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

  # Player 1 graph
  player1_graph <- qre_data %>%
    dplyr::filter(player == "Player 1") %>%
    ggplot2::ggplot(ggplot2::aes(x = lambda, y = probability, color = strategy)) +
    ggplot2::geom_line(linewidth = 1.2) +
    ggplot2::geom_vline(xintercept = x$lambda, linetype = "dashed", linewidth = 1) +
    ggplot2::labs(title = "Player 1 Strategy Convergence", color = "Strategy") +
    ggplot2::xlab(expression(lambda)) +
    ggplot2::ylab("Probability") +
    ggplot2::annotate("text", x = x$lambda + 0.05, y = 0.03,
                      label = "hat(lambda)", parse = TRUE, color = "red") +
    ggplot2::theme_minimal()

  # Player 2 graph
  player2_graph <- qre_data %>%
    dplyr::filter(player == "Player 2") %>%
    ggplot2::ggplot(ggplot2::aes(x = lambda, y = probability, color = strategy)) +
    ggplot2::geom_line(linewidth = 1.2) +
    ggplot2::geom_vline(xintercept = x$lambda, linetype = "dashed", linewidth = 1) +
    ggplot2::labs(title = "Player 2 Strategy Convergence", color = "Strategy") +
    ggplot2::xlab(expression(lambda)) +
    ggplot2::ylab("Probability") +
    ggplot2::annotate("text", x = x$lambda + 0.05, y = 0.03,
                      label = "hat(lambda)", parse = TRUE, color = "red") +
    ggplot2::theme_minimal()

  # Combine plots
  player1_graph + player2_graph + patchwork::plot_layout(guides = "collect")

}
