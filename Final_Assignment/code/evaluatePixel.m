images_set = prnist([0:9],[1:100:1000]);

processed = preprocPixel(images_set);

% Split the preprocessed dataset half of it for training and half for
% testing
[trn tst] = gendat(processed, 0.5);

% Hide PRTools warning
prwarning off;

% Extract the new features by using PCA
[pmap frac] = pcam(trn, 50);
%The classifiers that we will test
differentClassifiers = {'knnc', 'knnc', 'knnc', 'nmc', 'ldc', 'qdc', 'fisherc', 'loglc', 'parzenc'};

% Generate feature curves for every classifier
for i=1:length(differentClassifiers)
    classifierHandler = str2func(differentClassifiers{i});
    if strcmp(func2str(classifierHandler), 'knnc') == 1
        fc = clevalf(trn*pmap, classifierHandler([], i), [5:5:50], [], 1, tst*pmap); figure(i); plote(fc);
    else
        fc = clevalf(trn*pmap, classifierHandler(), [5:5:50], [], 1, tst*pmap); figure(i); plote(fc);
    end

    showfigs;
end

%Evaluation of features by the criterion CRIT, using objects in our dataset. The larger the maxDist the better. 
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

% feature selection using maxDistance measure
[fs r] = featself(trn*pmap, maxDistName, 30);

%test the classifiers for the training set after the feature selection
%HOLD OUT error calculation
for i=1:length(differentClassifiers)
    classifierHandler = str2func(differentClassifiers{i});
    if strcmp(func2str(classifierHandler), 'knnc') == 1
        cls = classifierHandler(trn*pmap*fs, i);
    else
        cls = classifierHandler(trn*pmap*fs);
    end
    
    ho(i) = testc(tst*pmap*fs*cls);
end

% Estimate the error by using 5-fold cross-validation
crossVal5 = crossVal( processed, 5, 10, 'maha-s', 50, 20 );

% Estimate the error by using 10-fold cross-validation
crossVal10 = crossVal( processed, 10, 10, 'maha-s', 50, 20 );

