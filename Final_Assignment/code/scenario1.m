images_set = prnist([0:9],[1:200:1000]);

processed = preprocPixel(images_set);

% Split the dataset to training and test set
[trn tst] = gendat(processed, 0.5);

% Hide PRTools warning
prwarning off;

% Extract the new features by using PCA
[pmap frac] = pcam(trn, 50);

differentClassifiers = {'knnc', 'knnc', 'knnc', 'nmc', 'ldc', 'qdc', 'fisherc', 'loglc', 'parzenc'};

% Generate feature curves
for i=1:length(differentClassifiers)
    classifierHandler = str2func(differentClassifiers{i});
    if strcmp(func2str(classifierHandler), 'knnc') == 1
        fc = clevalf(trn*pmap, classifierHandler([], i), [5:5:50], [], 1, tst*pmap); figure(1); plote(fc);
    else
        fc = clevalf(trn*pmap, classifierHandler(), [5:5:50], [], 1, tst*pmap); figure(1); plote(fc);
    end

showfigs;
end

%Evaluation of features by the criterion CRIT, using objects in the  dataset A. The larger J, the better. 
possibleDistances = {'maha-m', 'maha-s', 'eucl-m', 'eucl-s', 'NN'}

maxDist = 0;
maxDistName = '';
for i=1:length(possibleDistances)
    possibleDistances(i)
    feateval(trn*pmap, possibleDistances{i})
    if (maxDist < feateval(trn*pmap, possibleDistances{i}))
        maxDist = feateval(trn*pmap, possibleDistances{i})
        maxDistName = possibleDistances{i}
    end
end


%----------------------------- feature selection --------------------------
[fs r] = featself(trn*pmap, maxDistName, 15);

for i=1:length(differentClassifiers)
    classifierHandler = str2func(differentClassifiers{i});
    if strcmp(func2str(classifierHandler), 'knnc') == 1
        cls = classifierHandler(trn*pmap*fs, i);
    else
        cls = classifierHandler(trn*pmap*fs);
    end
    
    hoerr(i) = testc(tst*pmap*fs*cls);
end


% Estimate the error by using 5-fold cross-validation
subset = gendat(processed, 0.4);
[ftrn ftst] = gendat(subset, 0.5);
% size(ftrn);
% size(ftst);
[fpmap ffrac] = pcam(ftrn, 50);
%[fpmap ffrac] = pcam(ftrn, 20);

[fs r] = featself(ftrn*fpmap, 'maha-s', 15);

%Number of repetitions = 10
[ferr1,std1] = prcrossval(subset*fpmap*fs, nmc, 5, 10);
[ferr2,std2] = prcrossval(subset*fpmap*fs, ldc, 5, 10);
[ferr3,std3] = prcrossval(subset*fpmap*fs, qdc, 5, 10);
[ferr4,std4] = prcrossval(subset*fpmap*fs, fisherc, 5, 10);
[ferr5,std5] = prcrossval(subset*fpmap*fs, loglc, 5, 10);
[ferr6,std6] = prcrossval(subset*fpmap*fs, knnc([], 1), 5, 10);
[ferr7,std7] = prcrossval(subset*fpmap*fs, knnc([], 3), 5, 10);
[ferr8,std8] = prcrossval(subset*fpmap*fs, parzenc, 5, 10);



% Estimate the error by using 10-fold cross-validation
subset = gendat(processed, 0.4);
[ftrn ftst] = gendat(subset, 0.5);
% size(ftrn);
% size(ftst);
[fpmap ffrac] = pcam(ftrn, 50);
%[fpmap ffrac] = pcam(ftrn, 20);

[fs r] = featself(ftrn*fpmap, 'maha-s', 15);

%Number of repetitions = 10
[ferr1,std1] = prcrossval(subset*fpmap*fs, nmc, 10, 10);
[ferr2,std2] = prcrossval(subset*fpmap*fs, ldc, 10, 10);
[ferr3,std3] = prcrossval(subset*fpmap*fs, qdc, 10, 10);
[ferr4,std4] = prcrossval(subset*fpmap*fs, fisherc, 10, 10);
[ferr5,std5] = prcrossval(subset*fpmap*fs, loglc, 10, 10);
[ferr6,std6] = prcrossval(subset*fpmap*fs, knnc([], 1), 10, 10);
[ferr7,std7] = prcrossval(subset*fpmap*fs, knnc([], 3), 10, 10);
[ferr8,std8] = prcrossval(subset*fpmap*fs, parzenc, 10, 10);
