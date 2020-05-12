%PE_LIBSVC LIBSVC for PE spaces
%
%    W = PE_LIBSVC(A,C)
%  
% INPUT
%   A	      Pseudo-Euclidean Dataset
%   C       Trade_off parameter in the support vector classifier.
%           Default C = 1;
%  
% OUTPUT
%   W       Mapping: Support Vector Classifier
%   J       Object idences of support objects. Can be also obtained as W{4}
%
% DESCRIPTION  
% Computation of the linear LIBSVC classifier for the Pseudo-Euclidean 
% dataset A.  Note that testsets should be defined in the same PE space 
% as A.
%
% Warning: class prior probabilities in A are neglected.
%
% EXAMPLE
% trainset = gendatm;
% testset = gendatm;
% Dtrain = trainset*proxm(trainset,'m',1);
% Dtest  = testset*proxm(testset,'m',1);
% w = pe_em(Dtrain);
% Xtrain = Dtrain*w;
% Xtest = Dtest*w;
% v = pe_libsvc(Xtrain);
% Xtest*v*testc
%
% SEE ALSO
% MAPPINGS, DATASETS, KNNC, PE_EM

% R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function w = pe_libsvc(a,c)

  if nargin < 2, c = 1; end

	if nargin == 0 | isempty(a)
		w = prmapping(mfilename,'untrained',{c});
		w = setname(w,'PE LIBSVC');
		
	elseif ~ismapping(c) % training
		
		if ~ispe_dataset(a)
			prwarning(1,'Dataset is Euclidean')
			w = libsvc(a,[],c);
		else
			ktrain = pe_kernelm(a,a)
			v = libsvc(ktrain,0);
			w = prmapping(mfilename,'trained',{v,a},getlablist(a),size(a,2),getsize(a,3));
		end
		
	else % execution, testset is in a, trained mapping is in c
		
		w = getdata(c,1);
		trainset = getdata(c,2);
		ktest = pe_kernelm(a,trainset);
		w = ktest*w;
    
  end
		
return