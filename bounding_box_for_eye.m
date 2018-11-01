function [xBound,yBound]=bounding_box_for_eye(movie_filename)
     tempobj = VideoReader(movie_filename);
     disp('opening')
     example_frame=read(tempobj,100);
     imagesc(example_frame,[0 80]);
     axis off
     colormap(gray);
     title('Draw a rectangle around the eye with pupil at center')
     rect = getrect;
     xBound = round([rect(1) rect(1)+rect(3)]); 
     yBound = round([rect(2) rect(2)+rect(4)]);
end