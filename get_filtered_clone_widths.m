% Filter all-zero and all-one crypt clones from the marked_cells matrix.
function filtered_clone_widths = get_filtered_clone_widths(marked_cells, time_length, crypt_num, crypt_cells)
% marked_cells(c, t + 1) is the number of marked cells of crypt c at time t
filtered_clone_widths = repmat(NaN, crypt_num, time_length + 1);
for t = 0:time_length
    clone_widths_t = marked_cells(:, t + 1);
    filter = clone_widths_t > 0 & clone_widths_t < crypt_cells;
    clone_widths_t_filtered = clone_widths_t(filter);
    filter_length = length(clone_widths_t_filtered);
    filtered_clone_widths(1:filter_length, t + 1) = clone_widths_t_filtered;
end
