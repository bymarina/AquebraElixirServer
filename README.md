# AquebraElixirServer

This is a Phoenix Elixir server used in my completion of course work of Computer Engineering in UTFPR. Aquebra is the name of the application being developed, it is about the creation of a logistics algorithm for the distribution of breaking foodstuffs in the city of Curitiba.

This project can be divided in two parts:

One Phoenix API connection to basic endpoits to communicate with the database.
 
A logistic of distribution of breaking foodstuffs that uses a Genetic Algorithm to define the best routes of donation that would be perfomed by a volunteer. It considers the usual route performed by this volunteer (fixed routine start and end point), possible points to collect and deliver donations, aswell as donation availability in the collect point. The Genetic Algorithm works to find the routes with less extra distance to be performed by the volunteer but respecting the availability of donations in the collect points.
