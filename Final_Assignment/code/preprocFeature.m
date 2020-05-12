function featureOut = preprocFeature(images_set)

    % Add rows/columns around the images
    images_set = im_box(images_set,0,1);

    % Resize the images
    images_set = im_resize(images_set,[30 30]);

	% Extract the features by using prtools function im_features
	features = im_features(images_set, images_set,{
		'Area', 
		'EulerNumber', 
		'Orientation', 
		'BoundingBox', 
		'Extent', 
		'Perimeter', 
		'Centroid', 
		'ConvexArea', 
		'FilledArea', 
		'Solidity', 
		'Eccentricity', 
		'MajorAxisLength', 
		'EquivDiameter', 
		'MinorAxisLength', 
		'WeightedCentroid'
	});

	featureOut = features;
end

