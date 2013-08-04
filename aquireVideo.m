%% Simple setup to grab photos from the web-cam.

adaptorName = 'winvideo';
devInfo = imaqhwinfo(adaptorName,1);
vid = videoinput(adaptorName,1,'YUY2_640x480');
set(vid, 'SelectedSourceName', 'input1')
set(vid, 'FramesPerTrigger',30);
set(vid, 'ReturnedColorSpace','rgb');
src = getselectedsource(vid);
set(src,'WhiteBalanceMode','manual');
set(src,'BacklightCompensation','off');
set(src,'ExposureMode','manual');
pause;


start(vid);

data = getdata(vid);
stop(vid);
delete(vid);
imaqmontage(data);