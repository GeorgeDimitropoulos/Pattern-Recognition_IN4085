filename = 'test2.png';
img = imread(filename);
img = rgb2gray(img);

numberOfClasses = 10;
numberOfObjects = 10;
stepx = size(img, 1)/numberOfClasses;
stepy = size(img, 2)/numberOfObjects;


prdpix = prdataset();
prdpix.name = 'livetest_pix';
count = 0;
for i=1:stepx:size(img, 1)
    for j=1:stepy:size(img, 2)
        count = count+1;
        numOfImage= count;
        imshow(img(i:i+stepx-1, j:j+stepy-1));
        im = im2bw(img(i:i+stepx-1, j:j+stepy-1),0.5);
        im = imcomplement(im);
        im = im_resize(im, [20 20]);
        labels{numOfImage} = strcat('digit_',num2str(ceil(i/stepx)-1));
        pixl = double(im(:)');
        result(numOfImage,:)=pixl(:);
        %prImage = prdataset(double(img(i:i+stepx-1, j:j+stepy-1)), strcat('digit_',num2str(ceil(i/stepx)-1)));
        %prdpix = [prdpix; prImage];
        
    end
end
result2=prdataset(result,labels');

images_set = prnist([0:9],[1:100:1000]);
processed = preprocPixel(images_set);
w = trainClass(processed);
[e,c] = testc(result2, w, 'error')
