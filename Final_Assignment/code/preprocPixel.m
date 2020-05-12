function pixelOut = preprocPixel( images_set )

    data_size = size(images_set);
    for i=1:data_size(1)
        im = data2im(images_set(i));
        %erode and dilate procedure
        se = strel('disk',1);
        im = imclose(im, se);
        im = imerode(im, se);
        im = imdilate(im, se);
        %correct slant
        im = im_box(im,[10,10,10,1]);
        moments = im_moments(im,'central');
        alpha = atan(2*moments(3)/(moments(1)-moments(2)));
        tform = maketform('affine',[1 0 0; sin(0.5*pi-alpha) cos(0.5*pi-alpha) 0; 0 0 1]);
        im = imtransform(im,tform);
  
        out = im_box(im,1,1);
        im = im_resize(out, [30,30]);
        im_size = size(im);
        if (i~=1)
            proc_size = size(processed);
        else
            proc_size = [0 1];
        end
        processed(i,:) = im(:);
        %soooos an allaksw tis eikones ana klassh prepei na allaksei to 10
        labels{i} = strcat('digit_',num2str(ceil(i/10-1)));
    end
    pixelOut = prdataset(processed, labels');
end

