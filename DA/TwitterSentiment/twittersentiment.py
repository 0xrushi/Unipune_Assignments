from textblob import TextBlob
import re
import pandas as pd    

df = pd.read_csv("tweets.csv",usecols=['tweet'])

def clean_tweet(tweet):
    tweet=tweet.lower()
    t = ' '.join(re.sub("(@[A-Za-z0-9]+)|([^0-9A-Za-z \t])|(https?:\/\/.*[\r\n]*)"," ",tweet).split())
    t=t.replace("RT ","")
    return t
    
def get_tweet_sentiment(tweet):
    analysis=TextBlob(clean_tweet(tweet))
    if analysis.sentiment.polarity  >0 :
        return 'positive'
    elif analysis.sentiment.polarity  <0 :
        return 'negative'
    else:
        return 'neutral'
    
def get_tweets(query,count=10):
    tweets=[]
    #fetched_tweets = api.search(q=query,count=count)
    fetched_tweets=df.values.tolist()
    for tweet in fetched_tweets:
        parsed_tweet={}
        parsed_tweet['text']=tweet[0]
        parsed_tweet['sentiment']=get_tweet_sentiment(clean_tweet(tweet[0]))
        tweets.append(parsed_tweet)
    return tweets
    

tweets=get_tweets(query = "Donald Trump" , count=100)

ptweets = [tweet for tweet in tweets if tweet['sentiment']=='positive']
ntweets = [tweet for tweet in tweets if tweet['sentiment']=='negative']