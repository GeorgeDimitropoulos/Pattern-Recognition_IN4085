%PLOTSPECTRUM
%
%     h = PLOTSPECTRUM(L)
%     h = PLOTSPECTRUM(W)
%
% Plot spectrum as stored in vector L or in mapping W.

function [h1,h2] = plotspectrum(L)

if ismapping(L)
  if strcmp(getmapping_file(L),'psem')
    L = getdata(L,4);
    tit = 'Embedding Spectrum';
  elseif strcmp(getmapping_file(L),'affine') | strcmp(getmapping_file(L),'pe_em')
    try 
      L = getdata(L,'eval');
      tit = 'Eigenvalues';
    catch
      error('No spectrum found');
    end
  else
    error('No spectrum found')
  end
else
  tit = 'Eigenspectrum';
end

L = flipud(sort(L(:)));
sig1 = max(find(L>=0));
sig2 = length(L) - sig1;

if sig2 == 0
    hh1 = plot([1:sig1],[L(1:sig1)]); 
else
    hh1 = plot([1:sig1 sig1+0.5],[L(1:sig1);0]); 
    hold on; 
    hh2 = plot([sig1+0.5 sig1+1:sig1+sig2],[0;L(sig1+1:end)],'r');
    hold off
end
V = axis;
V(1) = -1;
V(2) = length(L)+2;
axis(V);
fontsize(16);
linewidth(2);
xlabel('Eigenvector')
ylabel('Eigenvalue')
title(tit)
if nargout > 1
    h1 = hh1;
    h2 = hh2;
end