# Random-Matrices
## Projektna naloga za predmet Matematika z racunalnikom

**I observe random matrices with elements generated as:**
* uniformly distributed random numbers in the interval (0,1)
* uniformly distributed random integers in the interval [-r,r] 
* normally distributed random numbers
* discrete distribution with two values

**Observed properties:**
* eigenvalues (distribution of eigenvalues, number of real eigenvalues, probability of some/all real eigenvalues)
* traces (distribution)
* determinants (distribution)

**Content of repository:**
* fanaliza: This Matlab file contains a function with 3 arguments (n = size of matrix, st_ponovitev = number of repetitions, d = distribution). It generates *st_ponovitev* matrices of size *n* with the given distribution and calculates its eigenvalues, trace and determinant. Its output is this particular order: stevilo_realnih_lastnih = number of real eigenvalues, vse_lastne = matrix of all eigenvalues, normvse_lastne = matrix of all normalized eigenvalues (eigenvalues divided with square root of n), vse_sledi = all trances and vse_det = all determinants
* analiza: This Matlab file contains further analysis of random matrices using the function in file fanaliza. At the beginning of this file you can set the wanted matrix size, number of repetitions and the distribution. When loading the file you then get the wanted analysis with all the associated graphs.
* parametri: This Matlab file contains an analysis of the parameters of the asymptotically normal distribution of traces and the logarithms of the determinants depending on the size of the matrix.
* Pričakovano število realnih lastnih: This is Mathematica file contains the theoretical formula for calculating the expected number of real eigenvalues of nxn matrix
* Nakljucne simetricne matrike: this folder contains further observations on symmetric random matrices (similar files fanaliza_sim and analiza_sim as on original observations and extra file eigenvalues_density wich contains further analysis of eigenvalues)
* GOE & GUE & GSE: this folder contains further observations on Gaussian ensembles matrices (similar files fanaliza_G and analiza_G as on original observations and extra file eigenvalues_analiza_G wich contains further analysis of eigenvalues)