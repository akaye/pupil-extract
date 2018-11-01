function [pupil_radius,mousemovie]=extract_pupil(current_movie_filename,min_radius,max_radius) 

% takes a filename, minimum and maximum radius in pixels
% outputs a vector of pupil_radius and 
% some aspects of this code are likely optimized for the way I record the
% movies - in small frames of 320x480 pixels, the lighting conditions, etc

radius_step=0.5; %pixels

try
        tempobj = VideoReader(current_movie_filename);
        % disp('opening')
        [xBound,yBound]=bounding_box_for_eye(movie_filename);
        mousemovie=uint8(zeros(tempobj.Height,tempobj.Width,tempobj.NumberOfFrames));
        num_frames=tempobj.NumberOfFrames;

        
   
        parfor kk=1:num_frames
 
                    temp=read(tempobj,kk);
   
                    cropped_frame=temp(yBound(1):yBound(2),xBound(1):xBound(2));
                    center_point=[(xBound(2)-xBound(1))/2 (yBound(2)-yBound(1))/2];
                    [pupil_image_bw]=return_pupil_segmentation(cropped_frame,0,1);
                    pupil_image_bw=imerode(pupil_image_bw,ones(7));
                    [pupil_region_mask,mask_stats]=choose_central_region(pupil_image_bw,center_point);
                    pupil_region_mask=imdilate(pupil_region_mask,ones(7));
                    radiuses = [min_radius:radius_step:max_radius];

                    h = circle_hough((pupil_region_mask), radiuses,'same');
                    [~,maxIndex] = max(h(:));
                    [iii,j,k] = ind2sub(size(h), maxIndex);
                    
                    pupil_radius_cell{kk} = radiuses(k); 
                    mousemovie_cell{kk} = temp;
        end
    

        for frame_iter=1:length(pupil_radius_cell)
            pupil_radius(frame_iter)=pupil_radius_cell{frame_iter};
            mousemovie(:,:,frame_iter)=mousemovie_cell{frame_iter};
        end
        clear pupil_radius_cell
        clear mousemovie_cell



        clear tempobj temp;
        cd(save_dir)
        save(current_mat_filename)
     catch ME
         'failed'
         disp(ME)
         oft_files(i).name
         failed_files=[failed_files i]
         failed_message=[failed_message i]
end
end