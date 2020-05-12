images_set = prnist([0:9],[1:100:1000]);

images_set = im_box(images_set,0,1);

% Resize the images
images_set = im_resize(images_set,[30 30]);
%a = images_set*datasetm;
a = prdataset(images_set);
d = a*proxm(a);
%w = d*pe_em;
%x = d*w;

[trn tst] = gendat(d,0.5);

% Split the dataset to training and test set
 %= gendat(processed, 0.5);

% Hide PRTools warning
prwarning off;

% Extract the new features by using PCA
[pmap frac] = pcam(trn, 50);
differentClassifiers = {'nmc', 'ldc', 'qdc', 'fisherc', 'loglc','knnc', 'parzenc'};

% Generate feature curves
for i=1:length(differentClassifiers)
 %differentClassifiers(i)
 fc1 = clevalf(trn*pmap, nmc, [5:5:50], [], 1, tst*pmap); figure(1); plote(fc1);
 fc2 = clevalf(trn*pmap, ldc, [5:5:50], [], 1, tst*pmap); figure(2); plote(fc2);
 fc3 = clevalf(trn*pmap, qdc, [5:5:50], [], 1, tst*pmap); figure(3); plote(fc3);
 fc4 = clevalf(trn*pmap, fisherc, [5:5:50], [], 1, tst*pmap); figure(4); plote(fc4);
 fc5 = clevalf(trn*pmap, loglc, [5:5:50], [], 1, tst*pmap); figure(5); plote(fc5);
 fc6 = clevalf(trn*pmap, knnc([],1), [5:5:50], [], 1, tst*pmap); figure(6); plote(fc6);
 fc7 = clevalf(trn*pmap, knnc([],3), [5:5:50], [], 1, tst*pmap); figure(7); plote(fc7);
 fc8 = clevalf(trn*pmap, parzenc, [5:5:50], [], 1, tst*pmap); figure(8); plote(fc8);
 
 showfigs;
end

%Evaluation of features by the criterion CRIT, using objects in the  dataset A. The larger J, the better. 
feateval(trn*pmap, 'maha-m'); % 0
feateval(trn*pmap, 'maha-s'); % 1.7907e+17
feateval(trn*pmap, 'eucl-m'); % 57.0723
feateval(trn*pmap, 'eucl-s'); % 5.0274e+03
feateval(trn*pmap, 'in-in'); % 8.2486e+17
feateval(trn*pmap, 'NN'); % 0.6





