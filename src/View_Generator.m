function View_Generator(inpath,outpath,LF_parameters,ext)



% inpath ����ͼ���·��
% outpath����·��
% ext �����ļ��ĸ�ʽ

% Img=imread('LF_Remap.jpg');
% mkdir('input_vincent\Mat');


tic
Img=imread(inpath);
mkdir([outpath,'\',ext]);

x_size             = LF_parameters.x_size                 ;
y_size             = LF_parameters.y_size                 ;
data=zeros(y_size,x_size,3);
windowside=LF_parameters.UV_diameter;

for i = 1:LF_parameters.UV_diameter
    for j = 1:LF_parameters.UV_diameter       
%         view_num=j+(i-1)*LF_parameters.UV_diameter;%�Դ��ڱ��
        for x=1:LF_parameters.x_size%row     
            for y=1:LF_parameters.y_size%col                       
                
                xx=i+(x-1)*windowside;  
                yy=j+(y-1)*windowside;   
                data(y,x,:)=Img(yy,xx,:);    
            end
        end
        
        filename=[outpath,'\',ext,'\view_' num2str(j),'_',num2str(i), '.',ext];% 
       % 
		if strcmp(ext,'mat') 
            save(filename,'data') 
        else
           imwrite(mat2gray(data),filename,ext);% 
        end
    
    end
end

fprintf('View_Generator Done in %.3f seconds!\n',toc);





