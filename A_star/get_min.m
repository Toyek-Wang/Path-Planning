function index = get_min(open_list)
%返回开表中具有最小代价的那一个节点的索引
%   此处提供详细说明
[height,width]=size(open_list);
index=-1;
min_dis=1000000;
for i=1:height
    if open_list(i,5)+open_list(i,6)<min_dis
        index=i;
        min_dis=open_list(i,5)+open_list(i,6);
    end
end
end