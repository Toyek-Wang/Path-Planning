function point_arr = get_neighbor(point,height,width)
%返回一个节点的周围8个相邻节点，不管是不是障碍物，只管有没有超出地图边界
%   此处提供详细说明
point_arr=[];
if point(1)+1<=width
    point_arr=[point_arr;point(1)+1,point(2)];
end
if point(1)+1<=width&&point(2)+1<=height
    point_arr=[point_arr;point(1)+1,point(2)+1];
end
if point(2)+1<=height
    point_arr=[point_arr;point(1),point(2)+1];
end
if point(1)-1>0&&point(2)+1<=height
    point_arr=[point_arr;point(1)-1,point(2)+1];
end
if point(1)-1>0
    point_arr=[point_arr;point(1)-1,point(2)];
end
if point(1)-1>0&&point(2)-1>0
    point_arr=[point_arr;point(1)-1,point(2)-1];
end
if point(2)-1>0
    point_arr=[point_arr;point(1),point(2)-1];
end
if point(1)+1<=width&&point(2)-1>0
    point_arr=[point_arr;point(1)+1,point(2)-1];
end
end