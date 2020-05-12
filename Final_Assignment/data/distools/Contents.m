%    DisTools Table of Contents
%   23-Nov-2009_17:27
% 
%   This Matlab toolbox for the analysis of dissimilarity data works only 
%   if also the pattern recognition toolbox PRTools is available.
%   See http://prtools.org
% 
%     E. Pekalska,  ela.pekalska@googlemail.com, University of Manchester
%     R.P.W. Duin,  r.duin@ieee.org, Delft University of Technology
% 
%  Characterization of dissimilarity matrices
%  ------------------------------------------
%  CHECKEUCL    Check whether a square dissimilarity matrix has a Euclidean behavior
%  CHECKTR      Check whether a square dissimilarity matrix obeys triangle inequality
%  CHARDMAT     Fiand several characteristic of (dis)similarity data
%  CORRTR       Correct a square dissimilarity matrix to obey the triangle inequality
%  DISCHECK     Dissimilarity matrix check
%  DISNORM      Normalization of a dissimilarity matrix
%  DISSTAT      Basic statistics of the dissimilarity matrix
%  ISSQUARE     Check whether a matrix is square
%  ISSYM        Check whether a matrix is symmetric
%  ASYMMETRY    Compute asymmetry of dissimilarity matrix
%  NNE          Leave-one-out Nearest Neighbor error on a dissimilarity matrix
%  NNERR        Exact expected NN error from a dissimilarity matrix
%  
%  Dissimilarity Measures
%  -----------------------------------------------
%  COSDISTM     Distance matrix based on inner products
%  EUDISTM      Euclidean distance matrix
%  HAMDISTM     Hamming distance matrix between binary vectors
%  HAUSDM       Hausdorff and modified Hausdorff distance between datasets of image blobs
%  
%  Transformations
%  DISSIMT      Fixed DISsimilarity-SIMilarity transformation
%  MAKESYM      Make a matrix symmetric
%  PE_EM        Pseudo-Euclidean embedding (includes Classical Scaling as a special case)	
%  
%  Classification in Pseudo-Euclidean Space and indefinite kernels
%  -----------------------------------------------
%  SETSIG       Set PE signature for mappings or datasets
%  GETSIG       Set PE signature for mappings or datasets
%  ISPE_DATASET Test dataset for PE signature setting 
%  ISPE_EM      Test mapping for PE signature setting
%  PE_DISTM     Square pseudo-Euclidean distance between two datasets
%  PE_KERNELM   Compute kernel in PE space
%  PE_MTIMES    Matrix multiplication (inner product) in PE space
%  PE_PARZENC   Parzen classifier in PE space
%  PE_KNNC      KNN classifier in PE space
%  PE_NMC       Nearest mean classifier in PE space
%  PE_EM        Pseudo-Euclidean linear embedding
%  PLOTSPECTRUM Plot spectrum of eigenvalues
%  
%  Routines supporting in learning from dissimilarity matrices
%  -----------------------------------------------------------------------
%  CROSSVALD    Cross-validation error for dissimilarity data
%  CLEVALD      Classifier evaluation (learning curve) for dissimilarity data
%  DISSPACES    Compute various spaces out of a dissimilarity matrix
%  GENDDAT      Generate random training and test sets for dissimilarity data
%  GENREP       Generate a representation set
%  GENREPI      Generate indices for representation, learning and testing sets
%  SELCDAT      Select Class Subset from a Square Dissimilarity Dataset
%  PROTSELFD    Forward prototype selection   
%  DLPC         LP-classifier on dissimilarity (proximity) data
%  KNNDC        K-Nearest Neighbor classifier for dissimilarity matrices
%  PARZENDDC    Parzen classifier for dissimilarity matrices
%  TESTKD       Test k-NN classifier for dissimilarity data
%  TESTPD       Test Parzen classifier for dissimilarity data
% 
%  EXAMPLES
%  --------
%  CROSSVALD_EX Crossvalidation of several classifiers
