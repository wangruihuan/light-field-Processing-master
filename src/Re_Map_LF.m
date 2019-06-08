function LF_ReMap=Re_Map_LF(LF)

u=size(LF,1);
v=size(LF,2);
s=size(LF,3);
t=size(LF,4);

LF_ReMap=zeros(s*u,s*u,3);
LF_ReMap=uint8(LF_ReMap);

im=[];  

for k=1:3
    %load (sprintf('./dataRGB/im_d_%d_v_%d_Nline_%d_%d.mat',d,v,N_line,k),'im');
    im=LF(:,:,:,:,k);
    im_max=max(max(max(max(im()))));
    im=uint8(im/im_max*255);
    for i=1:s
        for j=1:t
            LF_ReMap((i-1)*u+1:i*u,(j-1)*u+1:j*v,k)=im(:,:,i,j);
        end
    end
end
imshow(LF_ReMap);
imwrite(LF_ReMap,'input\lf.bmp');