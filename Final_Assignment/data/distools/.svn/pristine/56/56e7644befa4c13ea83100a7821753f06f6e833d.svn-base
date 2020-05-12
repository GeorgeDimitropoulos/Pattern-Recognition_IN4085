%NEF Compute Negative Eigen Fraction from dataset or mapping
%
%   F = NEF(D)
%   F = NEF(W)
%
% INPUT
%   D   - Dissimilarity matrix
%   W   - Pseudo-Euclidean mapping
%
% OUTPUT
%   F   - Negative eigenfraction
%
% DESCRIPTION
% The  Negative eigenfraction is a ratio expressing the sum of 
% magnitudes of all negative eigenvalues divided by the sum of 
% magnitudes of all eigenvalues. The necessary numbers are 
% stored in W = PE_EM(D). W is computed from D is needed.
%
% SEE ALSO
% DATASETS, MAPPINGS, PE_EM, CHECKEUCL 

function f = nef(input)

if isdataset(input)
	w = pe_em(input);
elseif ~ismapping(input)
	error('Input should be dataset or mapping')
else
	w = input;
end

eval = abs(getdata(w,'eval'));
sig  = getdata(w,'sig');
f = 1-sum(eval(1:sig(1)))/sum(eval);


