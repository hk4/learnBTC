# Final Project
Final Project slides: https://docs.google.com/presentation/d/1DGN9YsIl6lLFxN97tFLm5QK1oNESXSJxx_sIAVSHq74

## Overview
The application currently:
* displays BTC price over a range of time
	* X-axis = closing USD price
	* Y-axis = date (demarcated by hour)
* swipe left in GraphView to go to TableView
* swipe right in TableView to go to GraphView
* set labelled UIDatePickers to modulate range of GraphView
* tap and drag to select specific data point on GraphView
* constraints on UI elements to allow for vertical and horizontal view on iPads (iPhone devices can only support horizontal view as UIDatePicker's size is self-determined and cannot be manipulated easily to be smaller. Has full functionality but the UI is distorted due to UIDatePicker's fixed size)
* BTC price data parsing and abstraction // also allows for array slicing of data abstraction to get specific ranges of BTC price data based on date
* Twitter data parsing and abstraction (uses Utter Kit for .json parsing) // also allows for array slicing of data abstraction to get specific ranges of Twitter data based on date
* Add functionality to SwiftChart (imported library for visualization) to store Dates of data points internally and access Dates
* Add functionality to UtterKit (imported library for TwitterKit and Swift-interface for TwitterKit) to process stored canned data. Replaced internal canned Tweets (about Barack Obama and cows) with project's canned Twitter data (BTC and friends)
* GraphView has segue that sends specific range of Twitter data (based on the currently selected datapoint's date value) to the TableView to display data analytics for just the selected datapoint's date

The application currently does not:
* handle zoom and panning gestures. Can be implemented with a bit more time, as underlying array slicing method exists.
* more complex Twitter analytics. Can be easily implemented with a bit mroe time, as methods will only access and manipulate internal array of Tweets, tweets : [Tweet]
* live, free and public historic price data API does not exist so API-connection is not possible.
* live Twitter conneciton is not implemented, but should not be too difficult with UtterKit

Things that need to be fixed but no one has time for:
* reformat .json files of canned tweets to match UtterKit parser. It was a hassle to do for one, will not repeat for 12 other very large .json files

Note: TableView = TwitterDataTableViewController, GraphView = PriceGraphViewController (no relation to prior classes used in GraphADT/GraphViz/Social Networks/other labs)

## Vision Statement
The goal of learnBTC is to provide a better qualitative method of analyzing bitcoin price trends to social activity on Twitter. The purpose of learnBTC is as an independent analysis tool for understanding the relationship between bitcoin price and Twitter activity. Twitter activity was selected to understand the true scope and impact of Bitcoin on the general population. This Twitter activity represents a sampled portion of the population in order to see how relevant, prevalent, and active BTC actually is to the entire population. Thus, we will be able to meaningfully investigate the relationship between Twitter activity and bitcoin price fluctuations.

## Feature List
### Bitcoin Price Graph
* Display graph of BTC price over a domain of dates and a codomain of BTC price. 
  * Parse and store BTC price data from .csv files
  * Pan and zoom gestures for manipulating domain of dates
  * Drag gesture to hover over BTC price values
  * Tap gesture or releasing drag gesture will select a specific point within the graph
  * Inputable and labelled textboxes for start and end date to change the range of dates
  * Swipe right gesture to segue to Twitter Data Analytics View
### Twitter Data Analytics View
* See basic statistics (frequency, total volume of tweets, most frequent words, most mentioned users, most used hashtags) for a specific date.
  * Parse and store Twitter data from .json files
  * Connect to Twitter API through UtterKit
  * Users will be able to select a point on the graph, and then segue (via a right swipe) to a new Table View with the aforementioned statistics.
### Tentative Features pending Time/Resources
* Create more complex statistics for analyzing Twitter data: 
  * Example - display a graph-edge representation of users mentions and interactions (such as replies, retweets, likes) for a specific date
* Backend implementation for getting live BTC prices and live Twitter data
  * Need public (and free) BTC price API to get historic BTC price data from
  * Need to fix initalization and utilization of UtterKit
* More interactive components that give further access and describe Twitter data: allow user to tap on specific tweets and bring up subviews with more information, be able to access users' profile pictures, etc
* Grab articles and news pieces from online news outlets and display them next to a specific date or time when the user zooms in on a specific section

## UI Sketches

## Key Use Cases
* Graph Navigation
	1. User launches app
	2. The priceView graph is shown: BTC price over a range of dates (ie, the month of November 2018) is displayed
	3. User performs zoom and pan gestures
	4. priceView graph is adjusted accordingly
	5. User drags over priceView graph, and a point on the priceView graph is highlighted with a pop-up displaying price
* Get Twitter Data for Specific Date
	1. User launches app
	2. priceView graph is displayed
	3. User clicks on a portion of the priceView graph and a specific point is highlighted / drags over the priceView graph to highlight a specific point
 	4. User swipes right on the priceView graph, seguing to a a new view called detailView with the Twitter data for the selected date point
	5. User can swipe left on the detailView to segue back to the priceView graph
	
## Domain Analysis
The underlying domain is the range of bitcoin and cryptocurrency-related topics and terms.

For each point in time when the user clicks on a point, the background controller will do search calls for a list of terms and words by doing calls to Twitter API through the UtterKit. The bitcoin price will be stored internally for a fixed set of dates, however, functionality for live bitcoin price updates will be worked out later on.

For the beginning of the project, we will gather canned Twitter data by grabbing tweets with relevant keywords from Twitter's Streaming API. The relevant keywords are: 'bitcoin', 'cryptocurrency', 'ethereum', and 'BTC'. Historic bitcoin price data will be taken from bitcoincharts.com and stored as a .csv file that is parsed.


## Architecture
### Independent Components
#### Twitter Mining
In order to have enough canned data to sufficiently run the program without access to
calls to Twitter's API, Twitter data was mined with a Python script that connected
to Twitter's Streaming API and filtered for the following keywords: 'bitcoin', 'cryptocurrency', 
'ethereum', 'BTC'. A parser will be written to translate the data into the program's abstract 
state. Currently, data is saved in a .txt file, being a continuous stream of Tweets encapsulated in
.json and they will be consolidated by date into a single .json file for each day.

In order to connect and scrape data from Twitter's Streaming API, run the following
command in terminal. The script will take data over a seven day period. 
Technical Note: running the script in a virtual environment is suggested.

```shell
python twitter_streaming.py > twitter_data.txt
```

Canned data was further broken down into <100 MB files to accommodate Github’s file size limitations.

#### Historic Bitcoin Price Data Collection
As a public and free BTC price API has not been discovered yet to do GET requests for historic data, this price data was manually collected from bitcoincharts.com and saved as a .csv file that will be parsed and interpreted by the application. 

### Main Architecture
#### learnBTC
Currently, there are three major components that need to be built:
- Twitter Interpreter that translates .json files containing historic Twitter data and 
converting it into its internal abstract representation. 
- GraphViewController that displays a line graph detailing the changes to bitcoin (BTC)
price over a range of time. (Technical Note: this will NOT be the GraphView or GraphADT,
unless both were modified/rewritten accordingly to fit the new specifications.)
- DataViewController that displays a small pop-up giving basic Twitter data analysis
and potentially random "highlighted" Tweets when prompted for regarding the topic. 

The data abstraction will most likely be a large internal array of Tweets (sorted by
time, most likely) for each topic followed by bisections of this array when a 
range of dates are provided. Random, highlighted Tweets will simply be accessing single
elements of the array so O(1) time, and creating basic Twitter data analysis will be
linearly going through the entire array of Tweets so O(n) time. Specifically,
the density of Tweets (the number of Tweets at particular times)--maybe calculating
the derivative of the volume of Tweets mapped to time at moments--, the total volume of Tweets, 
the top ten (or some arbitrary number like five) most frequently used words (excluding pronouns,
articles, and other words with little to no meaning and relevance).

Later on, an expensive operation could be implemented would be to continuously go through the data
and update the strength of relations between changes to BTC price and most frequent.
This would be to study the potential effects of "buzz-words" such as "crashing", 
"decrease", "increase", etc.
