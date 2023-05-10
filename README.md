# ShoppingCartTech test for Reveri
 
## As per the spec, I've excluded items that there wasn't time for ...

The product and cart screens are working as required, but I didn't have have time to get to the bottom of why the quantity only updates the first item you add to the cart for a product
 and why onthe shopping cart the quantities don't update (even though they are updating in the model)

#### API 
The API class is very very basic, but it does the job of getting the products. 
I missed out proper error handling etc, as the focus was to just get the data and display in the app

#### The persistence
I didn't implement this in the end, although I left the code that might make the call in place  
    eg. .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }

#### Accessibility
I didn't implement accessibility identifiers, but I did test dynamic font sizes in the previews and, although they don't look stunning, it wasn't so bad 


## Things I'd have improved on if this were a real project
I didn't spend a huge amount of time on the UI, but hopefully it looks reasonable
Images - I just used the AsyncImage as this was the quickest to implement.
I don't think it would lend itself easily to the persistence etc

I included a simple rating view, this only does full stars for now, as I didn't have time to let it cater for fractions.
I still feel it looks better than just a number


## Some other notes
I did a basic reusable component ProductComponentView, with a styler struct that contains some common style elements.
The idea being that you could inject a different style for different branding etc (eg if you have 1 codebase for 2 apps)

It was a bit strange pulling from the API but not writing things like the stock back to it, so there is some clunky functionality around that

I created an APIProduct struct that was the codable one to bring in from the API.
I then tranformed those into Products. I'd normally want to do this to add a layer of separation, and also if you were to have multiple data sources to provide products for example

There are a bunch of print statements just to help me debug at this stage. Normally I'd use a logger package and have different levels of logging available, but not for this simple project.

