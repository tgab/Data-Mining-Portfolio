Weka-Classifying
Thea Gab

For initial experiments with classfication in this data set, I decided to explore the factors influencing "Patient Disposition".

First I ran the ZeroR classification using the train-f file (see ZeroR_Disposition.txt).  Incorrectly classified values ran at about 57.5%, which isn't surprising considering ZeroR takes the median value.

Then I decided to start down the path of choosing a classification tree.  I initially experimented with a Decision Stump to see what might be an influential factor in "Patient Disposition" (see DecisionStump_Disposition.txt).  This gave me "Length of Stay" as an important deciding factor.  Obviously, this is something that will be influence by disposition, so I attempted to get rid of all those attributes that would imply the reverse of the causation I was looking for (the diagnosis codes still apply, because the patient had that condition before their stay- they were just tested for it at the hospital).  Most of the cost, length of stay, procedure codes, etc and other attributes such as this were removed.

Also, to make the data set simpler I removed PatientID, because I wanted to predict per hospital visit, no matter if the patient was a repeat or not.  I also, cut out other attributes that seemed to be slightly redundant or unecessary.  For example, I removed the CMC's and decided to just use the PL's (which generalize the CMC's a little bit more).

However, I still ran out of heap space trying to run the classifier even with around 30 attributes, so I pruned the dataset down even more (removing all but the principle and admit diagnosis codes).  This left me with 17 attributes.

Using the train-f file, with only a few attributes left, I first tried using a J48 classification tree with 4 folds(see J48_Disposition.txt).  This pruned tree, however, ended up being the same as ZeroR classification at 57.5% incorrectly classified instances

Then, I tried the SimpleCart classifier with 4 folds(see SimpleCart_Disposition.txt).  This only incorrectly classified 56.2275% of the instances, which was less than J48 and ZeroR, but not by much.

The problem with this is probably two-fold.  There are still a lot of attributes in the dataset that are probably noisy/unecessary and a lot of attributes that need to be combined better into one.  Also, my analysis is looking at the data for one instance of a patient visit to the hospital at a time.  Adding in data accounting for past visits and health history would probably lead to a more accurate model.

Just to see if it would help, I decided to use my clustering discoveries (using 3, 4, or 5 attributes) to see if these would improve the prediction.

I chose the following four attributes and ran the J48 classifier on them (this time I used ten folds because the size was a lot smaller):
Interval
Age
Patient-Disposition
Admit-Type

The results are in J48_Four_Disposition.txt.  The percentage of incorrectly classsified instances was only 20.76% this time.  Although this is only the result of one experiment it seems to indicate that the number of attributes was a major factor that was getting in the way of the analysis, and spending time figuring out how to accurately reduce the number of dimensions into a more concise form could be very useful.

