function new_state = cell_update(cell_array, index, length, replacement_rate)
new_state = cell_array(index);
% Does this cell die in this iteration?
rng('shuffle');
if rand <= replacement_rate
    if index == 1
        left_state = cell_array(length);
    else
        left_state = cell_array(index - 1);
    end
    if index == length 
        right_state = cell_array(1);
    else
        right_state = cell_array(index + 1);
    end
    rng('shuffle');
    if rand < 0.5
        new_state = left_state;
    else
        new_state = right_state;
    end
end
end
