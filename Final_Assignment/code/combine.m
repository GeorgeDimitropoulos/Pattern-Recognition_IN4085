%%%%%Feature selection code %%%%%%%%%%%%%
%%%Stacked combining%%%

images_set = prnist([0:9],[1:100:1000]);
processed = preprocPixel(images_set);

pc_parzen = pcam(processed,15);
pc_knn = pcam(processed,15);

w_parzen = pc_parzen*parzenc([],0.25);
w_knn3 = pc_knn*knnc([],3);

W = [w_parzen w_knn3];

Cmax = W*maxc;            % max combiner
Cmin = W*minc;            % min combiner
Cmean = W*meanc;          % mean combiner
Cprod = W*prodc;          % product combiner

[err,std]=prcrossval(processed,{Cmax,Cmin,Cmean,Cprod}, 5, 10)