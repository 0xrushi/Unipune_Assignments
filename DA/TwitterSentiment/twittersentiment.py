from textblob import TextBlob
import re
import pandas as pd    

df = pd.read_csv("tweets.csv",usecols=['tweet'])
    
def get_tweet_sentiment(tweet):
    analysis=TextBlob(tweet)
    if analysis.sentiment.polarity  >0 :
        return 'positive'
    elif analysis.sentiment.polarity  <0 :
        return 'negative'
    else:
        return 'neutral'
    
def get_tweets():
    tweets=[]
    #fetched_tweets = api.search(q=query,count=count)
    fetched_tweets=df.values.tolist()
    for tweet in fetched_tweets:
        parsed_tweet={}
        parsed_tweet['text']=tweet[0]
        parsed_tweet['sentiment']=get_tweet_sentiment(tweet[0])
        tweets.append(parsed_tweet)
    return tweets
    

tweets=get_tweets()

ptweets = [tweet for tweet in tweets if tweet['sentiment']=='positive']
ntweets = [tweet for tweet in tweets if tweet['sentiment']=='negative']

print(ptweets)
print(ntweets)