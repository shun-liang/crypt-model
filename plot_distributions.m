% Plot the marked cells distribution over time
function plot_distributions(distributions, time_length, crypt_cells)
% distributions(t + 1, i + 1) is the number of crypts having i marked cells at time t.
% time_length: total time length of the simulation
% crypt_cells: number of cells of each crypt

figure
plot(0:time_length, distributions); 
l = legend(strsplit(num2str(0:crypt_cells)));
title('Clone width distributions over time');
ylabel('Number of crypts');
xlabel('Time step');
