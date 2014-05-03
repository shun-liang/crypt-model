% Plot the marked cells distribution over time
function distributions = get_distributions(marked_cells, time_length, crypt_cells, crypt_num)
% distributions(t + 1, i + 1) is the number of crypts having i marked cells at time t.
% marked_cells(c, t + 1) is the number of marked cells of crypt c at time t
% time_length: total time length of the simulation
% crypt_cells: number of cells of each crypt
% crypt_num: number of crypts

distributions = zeros(time_length + 1, crypt_cells + 1);
% We use t + 1 and i + 1 instead of t and i to index since MATLAB array index starts from 1.
for t = 0:time_length
    for i = 0:crypt_cells
        for c = 1:crypt_num
            if marked_cells(c, t + 1) == i
                distributions(t + 1, i + 1) = distributions(t + 1, i + 1) + 1;
            end
        end
    end
end 
