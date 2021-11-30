function path = A_star(map,start,goal,eu_dis)
%A*算法实现，王晓腾2021/10/22
%曼哈顿距离 abs(point_succ(1)-goal(1))+abs(point_succ(2)-goal(2))
%          abs(start(1)-goal(1))+abs(start(2)-goal(2))
%欧氏距离
%       sqrt((point_succ(1)-goal(1))*(point_succ(1)-goal(1))+(point_succ(2)-goal(2))*(point_succ(2)-goal(2)))
%       sqrt((start(1)-goal(1))*(start(1)-goal(1))+abs(start(2)-goal(2))*abs(start(2)-goal(2)))

[height,width]=size(map);
open_list=[];%每一行要包含5个元素：父节点、X坐标、y坐标、g、h。这里h采用曼哈顿距离
close_list=[];

flag=0;

%将起始点压入开表
if eu_dis==1
    open_list=[open_list;-1,-1,start(1),start(2),0,sqrt((start(1)-goal(1))*(start(1)-goal(1))+abs(start(2)-goal(2))*abs(start(2)-goal(2)))];
else
    open_list=[open_list;-1,-1,start(1),start(2),0,abs(start(1)-goal(1))+abs(start(2)-goal(2))];
end
[row,col]=size(open_list);
while row>0%开表不为空时循环
    index_min_cost=get_min(open_list);%获取代价最小的那一个节点在open_list中的索引
    point=[open_list(index_min_cost,3:4)];%获取那一个节点的坐标
    g_point=open_list(index_min_cost,5);
    close_list=[close_list;open_list(index_min_cost,:)];%将那一点压入close_list

    [row,col]=size(open_list);
    open_list_copy=open_list;
    open_list=[open_list_copy(1:index_min_cost-1,:);open_list_copy(index_min_cost+1:row,:)];%从开表中弹出那一点

    if point(1)==goal(1)&&point(2)==goal(2)
        flag=1;%成功到达目标位置
        break;
    else
        neighbor=get_neighbor(point,height,width);
        [row_neighbor,col_neighbor]=size(neighbor);
        for i=1:row_neighbor
            point_succ=neighbor(i,:);
            [flag_in_close,index_in_close]=in_list(close_list,point_succ);
            if flag_in_close==0&&map(point_succ(2),point_succ(1))>0
                g=g_point+sqrt( (point_succ(1)-point(1))*(point_succ(1)-point(1))+...
                    (point_succ(2)-point(2))*(point_succ(2)-point(2)) );
                [flag_succ,index_succ]=in_list(open_list,point_succ);%检查该点在不在开表中，若在则返回flag=1和其在开表中的索引
                if flag_succ==0
                    if eu_dis==1
                        open_list=[open_list;point(1),point(2),point_succ(1),point_succ(2),g,sqrt((point_succ(1)-goal(1))*(point_succ(1)-goal(1))+(point_succ(2)-goal(2))*(point_succ(2)-goal(2)))];
                    else
                        open_list=[open_list;point(1),point(2),point_succ(1),point_succ(2),g,abs(point_succ(1)-goal(1))+abs(point_succ(2)-goal(2))];
                    end
                elseif flag_succ==1&&g<open_list(index_succ,5)
                    open_list(index_succ,1:2)=point(:);
                    open_list(index_succ,5)=g;
                end
            end
        end
    end
    [row,col]=size(open_list);
end
if flag==1%到达目标位置
    path=[];
    [flag_in_open,index_in_open]=in_list(open_list,goal);%检查该点在不在开表中，若在则返回flag=1和其在开表中的索引
    [flag_in_close,index_in_close]=in_list(close_list,goal);
    while flag_in_open==1||flag_in_close==1
        %将该点压入路径
        if flag_in_open==1
            path=[open_list(index_in_open,3),open_list(index_in_open,4);path];
            [flag_in_open,index_in_open]=in_list(open_list,open_list(index_in_open,1:2));%检查该点在不在开表中，若在则返回flag=1和其在开表中的索引
            [flag_in_close,index_in_close]=in_list(close_list,open_list(index_in_open,1:2));
        else
            path=[close_list(index_in_close,3),close_list(index_in_close,4);path];
            [flag_in_open,index_in_open]=in_list(open_list,close_list(index_in_close,1:2));%检查该点在不在开表中，若在则返回flag=1和其在开表中的索引
            [flag_in_close,index_in_close]=in_list(close_list,close_list(index_in_close,1:2));
        end
    end      
else
    path=[];
end

end