%ISEMPTY Dataset overload
%
%	I = ISEMPTY(A,FIELD)
%
% INPUT
%  A     Dataset
%  FIELD Dataset field, default 'data'
%
% OUTPUT
%  I     Flag, 1 if field is empty, 0 otherwise. 
%
% DESCRIPTION
% Dataset overload for ISEMPTY. This is particulary useful for
% ISEMPTY(A) to test on an empty dataset, and
% ISEMPTY(A,'prior') to test on an undefined PRIOR field
%
% SEE ALSO (<a href="http://37steps.com/prtools">PRTools Guide</a>)
% PRDATASET, SETPRIOR, GETPRIOR

% $Id: isempty.m,v 1.6 2009/02/19 12:31:52 duin Exp $

function i = isempty(a,field)
		
	if nargin < 2
		%i = (isempty(a.objsize)) | (prod(a.objsize) == 0);
    %RD a dataset with zero objects is not empty, it has just 0 objects
		i = (isempty(a.objsize));
	else
		i = isempty(a.(field));
	end

return
