%ASYMMETRY Estimate asymmetry of dissimilarity matrix
%
%   ASYM = ASYMMETRY(D)
%
% The asymmetry is defined as the average over 2*|D-D'|./(|D|+|D'|).

function asym = asymmetry(d)

  d = +d;
  e = abs(d-d')./(abs(d)+abs(d')+1e-100); %avoid division by 0
  L = find(~isnan(e));
  asym = mean(mean(e(L)));

return
