

#' @name summary.par.logiciel
#' @description découpe un vecteur de nombres en groupes et pour chaque groupe calcule 5 valeurs
#'              min, max, moyenne, variance, nb d'items.
#'              Le vecteur fx détermine les goupes.
#' @return une matrice de 5 colonnes. Le nombre de lignes est égal au nombre de groupes (facteurs)
#' @param vx un vecteur de nombre
#' @param fx un vecteur équivalent de facteurs
#' @usage a <- summary.par.logiciel(d$MS_exhaus, d$Logiciel_2015)

summary.par.logiciel <- function(vx, fx){
  min <- tapply(vx, fx, min, na.rm = TRUE)
  max <- tapply(vx, fx, max, na.rm = TRUE)
  mean <- tapply(vx, fx, mean, na.rm = TRUE)
  sd <- tapply(vx, fx, sd, na.rm = TRUE)
  n  <- tapply(vx, fx, length)
  
  a <- cbind(min, max, mean, sd, n)
  colnames(a) <- c("Min", "Max", "moyenne", "ecart-type", "Nb")
  
  return(a)
}