

function b = my_features(a,features)

	 
if nargin < 2  features = []; end

if nargin < 1 | isempty(a)
   b = prmapping(mfilename,'fixed',{features});
   b = setname(b,'My features');
elseif isa(a,'prdataset')
   out = zeros(size(a,1),1);
   % Run over all images, and compute the features:
   for n = 1:size(a,1)
     out(n,1) = holes(data2im(a,n));
   end 
   % store in a dataset:
   %b = prdataset(out,getlabels(a));
   b = prdataset(out);
   b = setlablist(b,getlablist(a));
   b = setnlab(b,getnlab(a));
   b = setfeatlab(b,featlab);
   b = setprior(b,getprior(a,0));
   b = setname(b,getname(a));

end
	
return


%function f = holes()
%
%thr = min(im(:)) + (max(im(:))-min(im(:)))/2;
%r = regionprops((im>thr),gray,props);
%f = [];
%for i=1:length(props)
%   f = [f getfield(r,props{i})];
%end

