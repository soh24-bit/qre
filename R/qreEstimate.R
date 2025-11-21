#' Estimate QRE
#'
#' @param payoffs_p1 Matrix of Player 1 Payoff
#' @param payoffs_p2 Matrix of Player 2 Payoff
#' @param observed_data Observed Strategy Choices
#' @param lambda_start A non-negative initial value for lambda
#' @param lower_bound A lower bound for "L-BFGS-B" method
#' @param upper_bound A upper bound for "L-BFGS-B" method
#'
#' @returns An object of class \code{qre_fit} containing:
#' \item{lambda}{Estimated MLE of lambda}
#' \item{probs_p1}{QRE strategy probabilities for Player 1}
#' \item{probs_p2}{QRE strategy probabilities for Player 2}
#' \item{observed_freqs}{Observed frequencies from the data}
#' \item{loglik}{Maximum log-likelihood value}
#' \item{payoffs_p1}{Payoff matrix for Player 1}
#' \item{payoffs_p2}{Payoff matrix for Player 2}
#' @export
#'
#' @examples
#' \dontrun{
#' # Matching Pennies: Pure mixed strategy game
#' # Nash equilibrium: Both players play 50% Heads, 50% Tails
#' payoffs_p1 <- matrix(c(1, -1, -1, 1), nrow = 2, byrow = TRUE)
#' payoffs_p2 <- matrix(c(-1, 1, 1, -1), nrow = 2, byrow = TRUE)
#' rownames(payoffs_p1) <- c("Heads", "Tails")
#' colnames(payoffs_p2) <- c("Heads", "Tails")
#'
#' set.seed(123)
#' observed_data <- data.frame(
#'   p1_choice = sample(c("Heads", "Tails"), 200, replace = TRUE, prob = c(0.52, 0.48)),
#'   p2_choice = sample(c("Heads", "Tails"), 200, replace = TRUE, prob = c(0.48, 0.52))
#' )
#'
#' fit <- estimate_qre(payoffs_p1, payoffs_p2, observed_data)
#' print(fit)
#' }
estimate_qre <- function(payoffs_p1, payoffs_p2, observed_data, lambda_start = 1, lower_bound = 0.01,
                         upper_bound = 50) {

  validate_qre_inputs(payoffs_p1, payoffs_p2, observed_data)

  obs_freqs <- calculate_observed_frequencies(observed_data, payoffs_p1, payoffs_p2)

  result <- stats::optim(
    par = lambda_start,
    fn = nll, # from liklihood.R
    observed_freqs = obs_freqs,
    payoffs_p1 = payoffs_p1,
    payoffs_p2 = payoffs_p2,
    method = "L-BFGS-B",
    lower = lower_bound,
    upper = upper_bound
  )

  # Get optimal lambda aka lambda hat
  lambda_hat <- result$par
  qre_probs <- solve_qre(lambda_hat, payoffs_p1, payoffs_p2)

  out <- structure(
    list(
      lambda = lambda_hat,
      probs_p1 = qre_probs$p1,
      probs_p2 = qre_probs$p2,
      observed_freqs = obs_freqs,
      loglik = -result$value,
      payoffs_p1 = payoffs_p1,
      payoffs_p2 = payoffs_p2
    ),
    class = "qre_fit"
  )
  return(out)
}
