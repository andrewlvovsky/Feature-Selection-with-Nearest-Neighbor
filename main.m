% Project 2 

function main()
% disp("Welcome to Andrew Lvovsky's Nearest Neighbor Feature Selection.");
% prompt = 'Type in the name of the file containing your dataset: ';

% filename = input(prompt, 's');
A = read_data('large110.txt');
features = [1 66 6];
accuracy = nearest_neighbor(A, features) * 100;
disp(['Accuracy for all features is ', num2str(accuracy), '%']);
end

% Reads a dataset from a specified file, outputs an m x n matrix
function A = read_data(filename)
fileID = fopen(filename);
if filename == "small86.txt" || filename == "small108.txt" || ...
        filename == "small109.txt" || filename == "small110.txt"
    sizeA = [11 200];
elseif filename == "large4.txt" || filename == "large108.txt" || ...
        filename == "large109.txt" || filename == "large110.txt"
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

% Returns the accuracy of the dataset A, depending on what features were
% passed in.
function accuracy = nearest_neighbor(A, features)
correct_counter = 0;
num_of_members = size(A(:,1));
num_of_members = num_of_members(1,1);
for i = 1 : num_of_members
    min_distance = Inf;
    for j = 1 : num_of_members
        if i ~= j % leave-one-out
            new_distance = get_distance(A, features, i, j);
            if new_distance < min_distance
                min_distance = new_distance;
                nearest_member = A(j,1);
            end
        end
    end
    if A(i,1) == nearest_member
        correct_counter = correct_counter + 1;
    end
end
accuracy = correct_counter / num_of_members;
end

% Computes and returns the Euclidian distance for n-dimensions, where n is
% the number of elements in the features array
function distance = get_distance(A, features, origin_point, other_point)
distance = 0;
for i = 1 : numel(features)  % for all features, skipping member column
    curr_feature = features(i);
    distance = distance + ...
        ( A(other_point, curr_feature+1) - A(origin_point, curr_feature+1) )^2;
end
distance = sqrt(distance);
end