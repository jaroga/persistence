We need to build the last bit of functionality left in our app. We should be able to persist all information comming from our API related to Gas Prices and update it regularly.

Tasks: 

- Add GasStation and GasProduct Entities to our Persistence Model
- Properly manage whether data should be read from our Local Data Source or from the API. Take into account that data should be updated after 30 minutes. 
- Create GasStationsListView + GasStationsListViewModel and show the fetched results in ASC order (from cheaper to more expensive)
- Add a button that allows the user to force the API request to be repeated
