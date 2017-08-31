# fb-info

# My Approach

I first installed Facebook through Cocoapods. I was determined to use the Swift Wrapped Fb SDK. Last time I tried, it was a mess. Its crazy how horrible the docs are for the Swift implementation. 
        
Then I started to test to see if I could properly get the Fb info that was needed to complete the challenge.

I started to create auto layout constraints for the login button. I also created a custom UIView that would display the User's fb info. I chose a custom UIView because I find them highly reusable. I could easily stick in a UITableView or UICollectionView.

Then I began to create an User Struct so I could use easily access the fb info. I chose a struct but they are light weight, value types, and only need to store a few values. 	

After that, I implemented an asynchronous call to fetch the imageData to display.   

Finally I spent time making sure my code was neatly organized and that I chose explanatory function and variable names. 

Let me know if you have any questions/problems/concerns! 

- Mason
