function ProcessDelay = cal_ProcessDelay(path,omiga)
%date 2021/10/27
%本函数用来计算运动处理时延
[row_path,col_path]=size(path);

%定义一个惩罚因子

theta1=get_theta_of_vector(path(1,1),path(1,2),path(2,1),path(2,1));
ProcessDelay=0;

for i=2:row_path-1
    theta2=get_theta_of_vector(path(i,1),path(i,2),path(i+1,1),path(i+1,2));
    ProcessDelay=ProcessDelay+(abs(theta2-theta1))^1.2/omiga;
end

end