%%所有子孔径图像存为LF.mat的5维光场数据

clear all;
close all;

Snum=9;
Tnum=9;
img_h=512;
img_w=512;
LF_h=Tnum*img_h;
LF_w=Snum*img_w;
LF=uint8(ones(Tnum,Snum,img_h,img_w,3));
[filename, pathname] = uigetfile('*.png', '请选择需要的图','MultiSelect','on');
RFfilepath=pathname;
addpath(genpath(RFfilepath));
ImageNum=size(filename,2);

for subaperture=1:ImageNum
    i=rem((subaperture-1),9)+1;
    j=(subaperture-i)/9+1;
    ImageName=char(filename(subaperture));
    I=imread(ImageName);
    LF(j,i,:,:,1:3) = I(:,:,1:3);  
end
save('LF.mat','LF');

im=[];
u=size(LF,1);
v=size(LF,2);
s=size(LF,3);
t=size(LF,4);

out_im=zeros(s*u,s*u,3);
out_im=uint8(out_im);

im=[];  

for k=1:3
    %load (sprintf('./dataRGB/im_d_%d_v_%d_Nline_%d_%d.mat',d,v,N_line,k),'im');
    im=LF(:,:,:,:,k);
    %im_max=max(max(max(max(im()))));
    %im=uint8(im/im_max*255);
    for i=1:s
        for j=1:t
            out_im((i-1)*u+1:i*u,(j-1)*u+1:j*v,k)=im(:,:,i,j);
        end
    end
end
imshow(out_im);
imwrite(out_im,'lf.bmp');
