### Definition

A FlexSearch *pre-search script* is a snippet of F# code that gets executed before the search is run.

The source code of the script is loaded from the `script.fsx` file from the index configuration folder. A *PreSearch script* is a method within the `script.fsx` file that has a name starting with `preSearch` (e.g. `preSearchTest`).

Search scripts are loaded automatically on startup or when an index is opened. To add a new script you need to either restart the system or reload the index (`close`, then `open` it back again).


### Usage

Pre-search scripts are F# methods that get executed before the search is run. They are very helpful when you want to modify your query data.

For example, if you want to normalize an incoming telephone number to a certain format before submitting the search, then you would use a pre-search script.

Pre-search scripts are stored in a `script.fsx` file located in the index configuration folder. For example, if you have an index named `contact`, you would write the `script.fsx` file at:
```
/conf/indices/contact/script.fsx
```  

Pre-search script methods have the following naming convention:
```
preSearch<script_name>

e.g. preSearchTest
```

And the following signature:

```fsharp
val preSearch<script_name> : SearchQuery -> unit

e.g. 
let preSearchTest (query: SearchQuery) = ()
```

The above signature means that we should have a function that takes a `SearchQuery` and returns nothing (`void`).

Having a `FlexSearch.Api.Model.SearchQuery` as a parameter gives you access to get or even set any of its properties. For example you can modify the columns to retrieve, or execute some code conditionally based on the query name, or modify the query string, etc.

Probably the most powerful feature is the access to the `Variables` (the `@variable_name` pieces from the query string) property from the `Search Query`. This means you can modify the values that get passed into the query string.


#### Example

Let's say you want to bring all the employees that have been in the company for more than 10 years. We assume that we have an `employee` index with the following fields:

* `yearJoined`
* `name`

You can initially write the following query on the `employee` index:

```
gt(yearJoined, '2006')
```

And it will work just fine. But next year you'll realize you have to change the query from `2006` to `2007`. So here comes the variable to the rescue:

```
gt(yearJoined, @tenYearsAgo)
```

In this case you would add an entry in the `SearchQuery.Variables` dictionary for:

```csharp
searchQuery.Variables.Add("tenyearsago", DateTime.Now.AddYears(-10).Year)
```

And then you would submit this search query to FlexSearch. This would work as well, but maybe it would be easier if you would just pass the current year and then substract 10 from it before submitting the search. You could reuse this piece of functionality for other queries as well. You can do this using a pre-search script!

You modify the search query string like so:

```
gt(yearJoined, @year)
```

And you create a new file in the `Conf/Indices/employee` folder called `script.fsx` in which you add the following code:

```csharp
module Script

open FlexSearch.Api.Model
open Helpers
open System

let preSearchTenYearsAgo (query : SearchQuery) =
    // Get the variable called "year". Take care of upper vs lower case.
    let kvp = query.Variables
              |> Seq.find (fun kv -> kv.Key.ToLower() = "year")

    // Modify / populate its value
    kvp.Value <- DateTime.Now.AddYears(-10).Year
```

Lastly, before submitting the `SearchQuery` you just need to specify that you want to use the newly created pre-search query:

```
searchQuery.PreSearchScript = "TenYearsAgo";
```