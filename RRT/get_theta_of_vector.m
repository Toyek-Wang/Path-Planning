function theta=get_theta_of_vector(point1_x,point1_y,point2_x,point2_y)
%获得一个向量的角度
if point2_y > point1_y && point2_x > point1_x
	theta=atan((point2_y - point1_y) / (point2_x - point1_x));
elseif point2_y > point1_y && point2_x < point1_x
	theta=pi - atan((point2_y - point1_y) / (point1_x - point2_x));
elseif point2_y < point1_y && point2_x < point1_x
	theta= -pi + atan((point1_y - point2_y) / (point1_x - point2_x));
elseif point2_y < point1_y && point2_x > point1_x
	theta= -atan((point1_y - point2_y) / (point2_x - point1_x));
elseif point2_y == point1_y && point2_x > point1_x
	theta= 0.0;
elseif point2_y == point1_y && point2_x < point1_x
	theta= pi;
elseif point2_x == point1_x && point2_y < point1_y
	theta= -pi / 2.0;
elseif point2_x == point1_x && point2_y > point1_y
	theta= pi / 2.0;
else
    theta= -2000;
end
end

