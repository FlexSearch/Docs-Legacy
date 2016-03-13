*Predefined Queries* (previously known as *Search Profiles*) are search queries saved against an index. They are very helpful when you have a piece of code in your system that should always call the same query, and possibly supply some parameters to it if necessary. Instead of storing the search query inside your system, you can store it in FlexSearch. The advantages are:

* you have a centralized system where you store all your predefined queries
* you can easily modify them and the changes will be instant accross all references to this query
* you can test it faster using the *Search Studio* app in the FlexSearch Portal
* better organization of your queries, allowing you to find and analyze them quicker

### Example

This is a part of the `country` index configuration, showing the predefined query `agriSearch`.

```json
"predefinedQueries": [
    {
      "queryName": "agriSearch",
      "columns": [
        "countryname",
        "agriproducts"
      ],
      "count": 10,
      "indexName": "country",
      "orderBy": "score",
      "orderByDirection": "Ascending",
      "cutOff": 0.0,
      "distinctBy": "",
      "skip": 0,
      "queryString": "allof(agriproducts, 'wheat', 'corn', 'grapes') AND like(countryname, @countryName, -matchall)",
      "returnScore": true,
      "preSearchScript": "",
      "overridePredefinedQueryOptions": false,
      "returnEmptyStringForNull": true,
      "variables": {}
    }
  ]
```

A *predefined query* is actually a saved `SearchQuery` object. 
The most important (and mandatory) properties are:

* `QueryName`: this property is only mandatory in the case of *Predefined Queries*. If this isn't populated, then a `ValidationException` error will be returned. It holds the name of the *predefined query*
* `QueryString`: describes the query to submit to FlexSearch
* `IndexName`: the index to execute the query against
* `Columns`: this property isn't mandatory, though it will default to `[]`, which means no fields would be returned from a search. This property holds the list of fields that you want to be returned by the search.

<a name="plain-english"></a>
Here is how the definition would sound in plain English:

* We have a *predefined query* named **agriSearch**
* Whenever the query is invoked, we want it to return 2 columns: **countryname** and **agriproducts**
* We want the query to return at most **10** records
* The query will search against the **country** index
* The results will be ordered by their **score** in the **ascending** direction
* We will only consider the records that have a score higher than or equal to **0.0**
* We **don't** want to bring only the records that are distinct. We will take all records.
* We want to skip the first **0** records from the result, i.e. bring all records from the beginning.
* Use the following search query: **allof(agriproducts, 'wheat', 'corn', 'grapes') AND like(countryname, @countryName, -matchall)**
* **Yes**, please include the value of the score within each returned document
* We **don't** want to use any *PreSearch Script*
* We **don't** want to override the *predefined query* options that we've set here with the options that we submit in the search URL. 
    
    E.g. calling `http://localhost:9800/indices/country?queryname=agrisearch&count=3` will not overwrite the count value of `10` with `3`.
* **Yes**, please return an empty string if a field has the `null` value.
* We **aren't** supplying any values for the variables in the query

### Note

The name of the variable in this particular case (`countryName`) is just a coincidence it's named the same as a field in the `country` index. You can have any name you want for a variable.

### Create or Update a Predefined Query

Please see the [Creating or Updating a Predefined Query] tutorial.

### Using a Predefined Query

Please see the [Searching with a predefined query] tutorial.

[Creating or Updating a Predefined Query]: https://flexsearch.net/docs/guides/working-with-predefined-queries
[Searching with a predefined query]: https://flexsearch.net/docs/guides/searching-with-a-predefined-query