% Define the number of iterations
iterations = 100;

% Define the size of the image
img_size = [512 512];

% Initialize the image with zeros
img = zeros(img_size);

% Define the fractal function
fractal_func = @(z) z^2 + 0.36 + 0.1i;

% Define the starting point
z0 = -2 + 2i;

% Loop over all the pixels in the image
for x = 1:img_size(1)
    for y = 1:img_size(2)
        z = z0 + (x + y*1i)/img_size(1)*4;
        for i = 1:iterations
            z = fractal_func(z);
            if abs(z) > 2
                img(x, y) = i;
                break;
            end
        end
    end
end

% Plot the image
imagesc(img);
colormap(jet(iterations));
axis equal;
axis off;

% User input to allow the user to specify the number of iterations,
% size of the image, and the fractal function
prompt = {'Number of iterations:', 'Size of image (in pixels):', 'Fractal function:'};
defaults = {num2str(iterations), num2str(img_size), func2str(fractal_func)};
inputs = inputdlg(prompt, 'Fractal Generator', 1, defaults);
if ~isempty(inputs)
    iterations = str2double(inputs{1});
    img_size = str2num(inputs{2});
    fractal_func = str2func(inputs{3});
end

% Save the generated image to a file
[file, path] = uiputfile({'*.png', 'PNG Image (*.png)'; '*.jpg', 'JPEG Image (*.jpg)'; '*.bmp', 'Bitmap Image (*.bmp)'}, 'Save Fractal Image');
if file ~= 0
    imwrite(img, [path, file]);
end

% Generate an animation of the fractal by changing the fractal function or the number of iterations over time
frames = 100;
for i = 1:frames
    fractal_func = @(z) z^2 + (i/frames)*0.36 + (i/frames)*0.1i;
    iterations = 100 + (i/frames)*100;
    img = zeros(img_size);
    for x = 1:img_size(1)
        for y = 1:img_size(2)
            z = z0 + (x + y*1i)/img_size(1)*4;
            for j = 1:iterations
                z = fractal_func(z);
                if abs(z) > 2
                    img(x, y) = j;
                    break;
                end
            end
        end
    end
    imagesc(img);
    colormap(jet(iterations));
    axis equal;
    axis off;
    pause(0.01);
end

% Add a zoom feature to allow the user to zoom in
zoom_factor = 1;
while true
    img = zeros(img_size);
    z0 = z0 + (1/zoom_factor)*(-0.5 + 0.5i);
    for x = 1:img_size(1)
        for y = 1:img_size(2)
            z = z0 + (x + y*1i)/(img_size(1)/zoom_factor);
            for i = 1:iterations
                z = fractal_func(z);
                if abs(z) > 2
                    img(x, y) = i;
                    break;
                end
            end
        end
    end
    imagesc(img);
    colormap(jet(iterations));
    axis equal;
    axis off;
    zoom_factor = zoom_factor*1.1;
    pause(0.01);
end

    % Add color maps to the image
    colormap(jet(iterations));
    imagesc(img);
    axis equal;
    axis off;
    
    % Save the frame to disk
    frame_filename = sprintf('fractal_frame_%03d.png', frame);
    imwrite(img, frame_filename);
    
    % Pause for the specified delay
    pause(frame_delay);
    
    % Update the fractal function or number of iterations for the next frame
    iterations = iterations + 5;
end
