Project 2.1: Weather Data
Thea Gab

Initial Statistics:
An initial look at the data gives some of the following statistics:

No missing data
Outlook
	Mode: sunny, rainy
Temperature
	Range: 64-85
	Mean: 73.571
	Std Deviation: 6.572
Humidity
	Range: 65-96
	Mean: 81.643
	Std Deviation: 10.285
Windy
	Mode: FALSE
Play
	Mode: yes


Clustering:
Clustering did not yield anything too spectacular.  I clustered the nominalized weather data using KMeans with k = 2 (see kMeans_2.txt) and got groups that seemed to be pretty predictably opposite:
(sunny, mild, high humidity, not windy, and play golf)
(overcast, cool, normal humidity, windy, and play golf)
In fact, the only attribute that wasn't different was whether they played golf or not, which is what our analysis is eventually getting at classifying.

So, I tried using k = 3 (see kMeans_3.txt) and got the following groups:
(rainy, mild, normal humidity, not windy, and play)
(overcast, cool, normal humidity, windy, and play)
(sunny, hot, high humidity, windy, and not play)

This seemed to provide a little bit better separation in the dataset, and overall the sum of squared errors is not very large: 20.0

I also decided to run DBScan on the dataset, in case there were any interesting density-based patterns (see DBScan.txt).  However, this returned 0 clusters for the dataset, even when I tried the original data, rather than the nominalized set.

Classification with Decision Tree:
Before running a Decision Tree classifier, I decided to run ZeroR to have a baseline measurement (see ZeroR.txt).  The ZeroR classifier correctly classified 64.29% of the instances in the dataset.

The J48 decision tree only classified 50% of the instances correctly.  This is not necessarily bad, because the tree may work better for larger test sets and not be as overfitted as ZeroR.  However, because there are only two possibilities for the class we're using to classify (yes play golf, or no don't play golf) 50% is just as good as random guessing.

A visualization of the tree created by the J48 classification is in J48_Visualization.jpg.


Classification with Rules:
I tried almost all of the classification techniques, because it was easy to with such a small dataset, but because of the reasons mentioned earlier I was especially looking for ones that gave an accuracy of greater than 50%.  OneR, Ridor, and DecisionTable did not satisfy this qualification.

Prism, JRip, and Conjunctive Rule performed the best on the given data, at around 64% correctly classified classes.  PART and DTNB were around 57%.

For a more in-depth look, I chose Prism, Conjunctive Rule, and PART (see rules.Prism.txt, rules.ConjunctiveRule.txt, rules.PART.txt).

The margin curves for each of these methods can be viewed in Prism_MarginCurve.jpg, ConjunctiveRule_MarginCurve.jpg, and PART_MarginCurve.jpg.

The Prism classifier assumes all attributes are categorical (or converts them, so that there are no continuous attributes).  It does not result in mutually exclusive rules, so its resolution for conflicts is that it only accepts the first rule fired.  The basic algorithm for building this classifier is to create rules for each class at a time.  For each class, the first step taken is to calculate the probability for each discrete value of an attribute that that value corresponds to the given class.  Then the attribute-value with the highest probability is chosen and the probabilities are calculated again on a subset of the data (that have the original attribute-value pair).  This is done until the subset is pure (only contains instances of the given class.  Then, all instances covered by this rule are ignored and the rule for the next class is derived using this algorithm.

The PART decision list derives its rules from a tree-based structure.  PART constructs part of the C4.5 decision tree and then chooses the leaf nodes that provide the best results (according to accuracy or coverage or some combination of both) and then turns these nodes into the rules that it uses.  This method seems less precise than Prism, which fits with its lower accuracy of classification.

Finally, the Conjunctive Rule classifier is a fairly simple.  It looks at all the different possible rules (with combos of attributes, etc) to decide the best one for covering a given class.  The weighted average of the accuracy weights is used to determine what rule is "best".  In this case, the rule just ended up being that play => yes, so in other words, the same result as ZeroR (the mode).


Classification with Nearest Neighbor:
The nearest neighbor algorithms actually appeared to be the most accurate for fitting the given training data.  NNge (non-nested generalized examplars) returned an accurate classification of about 76% (see rules.NNge.txt) and KStar and IBk were both around 57%.  The worst nearest-neighbor-like classification was IB1, which was only at 50% (not as bad as some of the rules-based classifiers).

The classifier errors for NNge are visualized in NNge_Errors.jpg.  Even though there are only 4 distinct positions where a point can be plotted, I added a large jitter factor so that all fourteen points are shown.  As you can see there are not very many classes that were misclassified (the rectangles) compared to the correct ones (the pluses).



