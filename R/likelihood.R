log_likelihood <- function(observed_freqs, qre_probs) {

  n <- observed_freqs$n

  # Log likelihood: sum(n_i * log(p_i))

  ll_p1 <- sum((observed_freqs$p1 * n) * log(qre_probs$p1))
  ll_p2 <- sum((observed_freqs$p2 * n) * log(qre_probs$p2))

  ll_p1 + ll_p2
}
