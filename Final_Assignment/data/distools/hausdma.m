%HAUSDMA Asymmetric Hausdorff and modified Hausdorff distance between datafiles of image blobs
%
%  [DH,DM] = HAUSDMA(A,B)
%
% INPUT
%   A     Datafile of NA binary images
%   B     Datafileof of NB binary images
%
% OUTPUT
%   DH    NAxNB Hausdorff distance matrix
%   DM    NAxNB Modified Hausdorff distance matrix
%
% DESCRIPTION
% Computes a Hausdorff distance matrix DH and a modified Hausdorff distance
% matrix DM between the datafiles of binary images A and B.
% DH = MAX_B(MIN_A(D_AB)), DM = MEAN_B(MIN_A(D_AB))
% Preferably, NA <= NB (faster computation).
% Progress is reported in fid (fid = 1: on the sreeen).
%
% LITERATURE
% M.-P. Dubuisson and A.K. Jain, "Modified Hausdorff distance for object matching", 
% International Conference on Pattern Recognition, vol. 1, 566-568, 1994.
%

% Copyright: R.P.W. Duin, r.duin@ieee.org
% Faculty of EWI, Delft University of Technology


function [dh,dm] = hausdm(A,B)


na = size(A,1);
nb = size(B,1);
dh = zeros(na,nb);
dm = zeros(na,nb);
s1 = sprintf('Hausdorff distances from %i objects: ',na);
prwaitbar(na,s1)
A = data2im(A);
B = data2im(B);
for i=1:na
  prwaitbar(na,i,[s1 int2str(i)]);
  a = A{i};
	if ~isempty(a)
		a = bord(a,0);
	end
	ca = contourc(a,[0.5,0.5]);
	J = find(ca(1,:) == 0.5);
	ca(:,[J J+1]) =[];
	ca = ca - repmat([1.5;1.5],1,size(ca,2));
	ca = ca/max(ca(:));
	ca = ca - repmat(max(ca,[],2)/2,1,size(ca,2));
  %s2 = sprintf('Hausdorff distances to %i objects: ',nb);
  %prwaitbar(nb,s2)
	for j = 1:nb
    %prwaitbar(na,j,[s2 int2str(j)]);
		b = B{j};
		if ~isempty(b)
			b = bord(b,0);
		end
		cb = contourc(b,[0.5,0.5]);
		J = find(cb(1,:) == 0.5);
		cb(:,[J J+1]) =[];
		cb = cb - repmat([1.5;1.5],1,size(cb,2));
		cb = cb/max(cb(:));
		cb = cb - repmat(max(cb,[],2)/2,1,size(cb,2));
		dab = sqrt(distm(ca',cb'));
		dh(i,j) = max(min(dab));
		dm(i,j) = mean(min(dab));
  end
  %prwaitbar(0);
end
prwaitbar(0);
	
