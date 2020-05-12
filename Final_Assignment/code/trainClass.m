function classifier = trainClass(images_set)

    [pmap, frac] = pcam(images_set, 50);
    
    % Reduce the number of features to 30
	[fs, r] = featself(images_set*pmap, 'maha-s', 30);
    disp(size(images_set*pmap*fs));
	% Build the classifier by using qdc
	cls = parzenc(images_set*pmap*fs);
	classifier = pmap*fs*cls;
end

