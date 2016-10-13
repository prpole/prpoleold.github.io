---
layout: post
title: Semantic Analysis of One Million #GamerGate Tweets Using Semantic Category Correlations
author: 
- name: Phillip R. Polefrone
  affiliation: Columbia University, Department of English and Comparative Literature
  email: prpolefrone@columbia.edu
date: August 2016
abstract: | 
    This paper develops a methodology for describing the contents of
    a controversy on a microblogging platform (Twitter) by measuring correlations
    in broad semantic categories. Over one million tweets were gathered daily from
    November 2015 to June 2016 using Tweepy and the Twitter API, over 280,000 of
    which were not retweets and thus contained unique data. Using a Python
    implementation of Roget's hierarchy of semantic categories, these tweets were
    collected in bins of one thousand and analyzed using a "bag of categories"
    model, or a categorized bag of words. The linear correlation of each category with the
    "WOMAN" category was measured and compared with a control group. The categories
    concomitant with "WOMAN" in the test corpus include some noise, but over all
    present a meaningful description of the conversation that adheres to its known
    qualities. This result suggests that a more developed version of this
    methodology could be used to detect conversational trends on social media
    platforms more easily and with less human labor than other similar methods.
keywords: GamerGate, twitter, semantic analysis, social media, roget
authorfootnote: |
    Phillip R. Polefrone is a PhD Candidate at Columbia's
    Department of English Literature. He works primarily on twentieth-century
    American fiction, ecocriticism, and computational methods in the humanities. 
bibliography: research_report.bib
csl: language-in-society.csl
geometry: margin=1in
image:
  feature: texture-feature-06.jpg
  credit: from Max Ernst, illustration for 'Une Semaine de Bonté'
--- 

Introduction
===============

At present, the common methodologies used to perform semantic analysis of
social media content present many limitations. Much of the existing work on the
topic of online harrassment uses network analysis [@baio_72_2014] or sentiment
analysis [@wofford_is_2014], neither of which takes the specific semantic
meaning of the posts themselves into account. Although the possibilities
afforded by network analysis are exciting, it derives conclusions primarily
from who is connected to whom, not the contents of any message sent. Sentiment
analysis abstracts word meanings into a numeric value of positive or negative
sentiment from a dictionary of human-supplied sentiment ratings. While widely
utilized, reducing semantic content to a single vector limits the
meaningfulness and scope of the conclusions that can be drawn from it. By far
the most promising of the common methods is the application of machine learning
and statistical modeling techniques [@ostrowski_using_2015;
@burnap_cyber_2015], but the requirements of these methods are at odds with the
nature of many social media platforms. The need for large samples is
inconsistent with the medium's usual brevity, while the need for human-generated
training corpora makes keeping up with rapidly evolving conversations
impractical. There is, then, a disconnect between methods that are flexible
enough to keep up with the medium and those that are robust enough to provide
meaningful conclusions.

This presents a potentially existential problem for social media platforms and
their users. Platforms such as Twitter intends to give all users an equal
platform, but ungoverned usage limits the ability of many women as well as
racial, religious, and sexual minorities to enter these forums without fear of
harrassment or worse. The difficulty that faces a company trying to
semantically classify posts automatically while keeping up with shifting topics
means that a culture of harrassment is able to persist and keep some users from
the freedoms others enjoy. A method to provide more meaningful semantic
analysis of posts in real time could ease the governance of these forums and
ultimately help protect the right of all users to express themselves online.

The purpose of this paper is to outline and begin developing a method that uses
broad semantic categories, derived from a hierarchy introduced in Roget's
thesaurus, to detect the semantic content of social media trends. I will
evaluate this method based on its ability to describe the content of the
Twitter conversation marked by the \#GamerGate hashtag, which has notoriously
led to harrassment and silencing of marginalized groups in the videogaming
community. I will analyze the raw counts of these categories using a "bag of
categories" model in which a bag of words derived from a bin of one thousand
tweets is replaced with the categories that describe each word. After
normalizing these counts according to the total number of words in each bin,
I will calculate the linear correlation of each word category with the "WOMAN"
category. Finally, I will evaluate the resulting correlations by comparing them
with a control group of 1.6 million tweets gathered by Stanford's Sentiment140
group [-@sentiment140_sentiment140_2009].

I expect this approach to yield a sense of how a certain topic is being
discussed by identifying correlative categories, or in other words, categories
that covary according to shifts in the conversation. This study uses
a much-discussed controversy so that its known features can be used to evaluate
two factors: the extent to which the method is descriptive and the manner of
its description. Because the method is still naïve in ways described below,
I expect some correlative categories to be descriptive and some to either
qualify as noise or be difficult to interpret. In particular, I expect the
categories that correlate with the "WOMAN" category to illustrate the
harrassment and denigration that has characterized the discussion, as well as
the recourse to "freedom of speech" rhetoric that pro-GamerGaters are known to
use as a smokescreen. 

This approach rests on several basic assumptions. The first is that \#GamerGate
is a movement devoted to maintaining gaming culture's domination by white
heterosexual males, and that it achieves its goals by harrassing, threatening,
and overwhelming its opponents. This interpretation is consistent with most
examinations of the movement beyond the pro-\#GamerGate contingent itself, but
those within the movement frequently claim it is about "media
ethics."[^media-ethics] Some might claim that this assumption constitutes
question-begging, but as I am evaluating the method's effectiveness according
to its ability to detect this trend rather than using the method to prove the
existence of the trend, it should not present an issue. My second assumption is
that Roget's word categories correspond meaningfully to a human understanding
of language. This assumption is supported by findings that methods built on
a Roget framework perform at a success rate similar to that of human users
[@jarmasz_rogets_2012; @mchale_comparison_1998; @klingenstein_civilizing_2014]. 

Several methodological difficulties persist that will limit my findings. First,
the tool I built to incorporate Roget's framework into a natural language
processing suite is based on the 1911 edition of Roget's thesaurus
[@roget_rogets_1991], meaning that fewer of the words will match the
word-category dictionary than would be the case with a more recent version. The
need for a digitized, plaintext version for automatic processing restricted me
to editions that had gone out of copyright, however, so without additional
resources, this problem will persist. Second, no edition of the thesaurus has
kept up with the rapidly changing contours of language on Twitter, meaning that
much semantically meaningful and relevant content has been excluded from the
model. Third, the rate of corresponodence between the words in the corpus and
those in the thesaurus could be improved by more sophisticated stemming and
lemmatization. Finally, and perhaps most significantly, the project is hindered
by Twitter's restrictive licensing policy, which has prevented me from
obtaining the most relevant data from the beginning of the hashtag's lifespan.
My data covers the second year of this lifespan, a period marked by
self-referentiality and rehashing of previous arguments, while the ideal
dataset would include data from the most volatile period (in the first month,
before the bulk of the press coverage had occurred) when threats and
harrassment were at their most extreme.

Several terms that require more explicit definition. A **category** will refer
to a numbered section in Roget's Thesaurus (1911). All categories refer to the
lowest level of abstraction in the category hierarchy, unless otherwise
indicated. (The full hierarchy is reconstructed in my "Roget Tools" based on
the headings and subheadings above each category, and other levels of
abstraction can be used.) A **mention** refers to a tweet that tags a user's
screen name with the "\@" sign, which causes notifications to be sent to that
user and the tweet to appear in the user's timeline. A **hashtag** refers to
a word or words preceded by a "\#" and not separated by white space; it is
a common convention on Twitter for linking tweets to an ongoing conversation.
A **supertweet** is a term coined by [grant_online_2011] to describe the
process of aggregating multiple tweets into bins for modeling and analysis.
Supertweets in this paper contain one thousand tweets unless otherwise
specified. A **bag of words** indicates a set of words to which order is
irrelevant. 

Review of Related Literature
============================

Two categories predominate in the literature relevant to this study:
computational studies of GamerGate and other instances of online harrassment,
and semantic analysis of text using Roget's or other word categories.

Studies of Online Harrassment
----------------------------

Andy Baio's "72 Hours of \#GamerGate" [-@baio_72_2014] collects and analyzes
the statistics of three days' worth of tweets using the "\#GamerGate" hashtag
and the associated users. He finds that ~69% of the tweets are retweets, which
is reflected in my dataset. He also found that many of the accounts responsible
have a very low "age," pointing out that "[r]oughly 25% of all Gamergate
activity is coming from accounts created in the last two months [as of October
2014]" while the average account age for a general sample has a more even
distribution [@baio_72_2014]. Significantly, the \#GamerGate hashtag is used ten
times more frequently by pro-Gamergate users than anti-Gamergate users, meaning
that findings using his hashtag disproportionately describe the pro-Gamergate
side of the debate.

Taylor Wofford and Newsweek's "Is Gamergate about Media Ethics or Harassing
Women? Harrassment, the Data Shows" [-@wofford_is_2014] uses sentiment analysis
performed by the company BrandWatch to analyze a corpus of tweets representing
the hashtag from September 1, 2014 to October 23, 2014. They found that
a female game developer (Zoe Quinn) was mentioned in fourteen times as many
tweets as a male game journalist (Nathan Grayson) despite both facing the same
accusation. The same trend was found when comparing male and female journalists
(Stephen Totilo and Leigh Alexander) writing in similar contexts. Although
tweets directed at Grayson and Totilo were classified as more negative than
those directed at Quinn, Alexander, and others, a greater number of negative
tweets were found to be directed at the female users studied. The quantity of
negative sentiment, then, taking into account the relative volume of tweets,
was found to be greater in the tweets received by the female users studied.

Pete Burnap and Matthew L. Williams analyze the proliferation of hate speech
following triggering events in "Cyber Hate Speech on Twitter: An Application of
Machine Classification and Statistical Modeling for Policy and Decision Making"
[@burnap_cyber_2015]. The authors demonstrate the applicability of machine
learning to social media contexts in which hate speech is present, using
syntactical pattern recognition and a human-tagged training corpus. 

Previous Applications of Roget's Categories for Semantic Analysis
-----------------------------------------------------------------

I was introduced to Roget's category hierarchy as a methodology at a talk by
Simon DeDeo on [@klingenstein_civilizing_2014], which uses these categories and
latent Dirichlet allocation to map the "civilizing" trend in verdicts from
London's Old Bailey legal archive. This study uses Roget's categories to
"coarse grain" the language of trial transcripts, studying the shifting logic
according to which crimes are classified as violent or non-violent. Latent
Dirichlet allocation has been an effective method of topic modeling in other
semantic studies of social media content as well, e.g. [@grant_online_2011].
I adopted their method of coarse-graining as well as adapting the method into
an open-source tool for this study.

Jarmasz and Spakowicz [-@jarmasz_rogets_2012] and McHale
[-@mchale_comparison_1998] have both demonstrated Roget-based methods' ability
to detect word similarity comparable to human users. The latter also finds that
the method compares favorably with WordNet, a similar tool. Stan Spakowicz has
done extensive additional studies of using Roget's thesaurus as a natural
language processing tool, including an exploration of automatic updating
[@kennedy_evaluation_2014].


Methodology
===========

My methodology can be divided into three main steps:

1. Gathering test and control data
2. Classifying words by Roget's categories
3. Determining category correlation coefficients for test and control data

Gathering test and control data
-------------------------------

I collected a live stream of tweets to create a corpus of test data by
scheduling a daily automatic query of Twitter's API. Using Tweepy
[-@tweepy_tweepy_2009], a Twitter API wrapper for Python, I gathered as many
tweets as possible that use the "\#GamerGate" tag between November 18, 2015 and
June 30, 2016, a total of 1,049,890 tweets. Scrubbed of retweets, the total was
281,449 tweets. To clean the data, I eliminated all tokens with
non-alphanumeric characters, including mentions and hashtags. 

My control data is taken from Sentiment140's corpus, a Stanford University
project that facilitates brand- and trend-based sentiment analysis
[@sentiment140_sentiment140_2009]. Using a range of queries, they gathered 1.6
million tweets, which I split into bins of 100,000 for comparison with the test
data.

Classifying words by Roget's categories
--------------------------------

To classify the words by category, Roget's thesaurus first had to be adapted
for use in a natural language processing environment. I transformed the 1911
edition of the text from Project Gutenberg [-@roget_rogets_1991] into a set of
nested Python dictionaries, creating a catalog of words in the thesaurus
according to the category or categories that describe them. In total, there are
1044 categories. Each of these categories can be traced up the hierarchy to
categories at a higher level of abstraction if desired, though only the lowest
level was used in this study. 

After a "bag of words" was made out of each bin of one thousand tweets, each
word was replaced by the category or categories that apply to it, resulting in
a "bag of categories" containing where applicable and null categories where
none applied. If a word fell into multiple categories, its ambiguity was
preserved by including all relevant categories in the bag. 

A frequency distribution was created for each bag of categories, providing
a count for each category, which was then normalized for the total word count
(categorized or not) for each bag. These normalized frequencies were recorded
in a spreadsheet for correlation calculation.

This process was applied to both the test and control corpora, except that the
test data used bins of 10,000 tweets and the control data used bins of 100,000
tweets. There were 282 bins for the test data and 108 bins for the control.


Determining category correlation coefficients for test and control data
---------------------------------------------------------------------

For each set of data, I calculated the linear correlation of each word category
with the "WOMAN" category across all the bags of categories derived from the
bins of one thousand tweets. I then isolated the categories that were
statistically significant (p<.05) for the number of samples. In the case of the
control data, I chose the top twenty-five categories, all of which correlated
to a degree that was statistically significant for the numer of samples.


Analysis of Data
================

Table 1 shows the categories that correlate with "WOMAN" in the test data, and
Table 2 shows these categories with the words in that category for additional
interpretive context. Many of the category names in themselves are
meaningful---"PENALTY" seems to point to calls for retribution by one side
against the other, while "OSTENTATION" could either indicate criticism of the
rhetoric of the other side of the argument or a common trope in criticizing
women for attention to appearances (hardly unique to GamerGate in the history
of misogyny). Other categories appear to be noise until the list of category
words is inspected carefully. The baffling "HORIZONTALITY," for example, comes
into focus when one considers that any instances of the word "lie" are being
interpreted quite literally as "making oneself horizontal" when classification
as an accusation of dishonesty would be more appropriate and meaningful. 

Trends can be detected in this list of category correlations:


Words of Conflict
-----------------

These are words that might appear as features of an argument regardless of the
context of that argument, particularly a bitter argument between two clear
sides that is defined by acrimony. Categories include:

- PENALTY, DECREMENT, DISCORD, INCREDULITY, PHYSICAL INSENSIBILITY, REGRESSION,
VIRTUE, DECEIVER, RELINQUISHMENT, HELL, NOBILITY, REPETITION, TROPHY, TRUTH,
INELEGANCE, HASTE, ENVY, MALEDICTION


Misogynistic Tropes
-------------------

Like "OSTENTATION," discussed above, these categories are familiar in the
history of vilifying women as a group. They include categories that, in
context, seem to imply a reduction of a person to appearance or physicality,
deemphasis of intellect, and implications of deception, dishonesty, or
manipulation. Categories include:

- MATERIALITY, OSTENTATION, HORIZONTALITY/DECEIVER, ORNAMENT, DIMNESS,
DECEIVER, PRODUCTIVENESS/PRODUCTION (birth, procreate, etc.), INGRATITUDE,
JEWELRY, APPEARANCE, JEWELRY

Sexual Language
----------------

This list is self-explanatory, but there are several categories that I am
including because the best explanation for the correlation with "WOMAN" is
miscategorization of modern sexual slang. (In these instances, I will include
the word in parenthesis.) Categories include:

- STREAM ("blow"), CARRIER ("ass"), SEXUALITY

These categories are almost entirely absent from the control group, as can be
seen in Figure 3. Indeed, the contrast is surprisingly clear: the categories
that most strongly correlate with women in the control group are almost
uniformly positive, so much so that there may be cause to look for experimental
error. The top four categories, 'FRIENDSHIP,' 'FAVORITE,' 'LOVE,'
'BENEVOLENCE,' tell the tale of the distribution, and none of the categories at
the top of the test distribution appear high up in the control group's list. It
appears that the category correlations exposed in the \#GamerGate tweets are
unique to that dataset.

Conclusions
============

As expected, this method of semantic analysis yielded results that are both
descriptive and legible---even more legible than expected. There is a clear
trend in these category correlations. In GamerGate's corner of Twitter, women
are discussed in terms of their material form and appearance, with reference to
common misogynistic tropes, and in an inflamatory manner characteristic
a bitter disputes. There is also a proliferation of sexual language that
accompanies these categories. The mixture of these broad categories describes
the trend that is visible to the human eye, but on a scale that exceeds what
a human user can parse in a comparable amount of time. 

Nevertheless, this is a naïve instantiation of the methodology that leaves much
more room for improvement. I did not deal with n-grams in this experiment,
despite the presence of n-grams in Roget's word dictionary. I also did not stem
or lemmatize the words, which could have reduced the number of words that fell
into a null category. Perhaps most important, I have not removed the archaic
entries or attempted to update the word dictionary in any way. This introduces
more noise into the system, but it also prevents the method from picking up
many more modern terms. Some means of implementing a more modern version of the
thesaurus, a means of manipulating WordNet data to add entries to the
dictionary, or a protocol for manual addenda could aid the process
considerably.

Confidence in my interpretations is impossible without broadening the study to
include other known controversies that are similarly acrimonious and have
a clear target of abuse. There is sadly no shortage of misogynistic hashtags on
Twitter, so replicating the results in other contexts should not present
a challenge. Doing so requires being able to get to the epicenter of
a controversy, though, and studying it from beginning to end. This will remain
difficult as long as Twitter's licensing agreements and terms of use remain as
obstructive as they currently are, so it is advisable to begin collecting data
as early as possible when a useful topic emerges.

Finally, a word on the purpose of this study. Developing automatic semantic
analysis is not meant as a first step in automatically blocking, punishing, or
censoring users. Rather, it is meant as a way of flagging certain topics for
monitoring by the governing bodies of a given social media forum. And contrary
to what a pro-Gamergater would surely say, the intention is not to censor the
speech of some users, but to make sure that everyone can participate in the
modern public forum online without fear of threats or harrassment. In a forum
as huge as a platform like Twitter, some degree of automation is required to
bring content to the attention of human arbiters. 

End Notes
========

[^media-ethics]: This claim is undercut by one of their key pieces of evidence.
The movement began with a campaign against Zoe Quinn, a game developer best
known as the creator of *Depression Quest*. Future participants in the movement
began harrassing Quinn, alleging that she exchanged sex for favorable reviews
for her games. It appears, however, that these claims began with a post by
a gilted ex-boyfriend, Eron Gjoni, which led to a cascade of misogynistic
comments and threats that have characterized the discourse since
[@parkin_zoe_2014].

Bibliography
===========

