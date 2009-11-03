Project 3.1: Weather Data
Thea Gab

Apriori:
The Apriori-type algorithm in Weka reduces the minimum support required until it finds a required number of rules that have a certain confidence.

Different metrics, however, can be used besides confidence.  Confidence measures the percentage of rules where the left-hand and right-hand side hold over the total number of rules where the left-hand side holds.  Lift takes confidence and divides it by the total number of rules where the right-hand side holds.  This makes it more independent of support.  Leverage calculates the additional number of examples expected to be covered if the left-hand and right-hand side of the rules are completely independent over the total number expected given this condition (basically the probability that the left-hand and right-hand sides occur together minus their independent probabilties).  Finally conviction does something similar to lift, but instead takes the probabilities of the left-hand side being true and the right-hand side being false, over the probability of the left-hand and right-hand sides occurring together.

The results of examining the weather dataset are contained in Apriori.txt (uses the confidence metric), Apriori_Lift.txt, Apriori_Leverage.txt, and Apriori_Confidence.txt.

If we measure by highest values for minimum support and highest ranking metric, the lift metric seems to have performed the best.

However, when using the confidence metric, 10 rules are given that each have a confidence of 1, which is the best attainable confidence.  Support is lower, but may not be as important as confidence, especially given that we have a small dataset.  In other words, because there is not much data to begin with, we are kind of stuck with generalizing a lot from the little data that we have.

Predictive Apriori:
Predictive Apriori takes a somewhat opposite approach to Apriori.  Instead of decreasing the threshold for support, it increases the threshold for support to find the best n rules with a certain confidence value (corrected to be independent of support).

The default number of rules for this algorithm is 100, but for the weather dataset, with only 14 entries, this seems a little ridiculous (PredictiveApriori.txt).  The top 7 rules with the basic Predictive Apriori and regular Apriori are the same, which means that for this data set the confidence seems to be pretty accurate even with out being adjusted to be independent of support. I next used PredictiveApriori with 10 rules (PredictiveApriori_10.txt) in order to compare it to the regular Apriori algorithm.  It is interesting to note that the first three rules are the same in each.  The accuracy for these three rules is extremely high in Apriori, but from there out the accuracy decreases significantly.  I next chose to look at only 5 rules (PredictiveApriori_5.txt).  This time only the first two rules were the same.

Tertius:
The basic idea of the Tertius method is to start with an empty rule and continue refining that rule according to different thresholds and estimates until it meets a certain confirmation threshold.  At this point the rule is added to the set of associative rules, and the algorithm continues, checking all other possible children of a given rule.

The Tertius algorithm came up with 24 rules for the weather dataset (Tertius.txt).  It is interesting that Tertius allows for "or" statements on the right-hand side of the argument.  This allows for more complexity in the relationships that the other algorithms do not account for.

HotSpot:
HotSpot tries to minimize or maximize a certain value or variable that is particularly interesting to the user when learning its set of rules.  This is useful when you are looking for association related to a particular attribute or value of that attribute.

The HotSpot analysis of the weather data (HotSpot.txt) with temperature as the attribute of interest tries to maximize temperature based on the other attributes.  The original result (with a segment size of 5 instances) is visualized in HotSpotGraph.jpg.  However, 5 instances seems like a lot to require, especially when the total data set is only 14 instances.  So, I tried HotSpot with a minimum support of 20%, or a segment size of 3 instances.  The averages at the nodes of the graph on this tree (HotSpot_20Graph.jpg) get a lot closer to the maximum value for temperature, 85.  They are also a lot closer to each other.  All values of 79 or 80, suggesting a more consistent maximization across the rules.

Initially, HotSpot didn't seem to provide much information in the way of analysis.  However, after experimenting with the parameters a little bit it did lead to some associations that seemed to make sense (such as sunny and humid days corresponding to high temperatures).  I was a little disappointed with the initial results, but I think that given a bigger data set it would provide some more interesting relationships.