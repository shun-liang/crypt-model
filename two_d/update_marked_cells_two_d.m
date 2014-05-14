% Update the marked_cell matrix. Should be called in each iteration in the simulation.
function new_marked_cells = update_marked_cells_two_d(marked_cells, cells, time_step, new_state, crypt_idx, cell_i_idx,... 
    cell_j_idx)
% marked_cells(c, t + 1) is the number of cells in the marked clone in crypt c at time step t.

marked_cells_in_crypt = marked_cells(crypt_idx, (time_step - 1) + 1);
if cells(cell_i_idx, cell_j_idx, crypt_idx) == 1 && new_state == 0
    marked_cells_in_crypt = marked_cells_in_crypt - 1;
end
if cells(cell_i_idx, cell_j_idx, crypt_idx) == 0 && new_state == 1
    marked_cells_in_crypt = marked_cells_in_crypt + 1;
end
marked_cells(crypt_idx, time_step + 1) = marked_cells_in_crypt;
new_marked_cells = marked_cells;
