% Project 2 

function main
disp("Welcome to Andrew Lvovsky's Nearest Neighbor Feature Selection.");
prompt = 'Type in the name of the file containing your dataset: ';

filename = input(prompt, 's');
A = read_data(filename);
end

% Reads a dataset from a specified file, outputs an m x n matrix
function A = read_data(filename)
fileID = fopen(filename);
if filename == "small86.txt"
    sizeA = [11 200];
elseif filename == "large4.txt"
    sizeA = [101 200];
else
    row_prompt = 'How many rows in your dataset? ';
    row_num = input(row_prompt);
    col_prompt = 'How many columns in your dataset? ';
    col_num = input(col_prompt);
    sizeA = [col_num row_num];
end
A = fscanf(fileID, '%f', sizeA);
fclose(fileID);
A = A'; % transposing A since input read is put in col x row matrix
end

function nearest_member_index = nearest_neighbor(A, member_index)
min_distance = Inf;
for i = 1:size(A(:,1))
    if member_index ~= i
        new_distance = get_distance(member_index, i);
        if new_distance < min_distance
            min_distance = new_distance;
        end
    end
end
end

function distance = get_distance(origin, far_point, n)
end