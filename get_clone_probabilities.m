% Calculate the probability of the clone width value of each crypt for all simulation time steps.
function clone_probabilities = get_clone_probabilities(filtered_clone_widths, time_length, ...
    crypt_num)
clone_probabilities = repmat(NaN, crypt_num, time_length + 1);
for t = 0:time_length
    filtered_clone_widths_t = filtered_clone_widths(:, t + 1);
    filter = isfinite(filtered_clone_widths_t);
    filtered_clone_widths_no_NaN = filtered_clone_widths_t(filter);
    filter_length = length(filtered_clone_widths_no_NaN);
    for c = 1:filter_length
        clone_width = filtered_clone_widths_no_NaN(c);
        clone_width_count = sum(filtered_clone_widths_no_NaN == clone_width);
        clone_width_probability = clone_width_count / filter_length;
        clone_probabilities(c, t + 1) = clone_width_probability;
    end
end
