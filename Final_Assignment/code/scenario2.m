images_set = prnist([0:9],[1:10:1000]);

processed = preprocFeature(images_set);
% Split the dataset to training and test set
[trn tst] = gendat(processed, 0.5);

% Hide PRTools warning
prwarning off;

% Extract the new features by using PCA
[pmap frac] = pcam(trn, 20);


% Generate feature curves
fc1 = clevalf(trn*pmap, nmc, [2:2:20], [], 1, tst*pmap); figure(1); plote(fc1);
fc2 = clevalf(trn*pmap, ldc, [2:2:20], [], 1, tst*pmap); figure(2); plote(fc2);
fc3 = clevalf(trn*pmap, qdc, [2:2:20], [], 1, tst*pmap); figure(3); plote(fc3);
fc4 = clevalf(trn*pmap, fisherc, [2:2:20], [], 1, tst*pmap); figure(4); plote(fc4);
fc5 = clevalf(trn*pmap, loglc, [2:2:20], [], 1, tst*pmap); figure(5); plote(fc5);
fc6 = clevalf(trn*pmap, knnc([],1), [2:2:20], [], 1, tst*pmap); figure(6); plote(fc6);
fc7 = clevalf(trn*pmap, knnc([],3), [2:2:20], [], 1, tst*pmap); figure(7); plote(fc7);
fc8 = clevalf(trn*pmap, parzenc, [2:2:20], [], 1, tst*pmap); figure(8); plote(fc8);

showfigs;

feateval(trn*pmap, 'maha-m'); % 6.9315
feateval(trn*pmap, 'maha-s'); % 1.5384e+03
feateval(trn*pmap, 'eucl-m'); % 794.0437
feateval(trn*pmap, 'eucl-s'); % 2.0483e+06
feateval(trn*pmap, 'in-in'); % 17.0604
feateval(trn*pmap, 'NN'); % 0.5512

[fs r] = featself(trn*pmap, 'eucl-s', 15);

cls1 = nmc(trn*pmap*fs); hoerr1 = testc(tst*pmap*fs*cls1);
cls2 = ldc(trn*pmap*fs); hoerr2 = testc(tst*pmap*fs*cls2);
cls3 = qdc(trn*pmap*fs); hoerr3 = testc(tst*pmap*fs*cls3);
cls4 = fisherc(trn*pmap*fs); hoerr4 = testc(tst*pmap*fs*cls4);
cls5 = loglc(trn*pmap*fs); hoerr5 = testc(tst*pmap*fs*cls5);
cls6 = knnc(trn*pmap*fs, 1); hoerr6 = testc(tst*pmap*fs*cls6);
cls7 = knnc(trn*pmap*fs, 3); hoerr7 = testc(tst*pmap*fs*cls7);
cls8 = parzenc(trn*pmap*fs); hoerr8 = testc(tst*pmap*fs*cls8);
