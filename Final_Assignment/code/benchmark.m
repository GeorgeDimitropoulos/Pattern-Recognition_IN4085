images_set = prnist([0:9],[1:100:1000]);
processed = preprocPixel(images_set);
edw = trainClass(processed);
nist_eval('preprocPixel', edw)

images_set = prnist([0:9],[1:2:1000]);
processed = preprocFeature(images_set);
edw = trainClass(processed);
nist_eval('preprocFeature', edw)

images_set = prnist([0:9],[1:10:1000]);
processed = preprocDissim(images_set);
edw = trainClass(processed);
nist_eval('preprocDissim', edw)
