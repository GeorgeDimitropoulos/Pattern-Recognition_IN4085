%CHECKSUBEUCL Find probabilities for non-Euclidean subsets
%
%	NEP = CHECKSUBEUCL(D,N)
%
% For every size of subsets of the dissimilarity matrix D at random
% N of such subsets are taken and checked on their Euclideaness.
% In NEP(n) the fraction of non-Euclidean subsets is returned for
% subsets of size n. Default N = 500.

%  SEE ALSO
%  PSEM, CHECKEUCL, CHECKTR

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function nep = checksubeucl(d,reps)

if nargin < 2 | isempty(reps), reps = 500; end
discheck(d)
m = size(d,1);
d = prdataset(+d,1);
d = setfeatlab(d,ones(m,1));

[nef ner] = checkeucl(d);
nep = zeros(1,m);
if ner > 1e-6
  s = sprintf('Check sub-euclidean probs %i trials: ',reps);
  prwaitbar(reps,s);
  for n=1:reps
		prwaitbar(reps,n,[s int2str(n)]);
    J = randperm(m);
    for j=3:m
      [nef ner] = checkeucl(d(J(1:j),J(1:j)));
      if ner>1e-6
        nep(j:end) = nep(j:end) + 1;
        break
      end
    end
  end
  nep = nep/reps;
	prwaitbar(0)
end
  