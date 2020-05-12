function disOut = preprocDessimilarities( images_set )

    kati = images_set;
    % Add rows/columns around the images
    images_set = im_box(images_set,0,1);

    % Resize the images
    images_set = im_resize(images_set,[30 30]);
    
    a = images_set;
    d = a*proxm(a,'m',1);
    w = d*pe_em;
    x = d*w;
    [xt,xs] = gendat(x,0.5);
end

