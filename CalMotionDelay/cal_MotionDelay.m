function delay = cal_MotionDelay(path,map)
%date 2021/10/27
%本函数用来计算一条路径的运动时延
%假设每一个像素点代表0.5m

[height,width]=size(map);
% figure,imshow(map);hold on;
% plot(path(:,1), path(:,2));

v_max=4;%m/s
v_min=0.5;%m/s
omiga=0.5;%rad/s
t_wait=0.5;
bandwidth_max=10;
[row_path,col_path]=size(path);
delay=cal_PropagateDelay(path,map,bandwidth_max,v_max,v_min);
delay=delay+cal_ProcessDelay(path,omiga);
delay=delay+(row_path-2)*t_wait;
% disp(delay);

end