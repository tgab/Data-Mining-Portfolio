Weka-Clustering
Thea Gab

In order to generate some interesting clusters, I first of all looked at the visualizations that Weka provides of different attributes.  I found attributes that seemed to correspond to eachother more and took those as a starting point.

For example, I found that the Interval between hospital visits and the Length of Stay at a facility seemed to be strongly correlated.  To test this I ran a clustering of the dataset on these to attributes and discovered that the SSE was only around 172 for k=3 clusters (see Interval_Length.txt).

Then I decided to expand this to three attributes and see what the lowest SSE was that I could get, while still maintaining fairly diverse clusters (not all the same value).  

I played around with adding a lot of different values to Length of Stay and Interval, and also changing things up a little.  Some of the best results (as far as low SSE and distinctive clusters) I got were with the following attributes:

Interval
Patient-Disposition
Length of Stay
k=5 SSE=9600
(see Interval_Disp_Length.txt)

Age
Patient-Disposition
Length of Stay
k=5 SSE=12800
(see Age_Disp_Length.txt)

Interval
Length of Stay
Admit-Type
k=5 SSE=400
(see Interval_Length_Admit.txt)

Next, I decided to try this technique with 4 attributes.  Combining the ones I used earlier that seemed to be well correlated.
Interval
Age
Patient-Disposition
Length of Stay
k=4 SSE=11300
(see Interval_Age_Disp_Length.txt)


Interval
Patient-Disposition
Length of Stay
Admit-Type
k=4 SSE=33000
(see Interval_Disp_Length_Admit.txt)

And then with 5 attributes:
Interval
Age
Patient-Disposition
Length of Stay
Admit-Type
k=6 SSE=24700
(see Interval_Age_Disp_Length_Admit.txt)

Obviously, this technique could be expanded to explore different combinations of these attributes with different k values, and also using other attributes.  This, however, gives an initial idea of some attributes that appear to be important to this dataset and some various combinations of them.