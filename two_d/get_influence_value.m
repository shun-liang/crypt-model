% Get influence value for two D model with halo boundary conditions
function influence_value = get_influence_value(influence_values, row_index, col_index)
influence_value = influence_values(row_index + 1, col_index + 1);
