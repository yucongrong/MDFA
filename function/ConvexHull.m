function filter = ConvexHull(F)

imLabel = bwlabel(F);      % 对连通区域进行标记

stats = regionprops(imLabel,'Area');

[~,index]=sort([stats.Area],'descend');

if length(stats)<2

    bw=imLabel;

else

    bw=ismember(imLabel,index(1:1));

end

rownum = size(bw,1);

colnum = size(bw,2);

rows = [];

cols =[];

[row,col]=find(bw==0);

for i =1:size(row,1)

    up = bw(1:row(i),col(i):col(i));

    down = bw(row(i)+1:rownum,col(i):col(i));

    right = bw(row(i):row(i),col(i)+1:colnum);

    left = bw(row(i):row(i),1:col(i));

    if  sum(up)~=0 && sum(down)~=0 && sum(right)~=0 && sum(left)~=0

        rows = [rows,row(i)];

        cols = [cols,col(i)];

    end

end

for i =1:size(rows,2)

    bw(rows(i),cols(i)) =1;

end

filter = bw;

end