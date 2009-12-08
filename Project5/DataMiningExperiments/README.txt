DataMining Project 5.1: YouTube Data

Introduction
Researchers in British Columbia have performed numerous crawls of YouTube data throughout 2007 and 2008.  This data starts with the most popular videos for the day, then goes on to the new videos that they have links to and so forth, for up to four levels of depth.  This data is available at http://netsg.cs.sfu.ca/youtubedata/

Coming Up With Our Research Idea
While initially exploring the data, we decided that there was way too much data to do any processing in a reasonable amount of time with reasonable equipment.  So, we picked a crawl from one day, March 27, 2008.  Even this proved to be a massive amount of data.  Just to play around with the data in Weka we chose only the first 3 of 4 levels of crawling and we also eliminated the ID's of related videos, preferring to concentrate just on the individual videos and their specific statistics.

In order to initially explore the data, we decided to try some clustering and classification techniques.  Clustering seemed to generally group around the different categories the videos fit into (see clustering_vis.jpg).  Thus, we first decided to explore with classification on category.  This proved not to be very successful.  The best results we were able to achieve were with the Bayesian Network giving about 44% correctly classified instances (see BayesNet.txt).

After exploring with classification on some other attributes, views (the number of views) returned suprisingly good results.  We were getting in the 98%, 99% range of correctly classified instances.  This was really surprising until we realized that the number of views, the number of ratings, and the number of comments were all very closely correlated (see views_comments.jpg, views_ratings.jpg, comments_ratings.jpg).

Therefore, we set out to do some attribute reduction.  Video ID could be eliminated, it was a unique identifier.  The uploader names were also very rarely repeated and presented a huge amount of processing with 27,820 distinct nominal values.  These we decided to eliminate for the moment.  We also eliminated ratings and comments because of the almost repetitive correlation they had with number of views as described above.  This left us with age (of video), category, length (of video), views, and rate (it's rating from 0-5).

Length and views presented the additional problem of containing large amounts of numeric data.  It seemed best to discretize these attributes, however, these attributes tended to have a lot of lower values and fewer very high values.  The bins we obtained during discretization tended to lump all the lower values together and then make a bunch of bins for the individual higher values.  So, we set the useEqualFrequency flag in Weka in order to even out the number of instances to be found in each bin.  Also, rate is a continuous rating along a scale from 0 to 5, but it seemed like analysis would be simpler if we discretized this attribute into bins from (0,1] (1,2] etc, so we also did this.

Once this processing had been achieved, classification was performed again.  This time the classification for views did very poorly (aroung 20-30% correctly classified).  We did find, though, that a classifier to predict rate (the average rating given to the video) performed pretty decently, around 72% correctly classified instances with J48 (see J48_rate.txt).

This, finally, gave us a goal for classification.  We decided to see how accurately we could predict the ratings for videos based on some basic information about uploader, age, category, length, and views.
