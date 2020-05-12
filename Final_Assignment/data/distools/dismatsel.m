%DISMATSEL Forward selection and combination of dissimilarity datasets
%
%		[D,L,E] = DISMATSEL(C)
%
% C is a cell array of labeled datasets being square dissimilarity
% matrices. In a forward selection the best of them according to the
% leave-one-out nearest neighbor error (NNE) are selected and summed. 
% L contains the ranked set of indices of selected matrices. E stores the
% error and D is the sum of the best subset.
%
% SEE ALSO
% DATASETS, NNE

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [d_final,L,E] = dismatsel(c,nmax)

if ~iscell(c) | ~isdataset(c{1})
	error('Cell array of dissimilarity matrices expected')
end

n = length(c);
if nargin < 2, nmax = n; end
for j=1:n
	c{j} = abs(c{j});
	c{j} = setfeatlab(c{j},getlabels(c{j}));
	c{j} = c{j}*disnorm(c{j});
end
L = zeros(1,nmax);
J = [1:n];
E = zeros(1,nmax);
d = zeros(size(c{1}));
emin_total = 1;
for j=1:nmax
	emin = 1;
	for i=J
		e = nne(c{i}+d);
		if e < emin
			L(j) = i;
			emin = e;
		end
	end
	d = c{L(j)}+d;
	if nargin < 2 % do not allow multiple choices
		J(J==L(j)) = [];
	end
	E(j) = emin;
	if emin < emin_total
		emin_total = emin;
		d_final = d;
	end
end

		





