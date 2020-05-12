%PARZEN_MAP Map a dissimilarity dataset on a Parzen densities based classifier
% 
% 	F = PARZEN_MAP(D,W)
%
% INPUT
%   D   Dissimilarity dataset
%   W   Trained Parzen dissimilarity classifier mapping
%
% OUTPUT
%   F   Mapped dataset
%
% DESCRIPTION 
% 
% SEE ALSO
% MAPPINGS, DATASETS, PARZENDDC

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function f = parzend_map(d,w)
	prtrace(mfilename);

	% If no mapping is supplied, train one.
	if (nargin < 2)
		w = parzenddc(d); 
	end

	pars = getdata(w);
	I = getdata(w,'objects');
	p = getdata(w,'prior');
	nlab = getdata(w,'nlab');
	h = getdata(w,'smoothpar');
	q = getdata(w,'weights');
	[k,c] = getsize(w);
	[m,k] = size(d);
	e = +d(:,I);
	
	f = zeros(m,c);
	for j=1:c
		J = find(nlab==j);
		f(:,j) = p(j)*mean(repmat(q(J)',m,1).*exp(-(e(:,J).^2)./repmat((2.*h(J).*h(J))',m,1)),2);
	end
	
	f = setdata(d,f,getlabels(w));
	
return