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

% Returns the nearest member to the current member in dataset A
function nearest_member_index = nearest_neighbor(A, member_index)
min_distance = Inf;
for i = 1 : size(A(:,1))  % for all rows (members)
    if member_index ~= i
        new_distance = get_distance(member_index, i);
        if new_distance < min_distance
            min_distance = new_distance;
        end
    end
end
end

% Computes and returns the Euclidian distance for n-dimensions, where n is
% the number of columns in dataset A, minus the features column
function distance = get_distance(A, origin_point, other_point)
distance = 0;
for i = 2 : size(A(1,:))  % for all columns (features), skipping members col
    distance = distance + ( A(other_point, i) - A(origin_point, i) )^2;
end
distance = sqrt(distance);
end