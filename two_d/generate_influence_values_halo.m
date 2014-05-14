% Generate influence values matrix for two D model with halo boundary conditions
function influence_values = generate_influence_values_halo(row_length, col_length, crypt_num)
influence_values = ones(row_length + 2, col_length + 2, crypt_num);
for c = 1:crypt_num
    influence_values(1, :, c) = 0;
    influence_values(row_length + 2, :, c) = 0;
    influence_values(:, 1, c) = 0;
    influence_values(:, col_length + 2, c) = 0;
end
