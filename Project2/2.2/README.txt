Project 2.2: Weather Data
Thea Gab

Bayesian Classifiers:
The Naive Bayes Classifer and Bayesian Network Classifiers returned similar results for the nominalized weather dataset (see NaiveBayes.txt and BayesNet.txt).  Both correctly classified about 57% of the instances with the same confusion matrix.  However, the Bayesian Network classifier reported a relative absolute error of 87%, while for the Naive Bayes Classifier it was about 92%.

Using Naive Bayes with the original dataset (rather than nominalized) improved the correctly classified instances to 64% (see NaiveBayes_orig.txt), but also increased the relative absolute error to 98% (probably due to the fact that most of the instances were classified as "yes").

Naive Bayes uses the conditional probabilities of classes in the training data to come up with probability estimates that can be used for test data.  It is not an updateable classifier, meaning you the probabilities will not change every time a new instance is added.

The Bayesian Network works by allowing you to choose a method for estimating the conditional probabilities of a class and an option to choose a learning algorithm.  The K2 search algorithm is used by default, and it adds arcs to the network using a fixed order of variables.  This, again, classified 57% of the instances correctly.

The simulated annealing algorithm randomly generates a network that is similar to the current network and tests to see if it is better or not.  When using this algorithm with the Bayesian Network classifier the amount of correctly classified instances increased to 71% (see BayesNet_Annealing.txt).

Genetic search was the last search algorithm I examined for the Bayesian Network.  It implements a simple genetic search algorithm that involves storing bits for the presence or absence of an arc in an array.  Arcs are randomly added and deleted and the network is refined according to a "survival of the fittest"-type rule.  This algorithm perform the best of all with almost 79% of instances correctly classified (see BayesNet_Genetic.txt).

All three of these networks can be visualized in BayesNet.jpg (for K2), BayesNet_Annealing.jpg, and BayesNet_Genetic.jpg.  The structure of the network for annealing and genetic search appears to be a little more complex than that of the simple Bayesian Network using K2.  This possibly contributes to the more accurate classification using those two methods.  Another interesting thing to note, is that although the network is the same for simulated annealing and genetic search the classification statistics are still different.  The visual model is certainly informative, but does not include the calculated probabilities and estimates used by each model.

The third Bayesian classifier I explored was AODE.  AODE attempts to correct for the Bayesian assumption that all class attributes are independent by using weaker Bayes-like models and averaging over all of them.  The AODE, however, did not perform very well on this dataset, only correctly classifying 50% of the instances correctly (see AODE.txt).

I have also included visualizations of both the AODE and Naive Bayes predicted and actual classification graphed against all the various attributes (e.g. AODE_Temp.jpg, NaiveBayes_Temp.jpg, etc.).  It can be seen that certain values of certain attributes appear to have more accuracy using one method than another.  For example, looking at AODE_Temp.jpg and NaiveBayes_Temp.jpg it is clear that AODE is more accurate at class prediction when the temperature is hot.  On the other hand, looking at AODE_Outlook.jpg and NaiveBayes_Outlook.jpg, Naive Bayes does better at predicting the class value for play when it is overcast.

ANN Classifiers:
Of the Multilayer Perceptron, Voted Perceptron, and Winnow, the Multilayer brought about the best rate of correctly classified instances on the training set at 71%.

When looking at the results (see MultiLayerPerceptron.txt, VotedPerceptron.txt, and Winnow.txt) it is not surprising that multilayer performed the best.  It is the only perceptron that uses multiple levels of nodes and backpropogation, and is thus a more complex model.

The Voted Perceptron model actually transforms nominal attributes into binary, simplifying the model even more.  Winnow uses a simple one-layer weighting system and updates the weights through each iteration until a stopping condition is reached.

The Multilayer Perceptron results can be improved even more (up to 79% correctly classified instances) when using the original dataset rather than nominalized (see MultilayerPerceptron_orig.txt).

Summary:
The algorithms that performed the best in this experiment were the Bayesian Network with a simple estimator and using genetic search on the nominalized data, and the Multilayer Perceptron on the original dataset.  Both resulted in almost 79% correctly classified instances.  However, almost all the error terms were lower for the Multilayer Perceptron, so I would classify it as having achieved the best results.  I was surprised that the Bayesian classifiers performed so well, given that oftentimes different aspects of the weather can be correlated and Bayes doesn't generally handle dependent variables well.  Also, the design of this dataset didn't seem like it would fit well into a network.  I did have to change the algorithms around a little bit to get the highest results from the Bayesian network.  The ANN classfiers did perform well as expected, however the simplistic models (Winnow and Voted Perceptron) were not all that impressive.  Overall, though, the performance of the Multilayer Perceptron and its error values are very satisfactory.