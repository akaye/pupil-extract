Extract the time series of the pupillary radius using Matlab using the circular hough transform.

Run extract_pupil(filename_of_pupil_movie,minimum_radius,maximum_radius)
It will prompt you to draw a rectangle around the eye. Draw it so the pupil is in the center
It will segment the image using the gradient of texture in the image (entropy filter)
Then it will look for the circle that best fits the largest segment in the center of the rectangle
This has worked pretty well for me as a heuristic way of extracting the pupil. Let me know if it works for you. It works for both pupil being light or dark relative to surround, but will likely fail if there is any texture in the pupil.

Issues:

It runs very slow, primarily because of the circular hough transform being run on every image
I've just packaged it to be usable by other people - this version is untested and may have bugs.