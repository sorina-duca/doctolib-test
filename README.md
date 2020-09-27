## practice based on Technical Test @ Doctolib

The goal is to write an algorithm that finds availabilities in an agenda depending on the events attached to it. The main method has a start date for input and is looking for the availabilities over the next 7 days.

There are two kinds of events:

'opening', are the openings for a specific day and they can be reccuring week by week.
'appointment', times when the doctor is already booked.
To init the project:

rails new doctolib-test
rails g model event starts_at:datetime ends_at:datetime kind:string weekly_recurring:boolean
Your Mission:

contained in two files named event.rb and event_test.rb
must pass the unit tests 

https://gist.github.com/VanNayer/52e800ba7bfc402986f2

