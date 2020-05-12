function d = preprocDissim(images_set)

    images_set = im_box(images_set,0,1);

    images_set = im_resize(images_set,[30 30]);
    a = images_set*datasetm;
    %a = prdataset(images_set);
    d = a*proxm(a);

end

