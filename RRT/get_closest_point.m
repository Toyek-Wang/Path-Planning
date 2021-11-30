function close_index = get_closest_point(tree,new_point,height,width)

[row_tree,col_tree]=size(tree);
close_distance_squr = (height+width)*(height+width);
close_index = -1;
for i = 1:row_tree
	if (mod(new_point,width) - mod(tree(i,2),width))*(mod(new_point,width) - mod(tree(i,2),width))+(new_point/width - tree(i,2)/width)*(new_point/width - tree(i,2)/width) <= close_distance_squr
		close_distance_squr = (mod(new_point,width) - mod(tree(i,2),width))*(mod(new_point,width) - mod(tree(i,2),width))...
            + (new_point/width - tree(i,2)/width)*(new_point/width - tree(i,2)/width);
		close_index = i;
    end
end
end