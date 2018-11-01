function [fgm]=return_pupil_segmentation(I,should_we_show_figure,bright_pupil)
cropped_frame=I;
  texture_cropped=imfill(entropyfilt(cropped_frame));
        texture_gradient=imgradient(texture_cropped,'prewitt');
        invert_texture_gradient=imcomplement(texture_gradient);
        fgm=im2bw(invert_texture_gradient);
% hy = fspecial('sobel');
% hx = hy';
% Iy = imfilter(double(I), hy, 'replicate');
% Ix = imfilter(double(I), hx, 'replicate');
% gradmag = sqrt(Ix.^2 + Iy.^2);
% 
% L = watershed(gradmag);
% Lrgb = label2rgb(L);
% 
% se = strel('disk', 20);
% Io = imopen(I, se);
% % figure
% % imshow(Io), title('Opening (Io)')
% 
% Ie = imerode(I, se);
% Iobr = imreconstruct(Ie, I);
% % figure
% % imshow(Iobr), title('Opening-by-reconstruction (Iobr)')
% 
% Iobrd = imdilate(Iobr, se);
% Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
% 
%if (nargin==3 && bright_pupil==1)
%     Iobrcbr = imcomplement(Iobrcbr);
% end
% 
% fgm = imregionalmax(Iobrcbr);

if should_we_show_figure==1
    figure
    imshow(invert_texture_gradient), title('Regional maxima of opening-closing by reconstruction (fgm)')
end