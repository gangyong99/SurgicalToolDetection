close all
clear all
load('post_data1.mat')
length = size(label,1);
figure(); set(gcf,'units','normalized','outerposition',[0 0 1 1]);

for i = 1:length
    label_img = reshape(label(i,:,:),[128 128]);
    subplot(2,1,1)
    label_img = im2bw(label_img,0.5);
    label_img = bwareafilt(label_img, 2);
%     C = corner(label_img,'SensitivityFactor',0.2);
    imshow(label_img);
    line_detector(label_img);
    hold on
%     plot(C(:,1),C(:,2),'r*')
    subplot(2,1,2)
    imshow(uint8(reshape(img(i,:,:,:),[128 128 3])))
    drawnow
end

function lines = line_detector(img)
    max_len = 0;
    % Calculation
    [H,theta,rho] = hough(img);
    P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(img,theta,rho,P,'FillGap',5,'MinLength',7);

    % plot
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

       % Determine the endpoints of the longest line segment
       len = norm(lines(k).point1 - lines(k).point2);
       if ( len > max_len)
          max_len = len;
          xy_long = xy;
       end
    end
end