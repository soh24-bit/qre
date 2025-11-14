#' Title
#'
#' @param payoffs_p1
#' @param payoffs_p2
#' @param observed_data
#'
#' @returns NULL (throws error if validation fails)
#' @export
#'
#' @examples
validate_qre_inputs <- function(payoffs_p1, payoffs_p2, observed_data) {

  # Check payoff matrices are numeric
  if (!is.matrix(payoffs_p1) || !is.numeric(payoffs_p1)) {
    stop("payoffs_p1 must be a numeric matrix")
  }
  if (!is.matrix(payoffs_p2) || !is.numeric(payoffs_p2)) {
    stop("payoffs_p2 must be a numeric matrix")
  }


}
