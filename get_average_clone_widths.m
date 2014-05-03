% Calculate the average clone widths for all simulation time stemps
function average_clone_widths = get_average_clone_widths(filtered_clone_widths, time_length, ...
    crypt_num)
average_clone_widths = zeros(1, time_length + 1);
for t = 0:time_length
    filtered_clone_widths_t = filtered_clone_widths(:, t + 1);
    filter = isfinite(filtered_clone_widths_t);
    filtered_clone_widths_no_NaN = filtered_clone_widths_t(filter);
    average_clone_widths(t + 1) = mean(filtered_clone_widths_no_NaN);
end
