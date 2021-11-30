function flag = is_save(map,point1,point2,step)

[height,width]=size(map);
flag =1;
theta = get_theta_of_vector(mod(point1,width), point1/width+1, mod(point2,width), point2/width+1);
for i = 1:step
    xx=floor(mod(point1,width) + i * cos(theta));
    yy=floor(point1/width+1 + i * sin(theta));
    xx=max(min(width,xx),1);
    yy=max(min(height,yy),1);
	if map(yy,xx) < 1
		flag=0;
		break;
    end
end

end

