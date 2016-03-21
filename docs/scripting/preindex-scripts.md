### Definition

*PreIndex scripts* are F# methods that execute a piece of code just before indexing occurs. They are perfect when you want to populate or update some fields in a document and persist that change. Compared to *pre-search scripts*, in *pre-index scripts* the new values of the document fields will be stored in the index and visible each time you search for it.

*Pre-index scripts* are declared in the same file as the *pre-search scripts* are, namely `scripts.fsx` in the index configuration folder. 

Just like any other script, *pre-index* scripts are loaded when FlexSearch server starts or when an index is reloaded.

### Usage

*Pre-index scripts* are used when you want to modify the data that will end up in the index during indexing time (when adding or updating documents).

The name of the F# method that holds the pre-index script logic is `preIndex`.

The signature of the method is:

```fsharp
val preIndex : Document -> unit

e.g.
let preIndex (document : Document) = ()
```

This translates to a method that takes a `Document` as a parameter and returns nothing (`void`).

The `preIndex` method needs to be placed in the `script.fsx` file located in the index configuration folder. For example, if you have an index named `contact`, the `script.fsx` file would need to be in:

```
/conf/indices/contact/script.fsx
```

The way the *pre-index scripts* are designed to work is:

- 1 -- a `Document` is received for indexing. Its fields are either empty or prepopulated with some data.
- 2 -- the `preIndex` function runs against the received `Document`. This function will either modify, populate or empty some fields in the document.
- 3 -- the modified `Document` is then passed to *Lucene* to index, store the data and make it available for searching.

### Example

Let's then imagine we want to populate the `gender` field from the `employee` index according to the `title` field - if it's *Mr.*,  then it's *Male*, otherwise *Female*. Here is part of the definition of the `employee` index:

```json
{
  "indexName": "employee",
  "fields": [
    {
      "allowSort": false,
      "fieldName": "gender",
      "fieldType": "Text",
      "indexAnalyzer": "standard",
      "searchAnalyzer": "standard",
      "similarity": "TFIDF"
    },{
      "allowSort": false,
      "fieldName": "title",
      "fieldType": "Text",
      "indexAnalyzer": "standard",
      "searchAnalyzer": "standard",
      "similarity": "TFIDF"
    },
    ...
  ],
  ...  
}
```

We would then write the following code in the `scripts.fsx` file.

```csharp
module Script

open FlexSearch.Api.Model
open Helpers
open System

let preIndex (document : Document) = 
    // Get the title field value from the document and make it lowercase
    match document.Get("title").ToLower() with
    | "mr." -> document.Set("gender", "Male")   // If it's `Mr.` then set the gender to Male
    | "" -> ()                                  // If it's empty then don't set the gender
    | _ -> document.Set("gender", "Female")     // Anything else is Female 
```

The new piece of functionality will be loaded the next time FlexSearch is restarted or when the `employee` index is reloaded (`closed` then `opened` back).