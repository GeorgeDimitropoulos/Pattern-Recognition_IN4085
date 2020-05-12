%DISSPACES Compute various spaces out of a dissimilarity matrix
%
%   [X,E,W] = DISSPACES(D,W,FLAG)
%
% INPUT
%   D    Dataset, square dissimilarity matrix, size NxN
%   W    Pseudo-Euclidean mapping, W = PE_EM(D)
%        signature [P,Q], see PE_EM
%   FLAG 1 normalize distances by DISNORM (default)
%        0 do not normalize
% 
% OUTPUT
%   X   Cell array of five datasets related to embedded 'spaces'
%       - Nx(N-1) PE space
%       - Nx(N-1) Associated space
%       - NxP     Positive space 
%       - NxQ     Negative space
%       - Nx(N-1) Corrected space
%   E   Cell array of five datasets related to dissimilarity 'spaces'.
%       These are the NxN (Pseudo-)Euclidean dissimilarity matrices
%       computed from the above embedded spaces
%   W   Cell array with the mappings from D to E
%
% SEE ALSO
% PE_EM

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [X,D,W] = disspaces(d,wpe,normalize)

	if nargin < 3, normalize = 1; end
  if nargin < 2 | isempty(wpe)
		wpe = pe_em(d);
	end
	
  % Pseudo-Euclidean space
  xpe = d*wpe;
  xpe = setname(xpe,'PE Space');
  dis = setname(d,'Dis Space');
  if normalize, dis = dis*disnorm(dis); end
  sig = getsig(wpe);

  % Associated space, neglect signature
  was = wpe*setsig;
  xas = d*was;
  xas = setname(xas,'Ass Space');
  das = sqrt(distm(xas));
  if normalize, das = das*disnorm(das); end
  das = setname(das,'Ass Dis Space');
  
  % Positive space, use sig(1) features only
  wps = wpe(:,1:sig(1))*setsig;
  xps = d*wps;
  xps = setname(xps,'Pos Space');
  dps = sqrt(distm(xps));
  if normalize, dps = dps*disnorm(dps); end
  dps = setname(dps,'Pos Dis Space');
  
  % Negative space, use sig(2) features only (start at sig(1)+1)
	if sig(2) == 0
		xns = setdat(d,zeros(size(d,1),1));
		dns = setdat(d,zeros(size(d,1),size(d,1)));
	else
		wns = wpe(:,sig(1)+1:end)*setsig;
		xns = d*wns;
		dns = sqrt(distm(xns));
		if normalize, dns = dns*disnorm(dns); end
	end
	xns = setname(xns,'Neg Space');
	dns = setname(dns,'Neg Dis Space');
  
  % Corrected space (add off-diagonal constant)
  L = getdata(wpe,'eval');
  m = size(d,1);
  dcs = sqrt(d.^2+2*(-min(L))*(ones(m)-eye(m)));
  %dcs = dcs*disnorm(dcs);
  if normalize, dcs = dcs./meanstd(dcs); end
  dcs = setname(dcs,'Cor Dis Space');
  xcs = dcs*pe_em(dcs); % compute space fom dis mat
  xcs = setname(xcs,'Cor Space');
  if nargout > 2 % save some time
    wcs = affine(prinv(+d)*(+xcs),[],d); % OK for original data
	end
  
  X = {xpe,xas,xps,xns,xcs};
  D = {dis,das,dps,dns,dcs};
  if nargout > 2 % save some time
    W = {wpe,was,wps,wns,wcs};
	end
	
	
function [u,s] = meanstd(d)

  m = size(d,1);
  d = +d;
  d = reshape(d(1:end-1),m+1,m-1); % remove all zeros on diagonal
  d = d(2:m+1,:);
  u = mean(d(:));
  s = std(d(:));
