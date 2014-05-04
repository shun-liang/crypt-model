% Cell update function of the two dimensional model
function new_state = cell_update(cell_array, row_index, col_index, row_length, col_length, replacement_rate)
%ndims(cell_array)
%disp(sprintf('Fun: Row: %d, Col: %d\n', row_index, col_index))
% cell_array is expected to be a 2D array. 
new_state = cell_array(row_index, col_index);
% Does this cell die in this iteration?
if rand <= replacement_rate
    if row_index == 1
        left_state = cell_array(row_length, col_index);
    else
        left_state = cell_array(row_index - 1, col_index);
    end
    if row_index == row_length 
        right_state = cell_array(1, col_index);
    else
        right_state = cell_array(row_index + 1, col_index);
    end
    if col_index == 1
        above_state = cell_array(row_index, col_length);
    else
        above_state = cell_array(row_index, col_index - 1);
    end
    if col_index == col_length 
        below_state = cell_array(row_index, 1);
    else
        below_state = cell_array(row_index, col_index + 1);
    end

    ran_var = unidrnd(4);
    if ran_var == 1 
        new_state = left_state;
    elseif ran_var == 2
        new_state = right_state;
    elseif ran_var == 3
        new_state = above_state;
    elseif ran_var == 4
        new_state = below_state;
    end
end
end
