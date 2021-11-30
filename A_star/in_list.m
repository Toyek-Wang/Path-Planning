function [flag,index] = in_list(list,point)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
[row,col]=size(list);
flag=0;
index=-1;
for i=1:row
    if list(i,3)==point(1)&&list(i,4)==point(2)
        flag=1;
        index=i;
        break;
    end
end
end