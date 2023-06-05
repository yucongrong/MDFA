function [] = extract_feature(dataset_name,pool5_dir,pool5QUERY_dir,image_dir,vgg)

 if  strcmpi(vgg,'16')
  net = vgg16;   
 else
  net = vgg19;
 end
eval(['load gnd_' dataset_name '.mat']);
% Extract the features of dataset
datasetPath = image_dir;

if  strcmpi(dataset_name,'holidays')
    s=0.5; %Image scaling factor
else
    s=1;
end

for i=1:length(datasetPath)
    imgPath = [datasetPath(i).folder,'\',datasetPath(i).name];
    im = imread(imgPath);
    this_img = single(im);
   
    this_img = imresize(this_img,s);

%     [h,w,~]=size(this_img);
    if size(this_img,1)<224
        t2 = size(this_img,2);
        this_img = imresize(this_img,[224,t2]);
    end
    if size(this_img,2)<224
        t1 = size(this_img,1);
        this_img = imresize(this_img,[t1,224]);
    end
    pool5 = activations(net,this_img,'pool5','OutputAs','channels',"ExecutionEnvironment","cpu");
    

    parsave([pool5_dir(1).folder,'\',erase(datasetPath(i).name,'.jpg'),'.mat'],pool5); 
    if mod(i,100) == 0 
        i
    end
end



%Extract the features of queryset


query_num=size(q_name,1);
ph_path=image_dir;


for j=1:query_num
  
        query = ph_path(j).folder+"\"+q_name(j)+'.jpg';
        x = gnd(j).bbx(1);
        y = gnd(j).bbx(2);
        w = gnd(j).bbx(3);
        h = gnd(j).bbx(4);
        rect = [x y x+w y+h];
        this_img = imread(query);
        this_img = imcrop(this_img, rect);
        if size(this_img,1)<224
            t2 = size(this_img,2);
            this_img = imresize(this_img,[224,t2]);
        end
        if size(this_img,2)<224
            t1 = size(this_img,1);
            this_img = imresize(this_img,[t1,224]);
        end
        pool5 = activations(net,this_img,'pool5','OutputAs','channels',"ExecutionEnvironment","cpu");
      
        parsave([pool5QUERY_dir(1).folder,'\',cell2mat(q_name(j)),'.mat'],pool5);
      
  
end

end
