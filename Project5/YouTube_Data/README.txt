YouTube Data is from http://netsg.cs.sfu.ca/youtubedata/


General Description of Attributes from this Site:
video ID	an 11-digit string, which is unique

uploader	a string of the video uploader's username

age		an integer number of days between the date when the video was uploaded and Feb.15, 2007 (YouTube's establishment)

category	a string of the video category chosen by the uploader

length	an integer number of the video length

views		an integer number of the views

rate		a float number of the video rate

ratings	an integer number of the ratings

comments	an integer number of the comments

related IDs	up to 20 strings of the related video IDs 


0.txt contains the data from the first layer of a Breadth-First Search of YouTube, providing the most popular videos of the day and related IDs of movies they are linked to.  log.txt is a log of the crawl.