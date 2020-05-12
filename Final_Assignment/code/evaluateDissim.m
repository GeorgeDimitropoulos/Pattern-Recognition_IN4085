images_set = prnist([0:9],[1:100:1000]);

processed = preprocDissim(images_set);

[trn tst] = gendat(processed, 0.5);

% Hide PRTools warning
prwarning off;

differentClassifiers = {'nmc', 'ldc', 'qdc', 'fisherc', 'loglc','knnc', 'parzenc'};

% Generate feature curves for every classifier
for i=1:length(differentClassifiers)
    classifierHandler = str2func(differentClassifiers{i});
    if strcmp(func2str(classifierHandler), 'knnc') == 1
        fc = clevalf(trn, classifierHandler([], i), [5:5:50], [], 1, tst); figure(1); plote(fc);
    else
        fc = clevalf(trn, classifierHandler(), [5:5:50], [], 1, tst); figure(1); plote(fc);
    end

    showfigs;
end

%Evaluation of features by the criterion CRIT, using objects in our dataset. The larger the maxDist the better. 
possibleDistances = {'maha-m', 'maha-s', 'eucl-m', 'eucl-s', 'NN'}
maxDist = 0;
maxDistName = '';
for i=1:length(possibleDistances)
    possibleDistances(i)
    feateval(trn, possibleDistances{i})
    if (maxDist < feateval(trn, possibleDistances{i}))
        maxDist = feateval(trn, possibleDistances{i})
        maxDistName = possibleDistances{i}
    end
end

% feature selection using maxDistance measure
[fs r] = featself(trn, maxDistName, 30);

%test the classifiers for the training set after the feature selection
%HOLD OUT error calculation
for i=1:length(differentClassifiers)
    classifierHandler = str2func(differentClassifiers{i});
    if strcmp(func2str(classifierHandler), 'knnc') == 1
        cls = classifierHandler(trn*fs, i);
    else
        cls = classifierHandler(trn*fs);
    end
    
    ho(i) = testc(tst*fs*cls);
end

% Estimate the error by using 5-fold cross-validation
crossVal5 = crossVal( processed, 5, 10, 'maha-s', 0, 15 );
crossVal5

% Estimate the error by using 10-fold cross-validation
crossVal10 = crossVal( processed, 10, 10, 'maha-s', 0, 15 );
