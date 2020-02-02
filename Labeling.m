%%
% hdf [row, col, ...]
h5create('Tool.h5','/image',[1080 1920 3 inf],'ChunkSize',[120 120 3 10]);
h5create('Tool.h5','/pts',[5 2 inf],'ChunkSize',[5 2 10]);

%%
clear all
clc
v = VideoReader('VideoForLandmark2.mp4');
numberPoints = 5;

disp('Total Frame')
TotalFrames = v.Duration * v.Framerate;
disp(TotalFrames)

%%
n_data = 1;
for f = 1:10:TotalFrames 
    Current_image = read(v,f);
    %%
    imshow(Current_image)
    %%
    n = 0;
    for i = 1 : numberPoints
        [x, y, button] = ginput(1);
        n = n + 1;
        coordinates(i,1) = x;
        coordinates(i,2) = y;
        hold on
        plot(x(1),y(1),'wo','linewidth',3)
        drawnow
    end
    h5write('Tool.h5','/image',Current_image,[1 1 1 n_data],[1080 1920 3 1])
    h5write('Tool.h5','/pts',coordinates,[1 1 n_data],[5 2 1])
    n_data = n_data + 1;
end