
clear;
data = single(zeros(1577,1580,25));
max_files= 1000;
fnames = cell(1,max_files);
fid=fopen('file_name.txt','r');
i = 1;
tline = fgets(fid);
while tline ~= -1
    fnames{i} = tline(1:(end-2));%remove new line character
    i = i+1;
    tline = fgets(fid);
end


fclose(fid);


m=5;%Columns
n=5;%Rows

imsize_y = 660;imsize_x = 660; % X,Y scale in each reconstructions

sequence_input_offset_index = 2+25;
data= cell(1, m*n);
for i = sequence_input_offset_index: 1 :sequence_input_offset_index+1*m*n-1
    I = h5read(fnames{i},'/entry_1/process_1/output_1/object_phase');
    fnames{i}
    % including 1577*1580 & 1577*1581, how to optimise it? for me I simply
    % round it to 1577*1580
    i
    data{i-sequence_input_offset_index+1} = I;
    % data = data(~cellfun(@isempty, data));
end
Startindex = fnames{sequence_input_offset_index}
Pixal_Size = 94e-9; %Pixal size = 94 n=

%% Add Overlop
% Is there an exact value?
Overlap_Y = 127;
Overlap_X = 127;



stittch_I1=zeros(imsize_y*m -(m-1)*Overlap_Y,imsize_x*n -(n-1)*Overlap_X);

for j = 1:m   
    for i = 1:1:n

        img=cell2mat(data(1,(j-1)*n+i));

        stittch_I1((j-1)*(imsize_y-Overlap_Y)+1:j*(imsize_y-Overlap_Y)+Overlap_Y,(i-1)*(imsize_x-Overlap_X)+1:i*(imsize_x-Overlap_X)+Overlap_X)=img(459:1118,461:1120);
    end
end


x = linspace(0,(n*660-(n-1)*Overlap_X-1)*Pixal_Size,n*660-(n-1)*Overlap_X);
y = linspace(0,(m*660-(m-1)*Overlap_Y-1)*Pixal_Size,m*660-(m-1)*Overlap_Y);
[X,Y] = ndgrid(x,y);

I_359694=stittch_I1;
imagesc(y,x,stittch_I1);
% caxis([0,0.15]);
axis equal;
colormap gray



% 
% 
% 
% 
% 
% % data = single(zeros(1577,1580,25));
% % max_files= 1000;
% % fnames = cell(1,max_files);
% % fid=fopen('file_names.txt','r');
% % i = 1;
% % tline = fgets(fid);
% % while tline ~= -1
% %     fnames{i} = tline(1:(end-2));%remove new line character
% %     i = i+1;
% %     tline = fgets(fid);
% % end
% % 
% % 
% % fclose(fid);
% % m=7;n=7; %2D scan steps, m*n is the same of Ptychography numbers
% % imsize_y = 639;imsize_x = 639; % X,Y scale in each reconstructions
% % data= cell(1, m*n);
% % for i = 1:m*n
% %     I = h5read(fnames{m*n-i+1},'/entry_1/process_1/output_1/object_phase');
% % 
% %     % including 1577*1580 & 1577*1581, how to optimise it? for me I simply
% %     % round it to 1577*1580
% % 
% %     data{i} = I;
% % end
% % 
% % 
% % Pixal_Size = 95e-9; %Pixal size = 95 nm
% % 
% % %% Add Overlop
% % % Is there an exact value?
% % Overlap_Y = 127;
% % Overlap_X = 127;
% % 
% % % stittch_I1=[data(:,:,1),data(:,Overlap_X:639,2),data(:,Overlap_X:639,3),data(:,Overlap_X:639,4),data(:,Overlap_X:639,5)];
% % stittch_I1=zeros(imsize_y*m -(m-1)*Overlap_Y,imsize_x*n -(n-1)*Overlap_X);
% % for j = 1:m   
% %     for i = 1:n
% % 
% %         img=cell2mat(data(1,3*j+i-3));
% % 
% 
% %         stittch_I1((j-1)*(imsize_y-Overlap_Y)+1:j*(imsize_y-Overlap_Y)+Overlap_Y,(i-1)*(imsize_x-Overlap_X)+1:i*(imsize_x-Overlap_X)+Overlap_X)=img(469:1107,471:1109);
% %     end
% % end
% % 
% % %It looks need optimization
% % %X = linspace()
% % x = linspace(0,(n*639-(n-1)*Overlap_X-1)*Pixal_Size,n*639-(n-1)*Overlap_X);
% % y = linspace(0,(m*639-(m-1)*Overlap_Y-1)*Pixal_Size,m*639-(m-1)*Overlap_Y);
% % [X,Y] = ndgrid(x,y);
% % 
% % 
% % imagesc(y,x,stittch_I1);
% % caxis([0,0.15]);
% % axis equal;title("500 nm  Mouse Retina-359533-359547")
% % 
% % 
% % 
