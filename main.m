% Project 2 

% function main
disp("Welcome to Andrew Lvovsky's Nearest Neighbor Feature Selection.");
prompt = 'Type in the name of the file containing your dataset: ';

filename = input(prompt, 's');
fileID = fopen(filename);
if filename == "small86.txt"
    sizeA = [11 200];
elseif filename == "large4.txt"
    sizeA = [101 200];
else
    row_prompt = 'How many rows in your dataset?';
    row_num = input(row_prompt);
    col_prompt = 'How many columns in your dataset?';
    col_num = input(col_prompt);
    sizeA = [col_num row_num];
end
A = fscanf(fileID, '%f', sizeA);
fclose(fileID);
A = A';


% end

function y = nearest_neighbor(x)
if ~isvector(x)
    error('Input must be a vector')
end
y = sum(x)/length(x); 
end