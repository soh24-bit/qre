ll <- function(observed_freqs, qre_probs) {

  n <- observed_freqs$n

  # Log likelihood: sum(n_i * log(p_i))

  ll_p1 <- sum((observed_freqs$p1 * n) * log(qre_probs$p1))
  ll_p2 <- sum((observed_freqs$p2 * n) * log(qre_probs$p2))

  ll_p1 + ll_p2
}

nll <- function(lambda, observed_freqs, payoffs_p1, payoffs_p2) {

  # lambda must be non-negative
  if (lambda < 0) {
    return(Inf)
  }

  # Solve for QRE given lambda
  qre_probs <- solve_qre(lambda, payoffs_p1, payoffs_p2)

  # Return negative log-likelihood
  -ll(observed_freqs, qre_probs)

}
