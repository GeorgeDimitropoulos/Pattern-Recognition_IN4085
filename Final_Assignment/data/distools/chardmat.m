%CHARDMAT Characterization of a square, labeled dissimilarity matrix
%
%  [C,D_OUT] = CHARDMAT(D,Ntr,Nsubeucl)
%
% Characterizes a square (dis)similarity dataset D.
% D_OUT is the symmetric, normalized dissimilarity dataset D. If D is 
% a similarity dataset it is converted to dissimilarities first.
% The following fields are returned in the structure C.
% name       - dataset name as stored by PRTools or read command
% desc       - dataset description as stored by read command
% link       - web links as stored by read command
% ref        - references as stored by read command
% asym       - asymmetry, 2*|D-D'|./(|D|+|D'|)
% size       - number of objects
% classes    - number of classes
% clsizes    - vector with class sizes
% type       - 'dis' for dissimilarities, 'sim' for similarities
%
%         all following items are computed for a transformation
%         of D by MAKESYM and DISNORM (make average distance 1),
%         similarities are first transformed into dissimilarities
%         by d(i,j) = sqrt(d(i,j) + d(j,j) - d(i,j) - d(j,i))
%
% within_mean- average within class dissimilarity
% between_mean- average between class dissimilarity
% pe_mapping - Pseudo-Euclidean mapping as computed by PE_EM
% signature  - 2 component vector with # of positive and negative
%              eigenvalues obtained during the PE embedding
% eigenvalues- the eigenvalues obtained during the PE embedding, 
%              see PE_EM for their ranking
% nef         - Negative Eigen Fraction (sum of absolute negative
%               eigenvalues divided by sum of all absolute eigenvalues)
% ner         - Negative Eigen Ratio (- largest negative eigenvalue 
%               divided by largest positive eigenvalue)
% trineq      - fraction of triangle inequality violations
%
%         the following characteristics refer to a set of five spaces:
%         - Pseudo-Euclidean space based on a full embedding. Distances
%           in this space are identical to D.
%         - Associated space, the same vector spaces, but now treated as
%           an Euclidean space
%         - Positive space based on the positive eigenvalues only
%         - Negative space based on the negative eigenvalues only
%         - Corrected space based on an embedding of sqrt(D.^2+2*Lmin)
%           in which Lmin is the absolute values of the largest negative
%           eigenvalue. The result is a proper Euclidean space.
%
% loo_a       - leave-one-out nearest neighbor errors for all five 
%               embedded spaces
% loo_d       - leave-one-out nearest neighbor errors for the dissimilarity
%               spaces related to the above five embedded spaces
% lcurve_a    - nearest neighbor learning curves for the five embedded
%               spaces
% lcurve_a    - nearest neighbor learning curves for the five dissimilarity
%               spaces
% anames      - names of the five embedded spaces, useful for annotation
% dnames      - names of the five dissimilarity spaces
%
% Ntr (default 200) and Nsubeucl (default 50) control numbers of trials to
% estimate the fraction of triangle violations and the accuracy of the
% subeuclidean curves.


function [c,d] = chardmat(d,Ntr,Nsubeucl,makefigs)

	if nargin < 4, makefigs = 0; end
	if nargin < 3 | isempty(Nsubeucl), Nsubeucl = 50; end
	if nargin < 2 | isempty(Ntr), Ntr = 200; end

  isdataset(d);

  datname = getname(d);
  discheck(d,[],1);
  m = size(d,1);
  nclass = getsize(d,3);

  c.name = datname;
  c.desc = getuser(d,'desc');
  c.link = getuser(d,'link');
  c.ref = getuser(d,'ref');
  c.asym = asymmetry(d); 
  c.size = m;
  c.classes  = nclass;
  c.clsizes  = classsizes(d);
  
  if discheck(d);
    c.type = 'dis';
  else
    c.type = 'sim';
		d = dissimt(d,'sim2dis');
	end
	
  % we now have a dissimilarity matrix with positive distances
  
  d = makesym(d);  % make it symmetric now
	d = d*disnorm(d);
  
  uc = zeros(1,nclass);
  for j=1:c.classes
		nj = c.clsizes(j);
    dj = +selcdat(d,j);
    uc(j) = sum(dj(:))/(nj*(nj-1));
  end
  c.within_mean = uc*(c.clsizes'.^2-c.clsizes')/(sum(c.clsizes.^2) - m);

  ud = (m*(m-1) - uc*(c.clsizes'.^2-c.clsizes')) / (m*(m-1) - sum(c.clsizes.^2) + m);
  c.between_mean = ud;

  [nef,ner,w] = checkeucl(d);
  c.pe_mapping  = w;
  c.signature   = getsig(w);
  c.eigenvalues = getdata(w,'eval');
  c.nef      = nef;
  c.ner      = ner;
  c.trineq   = checktr(d,200);
  
  [A D] = disspaces(d,w);
  nspaces = length(A);
  c.loo_a = zeros(1,nspaces); % LOO NN errors embedding spaces
  c.loo_d = zeros(1,nspaces); % LOO NN errors dis spaces
  c.lcurve_a = cell(1,nspaces);  % NN Learning curves embedding spaces
  c.lcurve_d = cell(1,nspaces);  % NN Learning curves dis spaces
	c.anames = cell(1,nspaces);    % names embedded spaces
	c.dnames = cell(1,nspaces);    % names dis spaces
	t = sprintf('Compute %i learning curves: ',nspaces*2);
	prwaitbar(nspaces*2,t); 
  for j=1:nspaces   
    c.loo_a(j) = nne(D{j});
		ddj = distm(D{j});
    c.loo_d(j) = nne(ddj);
		prwaitbar(nspaces*2,j*2-1,[t int2str(j*2-1)]);
    c.lcurve_a{j} = nnerr(D{j});
    c.lcurve_a{j}.names = getname(A{j});
    c.anames{j} = getname(A{j});
		prwaitbar(nspaces*2,j*2,[t int2str(j*2)]);
    c.lcurve_d{j} = nnerr(ddj);
    c.lcurve_d{j}.names = getname(D{j});
    c.dnames{j} = getname(D{j});
	end
	prwaitbar(0);

	if makefigs
		make_figs(d,c);
	else
		show_figs(c,d,Nsubeucl)
	end
	
return

function show_figs(c,d,Nsubeucl)

	if nargin < 3 | isempty(Nsubeucl)
		Nsubeucl = 50;
	end

  fonts = 12;
  m = size(d,1);
  nclass = getsize(d,3);
  d
  delfigs
  
  figure; imagesc(+d);
  colormap gray
  axis off;
  axis square
  title('Dissimilarity Matrix');
  fontsize(fonts);
  
  figure; scatterd(d*c.pe_mapping(:,1:2));
  title('Scatterplot on first two positive eigenvectors')
  xlabel('Eigenvector 1');
  ylabel('Eigenvector 2');
  fontsize(fonts);
  
  figure; plotspectrum(c.eigenvalues); 
  fontsize(fonts);
	
  figure; plote([c.lcurve_a(1:4) c.lcurve_d(1)],[],char('k-','r-','b-','m-','k--'));
	V = axis; V(2)= m+1; axis(V);
	ticks = [1 10 100 1000];
	ticks = ticks(ticks <= m);
	set(gca,'xtick',ticks);
	set(gca,'xticklabel',ticks);
  fontsize(fonts);
  
  if isfield(c,'lcurve_d')
    figure; plote([c.lcurve_d(1:4) c.lcurve_a(1)],[],char('k--','r--','b--','m--','k-'));
    V = axis; V(2)= m+1; axis(V);
    ticks = [1 10 100 1000];
    ticks = ticks(ticks <= m);
    set(gca,'xtick',ticks);
    set(gca,'xticklabel',ticks);
    fontsize(fonts);
  end
	
  [nef,ner,N] = checkeucl(d,'all');
  figure;
	semilogx(N,nef); 
	linewidth(2); fontsize(fonts);
	V = axis; V(2)= m+1; axis(V);
	ticks = [1 10 100 1000];
	ticks = ticks(ticks <= m);
	set(gca,'xtick',ticks);
	set(gca,'xticklabel',ticks);
	xlabel('Subset size')
	ylabel('Fraction')
	title('Negative Eigen Fraction')
	
	figure; semilogx(N,ner);
	linewidth(2); fontsize(fonts);
	V = axis; V(2)= m+1; axis(V);
	ticks = [1 10 100 1000];
	ticks = ticks(ticks <= m);
	set(gca,'xtick',ticks);
	set(gca,'xticklabel',ticks);
	xlabel('Subset size')
	ylabel('Fraction')
	title('Negative Eigen Ratio')
	
  figure;
  nep = checksubeucl(d,Nsubeucl);
	n = min(find(nep==1));
	if isempty(n), n = 0; end
	plot(nep(1:n+1));
	linewidth(2); fontsize(fonts);
	xlabel('Subset size')
	ylabel('Fraction')
	title('Fraction of Non-Euclidean Subsets')
	
  figure;
  hist(+d(:),[0:0.05:ceil(max(+d(:)*20))/20]);
  dc = zeros(sum(c.clsizes.^2),1);
  n = 0;
  for j=1:nclass
    nn = c.clsizes(j)^2;
    dj = +selcdat(d,j);
    dc(n+1:n+nn) = dj(:);
    n = n+nn;
  end
  hold on
  hist(+dc(:),[0:0.05:ceil(max(+d(:)*20))/20]);
  h = get(gca,'Children');
  set(h(1),'facecolor',[1 0 0]);
  V = axis;
  axis([-0.1 max(+d(:)) 0 V(4)]);
  fontsize(fonts)
  legend('between class','within class');
  title('Histogram of normalized distances')
  
  showfigs
  
  
%FSAVE Save current figure as eps and fig
%
%    FSAVE <dir,fig_nane>

function fsave(datdir,file)

  file = fullfile(datdir,file);
  uns = get(gcf,'units');
  pos = get(gcf,'position');
  set(gcf,'units','pixels');
  set(gcf,'position',[1 1 900 600]);

  exportfig(gcf,file,'format','eps','preview','tiff','color','cmyk')
  %exportfig(gcf,file,'format','png','color','cmyk')
  %exportfig(gcf,file,'format','jpeg100','color','cmyk')
  saveas(gcf,file,'fig')

  set(gcf,'units',uns);
  set(gcf,'position',pos);

return

