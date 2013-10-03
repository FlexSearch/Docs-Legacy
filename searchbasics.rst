Search Basics
===============

FlexSearch follows a consistent search dsl to execute all kind of search request. This enables a unified search experience for the developers. Before getting into the various types of search queries supported by FlexSearch we will cover the basic search mechanics.

The basic search request structure is as follows:

.. code:: javascript

    { 
      "Columns" : [ "String" ],
      "Count" : 0,
      "Highlight" : { 
          "FragmentsToReturn" : 0,
          "HighlightedFields" : [ "String" ],
          "PostTag" : "String",
          "PreTag" : "String"
        },
      "IndexName" : "String",
      "OrderBy" : "String",
      "Query" : { 
          "Conditions" : [ 
              { 
                "Boost" : 0,
                "FieldName" : "String",                
                "Operator" : "String",
                "Parameters" : { "String" : "String" },
                "Values" : [ "String" ]
              } ],
          "FilterType" : "And",
          "SubFilters" : [ {  } ]
                    } ]
              } ]
        },
      "Skip" : 0
    }

.. csv-table::
    :header: "Parameter", "Default", "Type", "Description"
    :widths: 5, 5, 5, 30

    "``Columns``","None","Array","Columns to be returned as a part of search result. Use '*' to return all columns. Specifiying no columns returns nothing. ``Note``: You still get id, lastmodified and type column back."
    "``Count``","10","int","The number of results to be returned."
    "``IndexName``","required","string","Name of the index to be searched."
    "``OrderBy``","Relevance","string","The field which is used to sort the results. But default the results are ordered by relevance."
    "``Skip``","0","int","The total number of records to be skipped from the top. Useful for implementing paging."
    
Query Format
--------------
A query in FlexSearch consist of a top level filter. Filters can be used build a query that expresses multiple conditions. Each filter has a type associated with it: AND/OR. The type of filter is used for logical evaluation of the conditions. Filters can have sub filters to represent complex logic.

::

    Filter
        +-- Conditions
        +-- FilterType
        +-- SubFilters 
        
For example, you can create a query that is the equivalent of a SQL statement such as [FirstName] = 'alan' AND [LastName] = 'harper' AND ([City] = 'london' OR [City] = 'southampton'). 

::

    Conceptual Organisation
    
    And (FilterType)
      +-- FirstName = 'alan' (Condition)
      +-- LastName = 'harper' (Condition)
      +-- Or (FilterType) (SubFilter)
          +-- city = 'london' (Condition)
          +-- city = 'southampton' (Condition)

.. csv-table::
    :header: "Parameter", "Default", "Type", "Description"
    :widths: 5, 5, 5, 30

    "``Boost``","1","int","Documents matching this condition will (in addition to the normal weightings) have their score multiplied by boost value. Boost cannot be less than 1."
    "``FieldName``","Required","string","The name of the field on which the condition should be applied."
    "``Operator``","Required","string","FlexSearch supports a number of query types and operator defines the name of the query which should be executed."
    "``Parameters``","","array","Any query specific parameters required by the operator."
    "``Values``","required","array","The values which are to be searched."
	
Operator Types
----------------
Term Match (term_match)
^^^^^^^^^^^^^^^^^^^^^^^^^^^
A Query that matches documents containing a term. This may be combined with other terms with a BooleanQuery.

.. csv-table::
    :header: "Parameter", "Default", "Type", "Description"
    :widths: 5, 5, 5, 30

    "``clausetype``","and","string","In case more than one term is searched then the query is converted into a number of sub-queries and the clausetype operator is used to determine the matching logic. For example an ``and`` clause will match all the terms passed to the query."

	
Fuzzy Match (fuzzy_match)
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Implements the fuzzy search query. The similarity measurement is based on the Damerau-Levenshtein (optimal string alignment) algorithm. At most, this query will match terms up to 2 edits. Higher distances, are generally not useful and will match a significant amount of the term dictionary. If you really want this, consider using an n-gram indexing technique (such as the SpellChecker in the suggest module) instead.
	
.. csv-table::
    :header: "Parameter", "Default", "Type", "Description"
    :widths: 5, 5, 5, 30

    "``prefixlength``","0","int","Length of common (non-fuzzy) prefix."    
    "``slop``","1","int","The number of allowed edits"

	
Phrase Match (phrase_match)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A Query that matches documents containing a particular sequence of terms. A PhraseQuery is built by QueryParser for input like "new york".

.. csv-table::
    :header: "Parameter", "Default", "Type", "Description"
    :widths: 5, 5, 5, 30
  
    "``slop``","1","int","The number of allowed edits"
	
WildcardQuery (like)
^^^^^^^^^^^^^^^^^^^^^

Implements the wildcard search query. Supported wildcards are \*, which matches any character sequence (including the empty one), and ?, which matches any single character. '\' is the escape character. Note this query can be slow, as it needs to iterate over many terms. In order to prevent extremely slow WildcardQueries, a Wildcard term should not start with the wildcard \*

Numeric Range (numeric_range)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A Query that matches numeric values within a specified range. To use this, you must first index the numeric values using Int. DateTime, Date or Double. 

.. csv-table::
    :header: "Parameter", "Default", "Type", "Description"
    :widths: 5, 5, 5, 30

    "``includelower``","false","bool","Include lower term"    
    "``includeupper``","false","bool","Include upper term"
	
String Range (string_range)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A Query that matches documents within an range of terms. This query matches the documents looking for terms that fall into the supplied range according to Byte.compareTo(Byte). It is not intended for numerical ranges; use NumericRangeQuery instead.

.. csv-table::
    :header: "Parameter", "Default", "Type", "Description"
    :widths: 5, 5, 5, 30

    "``includelower``","false","bool","Include lower term"    
    "``includeupper``","false","bool","Include upper term"