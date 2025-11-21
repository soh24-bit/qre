#' Validate Input
#'
#' @param payoffs_p1 Matrix of Player 1 Payoff
#' @param payoffs_p2 Matrix of Player 2 Payoff
#' @param observed_data Observed Strategy Choices
#'
#' @returns NULL (throws error if validation fails)
validate_qre_inputs <- function(payoffs_p1, payoffs_p2, observed_data) {

  # Check payoff matrices are numeric
  if (!is.matrix(payoffs_p1) || !is.numeric(payoffs_p1)) {
    stop("payoffs_p1 must be a numeric matrix")
  }
  if (!is.matrix(payoffs_p2) || !is.numeric(payoffs_p2)) {
    stop("payoffs_p2 must be a numeric matrix")
  }

  # Check dimensions match
  if (!identical(dim(payoffs_p1), dim(payoffs_p2))) {
    stop("payoffs_p1 and payoffs_p2 must have the same dimensions")
  }

  # Check for row/column names
  if (is.null(rownames(payoffs_p1))) {
    stop("payoffs_p1 must have rownames (Player 1 strategy names)")
  }
  if (is.null(colnames(payoffs_p2))) {
    stop("payoffs_p2 must have colnames (Player 2 strategy names)")
  }

  # Check observed_data
  if (!is.data.frame(observed_data)) {
    stop("observed_data must be a data.frame")
  }
  if (ncol(observed_data) != 2) {
    stop("observed_data must have exactly 2 columns (Player 1 and Player 2 choices)")
  }
  if (nrow(observed_data) == 0) {
    stop("observed_data must contain at least one observation")
  }

  # Check that observed strategies match payoff matrix strategy names
  p1_strategies <- rownames(payoffs_p1)
  p2_strategies <- colnames(payoffs_p2)

  obs_p1 <- unique(observed_data[[1]])
  obs_p2 <- unique(observed_data[[2]])

  if (!all(obs_p1 %in% p1_strategies)) {
    stop("Player 1 strategies in observed_data don't match rownames of payoffs_p1")
  }
  if (!all(obs_p2 %in% p2_strategies)) {
    stop("Player 2 strategies in observed_data don't match colnames of payoffs_p2")
  }

  invisible(NULL)
}

#' Strategy Counter
#'
#' @param observed_data Data that contains strategy of players
#' @param payoffs_p1 Player 1 payoff
#' @param payoffs_p2 Player 2 payoff
#'
#' @returns Count of strategies for each players
calculate_observed_frequencies <- function(observed_data, payoffs_p1, payoffs_p2) {

  p1_strategies <- rownames(payoffs_p1)
  p2_strategies <- colnames(payoffs_p2)

  # Count frequency of each strategy
  p1_counts <- table(factor(observed_data[[1]], levels = p1_strategies))
  p2_counts <- table(factor(observed_data[[2]], levels = p2_strategies))

  # Convert to proportions
  p1_freq <- as.numeric(p1_counts / sum(p1_counts))
  p2_freq <- as.numeric(p2_counts / sum(p2_counts))

  names(p1_freq) <- p1_strategies
  names(p2_freq) <- p2_strategies

  list(
    p1 = p1_freq,
    p2 = p2_freq,
    n = nrow(observed_data)
  )

}
