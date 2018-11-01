function [pupil_region_mask,mask_stats]=choose_central_region(pupil_image_bw,center_point)
region_st=regionprops(pupil_image_bw,'Centroid','Eccentricity','EquivDiameter','PixelList');
%crude heuristic

for k=1:length(region_st)
    region_dist_center(k)=sqrt(sum((region_st(k).Centroid-center_point).^2));
    %region_eccentricity(k)=region_st(k).Eccentricity;
    if length(region_st(k).PixelList)<300
        region_dist_center(k)=Inf;
    end
end
%region_index

[dist_from_center,region_index]=min(region_dist_center);
mask_stats=region_st(region_index);

pixels_in_pupil=region_st(region_index).PixelList;
pupil_region_mask=zeros(size(pupil_image_bw));
for j=1:length(pixels_in_pupil)
    pupil_region_mask(pixels_in_pupil(j,2),pixels_in_pupil(j,1))=255;
end