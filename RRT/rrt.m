function path = rrt(map,start,goal,MAX_ite,step)
%RRT算法
[height,width]=size(map);

%初始化树
% step = 3;%设置生长步长为3
tree=[];
tree=[tree;-1,(start(2)-1) * width + start(1)];%首先把初始位置压入并作为根节点
path=[];%保存生成的间断路径，也就是只包含控制节点的路径

%开始生长
flag = 0;%标记是否找到了一条路径，或者换是不是到达目标位置
iteration = 0;
while iteration < MAX_ite
	iteration=iteration+1;
	%采样新节点
    ry=rand(1)*height;
    rx=rand(1)*width;
	new_point = floor((ry-1)*width+rx);%采样，采用栅格化地图，且按1-height*width顺序编号
	closest_point = get_closest_point(tree, new_point,height,width);%获得树中距离采样点最近的点
	
    theta = get_theta_of_vector(mod(tree(closest_point,2),width), floor(tree(closest_point,2)/width),...
        mod(new_point,width), floor(new_point/width));%计算方向
	%计算新节点
	x =floor(mod(tree(closest_point,2),width) + step * cos(theta));
	y = floor(tree(closest_point,2)/width+1 + step * sin(theta));
    if x<1||x>width||y<1||y>height
        continue;
    end
	%检查最近的点到新节点是不是安全，如果不安全则会进行下一轮采样
	if is_save(map, tree(closest_point,2), (y-1)*width+x,step)
		%安全，那么生长
		tree=[tree;closest_point,(y-1)*width+x];
    end
	%检查是否到达目标位置
    [row_tree,col_tree]=size(tree);
	if abs(mod(tree(row_tree,2),width)-goal(1))<5 && abs(tree(row_tree,2)/width-goal(2))<5
        tree=[tree;row_tree,(goal(2)-1)*width+goal(1)];
		flag = 1;
		break;
    end
end

%未找到可行路径，将会返回空路径
if flag == 0
	disp("failed to plan a path");
%     rrt(map,start,goal,MAX_ite,step);
%找到路径了
else
	%首先获得只包含控制节点的间断路径
    [row_tree,col_tree]=size(tree);
	path=[mod(tree(row_tree,2),width),tree(row_tree,2)/width-1;path];
	parent = tree(row_tree,1);
	while parent >= 0
		path=[mod(tree(parent,2),width),tree(parent,2)/width-1;path];
        parent = tree(parent,1);
    end
end
end


