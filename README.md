# ShoppingCartTech Demo

## Added this morning!
I've just brought in my logger, that I will soon be turning into a cocoapod. I just wanted to show that and some very basic logging.
Also, please note, I normally use gitflow, but this was just a quickly created repo, so it's just on the main branch.

### Introduction
This is a very simple SwiftUI Demo project. 
It just has a simple products screen and shopping cart screen.
 
#### API 
The API class is very very basic, but it does the job of getting the products. 
I missed out proper error handling etc, as the focus was to just get the data and display in the app

## Things I'd have improved on if this were a real project
I didn't spend a huge amount of time on the UI, but hopefully it looks reasonable
Images - I just used the AsyncImage as this was the quickest to implement.
I don't think it would lend itself easily to the persistence etc

I included a simple rating view, this only does full stars for now, as I didn't have time to let it cater for fractions.
I still feel it looks better than just a number

There is no real error handling or logging here, as it's just a quick demo project

## Some other notes
I did a basic reusable component ProductComponentView, with a styler struct that contains some common style elements.
The idea being that you could inject a different style for different branding etc (eg if you have 1 codebase for 2 apps)

It was a bit strange pulling from the API but not writing things like the stock back to it, so there is some clunky functionality around that

I created an APIProduct struct that was the codable one to bring in from the API.
I then tranformed those into Products. I'd normally want to do this to add a layer of separation, and also if you were to have multiple data sources to provide products for example

There are a bunch of print statements just to help me debug at this stage. Normally I'd use a logger package and have different levels of logging available, but not for this simple project.
