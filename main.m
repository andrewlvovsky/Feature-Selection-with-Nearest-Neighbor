% Project 2

function main()
% disp("Welcome to Andrew Lvovsky's Nearest Neighbor Feature Selection.");
% prompt = 'Type in the name of the file containing your dataset: ';

% filename = input(prompt, 's');
data = read_data('large4.txt');
% features = [];
% accuracy = nearest_neighbor(data, features) * 100;
% [accuracy, best_feature_set] = forward_selection(data);
% disp(best_feature_set);
% disp(['Feature set [', num2str(best_feature_set), ...
%     '] was best at an accuracy of ', num2str(accuracy), '%.']);
[accuracy, best_feature_set] = backward_elim(data);
disp(best_feature_set);
disp(['Feature set [', num2str(best_feature_set), ...
    '] was best at an accuracy of ', num2str(accuracy), '%.']);
end

% Reads a dataset from a specified file, outputs an m x n matrix (data)
function data = read_data(filename)
fileID = fopen(filename);
if filename == "small86.txt" || filename == "small108.txt" || ...
        filename == "small109.txt" || filename == "small110.txt"
    size_data = [11 200];
elseif filename == "large4.txt" || filename == "large108.txt" || ...
        filename == "large109.txt" || filename == "large110.txt"
    size_data = [101 200];
else
    row_prompt = 'How many rows in your dataset? ';
    row_num = input(row_prompt);
    col_prompt = 'How many columns in your dataset? ';
    col_num = input(col_prompt);
    size_data = [col_num row_num];
end
data = fscanf(fileID, '%f', size_data);
fclose(fileID);
data = data'; % transposing data since input is put in col x row matrix
end

% Returns the most accurate features out of all of th
function [best_accuracy, best_feature_set] = forward_selection(data)
num_of_features = get_num_of_features(data);
features = [];
best_accuracy = 0;
for i = 1 : num_of_features
    disp(" ");
    disp(['On level ', num2str(i), ' of the search tree...']);
    disp(" ");
    for j = 1 : num_of_features
        if isempty(intersect(features,j))
            features = [features, j];  % adding feature
            test_accuracy = nearest_neighbor(data, features);
            disp(['Tested feature set [', num2str(features), ...
                '] with accuracy: ', num2str(test_accuracy), '%']);
            features(end) = []; % removing feature
            if test_accuracy > best_accuracy
                best_accuracy = test_accuracy;
                feature_to_add = j;
                best_feature_set = [features, j];
                disp(['On level ', num2str(i),', feature ', ...
                    num2str(feature_to_add), ' was added to best set!']);
            end
        end
    end
    features = best_feature_set;
end
end

function [overall_best_accuracy, overall_best_feature_set] = backward_elim(data)
num_of_features = get_num_of_features(data);
features = zeros(1, num_of_features);   % preallocates features array
overall_best_accuracy = 0;
for i = 1 : num_of_features    % populates array with all features
    features(i) = i;
end
test_accuracy = nearest_neighbor(data, features);
disp(['Tested full feature set [', num2str(features), ...
    '] with accuracy: ', num2str(test_accuracy), '%']);
overall_best_accuracy = test_accuracy;
overall_best_feature_set = features;
while ~isempty(features)
    if size(features,2) > 1
        current_best_accuracy = 0;
        current_best_feature_set = [];
        for i = 1 : size(features,2)
            removed_feature = features(i);
            features(i) = [];   % remove feature from array
            test_accuracy = nearest_neighbor(data, features);
            disp(['Removed feature ', num2str(removed_feature), ...
                ' from feature set [', num2str(features), ...
                '] with accuracy: ', num2str(test_accuracy), '%']);
            if test_accuracy > current_best_accuracy
                current_best_accuracy = test_accuracy;
                current_best_feature_set = features;
                disp(['Feature set [', ...
                    num2str(current_best_feature_set), ...
                    '] is local best set, with accuracy ', ...
                    num2str(current_best_accuracy), '%']);
                if current_best_accuracy > overall_best_accuracy
                    overall_best_accuracy = test_accuracy;
                    overall_best_feature_set = features;
                    disp(['Feature set [', ...
                        num2str(overall_best_feature_set), ...
                        '] is global best set, with accuracy ', ...
                        num2str(overall_best_accuracy), '%']);
                end
            end
            % add feature back
            features = [features(1:i-1), removed_feature, features(i:end)];
        end
        features = current_best_feature_set;
    else
        removed_feature = features;
        features = [];   % remove feature from array
        test_accuracy = nearest_neighbor(data, features);
        if current_best_accuracy > overall_best_accuracy
            overall_best_accuracy = test_accuracy;
            overall_best_feature_set = features;
            disp(['Feature set [', ...
                num2str(overall_best_feature_set), ...
                '] is global best set, with accuracy ', ...
                num2str(overall_best_accuracy), '%']);
        end
    end
end
end

% Returns the accuracy of the data, depending on what features were
% passed in.
function accuracy = nearest_neighbor(data, features)
correct_counter = 0;
num_of_members = size(data(:,1));
num_of_members = num_of_members(1,1);
for i = 1 : num_of_members
    min_distance = Inf;
    for j = 1 : num_of_members
        if i ~= j % leave-one-out
            new_distance = get_distance(data, features, i, j);
            if new_distance < min_distance
                min_distance = new_distance;
                nearest_member = data(j,1);
            end
        end
    end
    if data(i,1) == nearest_member
        correct_counter = correct_counter + 1;
    end
end
accuracy = (correct_counter / num_of_members) * 100;
end

% Computes and returns the Euclidian distance for n-dimensions, where n is
% the number of elements in the features array
function distance = get_distance(data, features, origin_point, other_point)
distance = 0;
for i = 1 : numel(features)  % for all features, skipping member column
    curr_feature = features(i);
    distance = distance + ( data(other_point, curr_feature+1) ...
        - data(origin_point, curr_feature+1) )^2;
end
distance = sqrt(distance);
end

function num_of_features = get_num_of_features(data)
num_of_features = size(data(1,:));
num_of_features = num_of_features(2) - 1;
end