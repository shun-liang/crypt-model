% Cell update function of the two dimensional model with halo boundary
function new_state = cell_update_halo(cell_array, influence_values, row_index, col_index, row_length, col_length,...
    replacement_rate)
% cell_array is expected to be a 2D array. 
new_state = cell_array(row_index, col_index);
% Does this cell die in this iteration?
above_influence = get_influence_value(influence_values, row_index, col_index - 1);
right_influence = get_influence_value(influence_values, row_index + 1, col_index);
below_influence = get_influence_value(influence_values, row_index, col_index + 1);
left_influence = get_influence_value(influence_values, row_index - 1, col_index);

influence_sum = above_influence + right_influence + below_influence + left_influence;
random_value = rand * influence_sum;
if random_value < above_influence
    % Select the above adjacent state.
    new_state = cell_array(row_index, col_index - 1);
elseif random_value < above_influence + right_influence
    % Select the right adjacent state.
    new_state = cell_array(row_index + 1, col_index);
elseif random_value < above_influence + right_influence + below_influence
    % Select the below adjacent state.
    new_state = cell_array(row_index, col_index + 1);
else
    % Select the left adjacent state.
    new_state = cell_array(row_index - 1, col_index);
end
