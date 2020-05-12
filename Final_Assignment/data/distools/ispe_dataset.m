%ISPE_DATASET Test whether the argument is a pseudo-Euclidean dataset
%
% 	N = ISPE_DATASET(A);
%
% INPUT
%		A	 Input argument
%
% OUTPUT
%		N  1/0 if A is/isn't a PE dataset
%
% DESCRIPTION
% The function ISPE_DATASET test if A is a dataset object containing the
% signature of the PE space in the user field. This is set by a PE mapping
% found by PSEM.
%
% SEE ALSO
% ISDATASET, PSEM 

% R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function n = ispe_dataset(a)
		
  if isdataset(a)
    sig = getuser(a,'pe_signature');
  	n = ~isempty(sig);
  else
    n = 0;
  end
  if (nargout == 0) & (n == 0)
    error([newline 'PE dataset expected.'])
  end
  
return;
