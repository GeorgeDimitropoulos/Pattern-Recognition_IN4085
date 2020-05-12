%NNERR Exact expected NN error from a dissimilarity matrix (1)
%
%   E = NNERR(D,M)
%
% INPUT
%   D 	NxN dissimilarity dataset
%   M 	Vector with desired umber of objects to be selected
%
% OUTPUT
%   E 	Expected NN errror
%
%   E = NNERR(D)
%
% In this case a set of training set sizes is used to produce
% a full learning curve. E can be plotted by PLOTE.
%
% DESCRIPTION
% An exact computation is made of the expected NN error for a random 
% selection of M objects for training. D should be a dataset containing 
% a labeled square dissimilarity matrix.
%

% Copyright: R.P.W. Duin, r.duin@ieee.org
% and Elzbieta Pekalska, ela.pekalska@googlemail.com
% Faculty EWI, Delft University of Technology and
% School of Computer Science, University of Manchester

function e = nnerr(d,n)

  if nargin < 2, n = []; end
	m = size(d,2);
	if nargin == 2 & any(n >= m)
		error('Training set sizes should be smaller than sample size')
	end
	
	if isempty(n)
		% find full curve, but gain some speed
		L = [1:20 22:2:40 45:5:60 70:10:100 120:20:300 350:50:1000 1100:100:10000];
		L = [L(find(L<m-1)) m-1];
		f = zeros(1,m-1);
		prwaitbar(max(L),'Compute Learning Curve')
		for i=1:length(L)
			prwaitbar(max(L),L(i));
			f(L(i)) = feval(mfilename,d,L(i));
			if (i > 1) & (L(i)-L(i-1) > 1)
				for n=L(i-1):L(i)
					f(n) = f(L(i-1)) + (f(L(i))-f(L(i-1)))*(n-L(i-1))/(L(i)-L(i-1));
				end
			end
		end
		prwaitbar(0)
    
    e.error = f;
    e.xvalues = [1:length(e.error)];
    e.title = 'Learning curve 1-NN rule';
    e.xlabel = 'Size training set';
    e.ylabel = 'Expected classification error';
    e.plot = 'semilogx';
	
  elseif length(n) > 1
        
		for i=1:length(n)
			e(i) = feval(mfilename,d,n(i));
    end

  else
	
    q = zeros(1,m);
    for k = 1:m-n
      %p(k) = (prod(m-k+1-n+1:m-k+1) - prod(m-k-n+1:m-k)) / prod(m-n+1:m);
      q(k) = (exp(gamln(m-k+2)-gamln(m-k+1-n+1)-gamln(m+1)+gamln(m-n+1)) ...
		     - exp(gamln(m-k+1)-gamln(m-k-n+1)-gamln(m+1)+gamln(m-n+1)));
    end
    k = m-n+1;
    %p(k) = (prod(m-k+1-n+1:m-k+1) - prod(m-k-n+1:m-k)) / prod(m-n+1:m);
    q(k) = (exp(gamln(m-k+2)-gamln(m-k+1-n+1)-gamln(m+1)+gamln(m-n+1)));
	
    isdataset(d);
    nlab     = getnlab(d);
    d = d + diag(repmat(inf,1,m));
    [DD,L] = sort(+d,2);			% sort distances
    L = nlab(L);
    R = mean(L ~= repmat(nlab,1,m));
    e = q*R';

  end
    
return

function x = gamln(y)
	if y == 0, x = 1; 
	elseif y < 0, x = 1;
	else, x = gammaln(y); end
return