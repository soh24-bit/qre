#' Title
#'
#' @param payoffs_p1
#' @param payoffs_p2
#' @param observed_data
#' @param lambda_start
#' @param method
#'
#' @returns
#' @export
#'
#' @examples
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
