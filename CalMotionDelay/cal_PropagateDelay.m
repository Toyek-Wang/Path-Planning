function PropagateDelay = cal_PropagateDelay(path,map,bandwidth_max,v_max,v_min)
%date 2021/10/27
%本函数用来计算运动传播时延

%对带每一个路径段，
% 先将其分成n段，
% 计算每一段的带宽函数，
% 依据带宽函数计算速度
[height,width]=size(map);

PropagateDelay=0;
n=5;
L=v_min/v_max*bandwidth_max;
[row_path,col_path]=size(path);
for i=1:row_path-1
    %获得这一段路径的方向
    theta=get_theta_of_vector(path(i,1),path(i,2),path(i+1,1),path(i+1,2));
    %计算这一段路径的每一片长度
    length=sqrt((path(i,1)-path(i+1,1))*(path(i,1)-path(i+1,1))+(path(i,2)-path(i+1,2))*(path(i,2)-path(i+1,2)));
    if length<5
        step=length;
        n=1;
    else
        step=length/n;
        n=5;
    end
    for j=1:n
        %获取这一段路径上第i片的中点
        mid_point=[path(i,1)+(j-0.5)*step*cos(theta),path(i,2)+(j-0.5)*step*sin(theta)];
        %向垂直于路径的左右两侧进行搜索，探索带宽
        theta_left=theta+0.5*pi;
        theta_right=theta-0.5*pi;
        %向左探索
        bandwidth=bandwidth_max;
        for k=1:bandwidth_max
            y_l=floor(mid_point(2)+k*sin(theta_left));
            x_l=floor(mid_point(2)+k*cos(theta_left));
            y_r=floor(mid_point(2)+k*sin(theta_right));
            x_r=floor(mid_point(2)+k*cos(theta_right));
            if y_l<1||y_l>height||x_l<1||x_l>width||y_r<1||y_r>height||x_r<1||x_r>width
                bandwidth=k;
                break;
            end
            if map(y_l,x_l)<1||map(y_r,x_r)<1
                bandwidth=k;
                break;
            end
        end
        if bandwidth<=L
            PropagateDelay=PropagateDelay+step/v_min;
        else
            PropagateDelay=PropagateDelay+step/(bandwidth/bandwidth_max*v_max);
        end
    end
end

end