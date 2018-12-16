# Feature Selection with Nearest Neighbor

### Introduction

	The intention of this project was to show how different types of feature searches (when used by mixing leave-one-out cross validation with the nearest neighbor classifier algorithm) could be advantageous, depending on the size of the dataset given. I was tasked with implementing a forward selection and backward elimination algorithm, as well as an optimized algorithm that should’ve ran faster than the two. I added pruning to the forward selection algorithm to accomplish the optimization, as the pruning is able to disregard subtrees that have a worse accuracy than what has already been found.

### Implementation

	Before beginning to code, I had to find a way to parse the data from the .txt files. Since I chose MATLAB, I found it easier to keep the members and features in one matrix (2D array) rather than separating them into two.  Next, I worked on implementing the nearest neighbor classifier inside the leave-one-out cross validation function. Once finished, I cross-checked my results against the professor’s results as a sanity check, and only then proceeded to work on the feature selection implementations.

	The forward selection took time to wrap my head around, and I had to whiteboard the design to fully understand what was going to happen under-the-hood. Since MATLAB is one of my weaker languages (and I thought it was good practice to use for this project), I had some easily-avoidable syntactical errors that made forward selection not run properly. After fixing those errors, backward elimination and pruning forward selection were much easier to implement.

### Results

	The small dataset displayed the most consistent results. All three algorithms found the feature subset [8 10] to be the most accurate combination of features, at 94.5%. The large dataset was a bit more inconsistent. The forward selection and pruning forward selection algorithms found the feature subset [47 63] to be the most accurate, at 95.5%. However, the backward elimination found the feature subset [2    5    7    8    9   10   11   12   17   19   23   28   29   30   31   32   36   37   39   40   41   42   46   47   48   50   51   52   54   55   56   57   58   59   61   64   65   67   68   69   70   72   74   75   76   77   78   80   83   84   86   87   88   89   90   91   93   94   95   98  100] to be the most accurate, at an accuracy of 88.8%.

### Conclusion

	Across all the datasets, we see that the pruning forward selection algorithm is the fastest algorithm to use. This is the case because when going down the tree of adding features, we don’t care about a subtree that performs worse than the current best accuracy found thus far. Because of this, we don’t have to evaluate the subtree, and can leave it be. This saves greatly on time, since each call to the leave-one-out cross validation function is costly, with a runtime of O(n^2).

	Backward elimination placed 2nd in the runtime race on the small dataset, but takes quite a long time on the large dataset. Since backward elimination starts out with all the features in the dataset, the time it takes to remove an element, run leave-one-out cross validation on the new feature set, and place that element back would be costly. Since cross validation runs the nearest neighbor classifier, it needs to compare the distance between all members and their features in the dataset.  However, it performs 2nd best on the small dataset, beating out forward selection.

	Forward selection performs better than backward elimination on the large dataset, but slower on the small dataset. This could be because adding elements one by one will make running cross validation faster, since the nearest neighbor classifier doesn’t need to get the distance between members based on as many features as running backward elimination.
