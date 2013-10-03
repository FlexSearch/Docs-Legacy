Index Fields
======================

Document
----------

In FlexSearch a document represents the basic unit of information which can be added or retrieved from the index. A document consists of several fields. A field represents the actual data to be indexed. In database analogy an index can be considered as a table while a document is a row of that table. Like a table a FlexSearch document requires a fix schema and all fields should have a field type.

Fields can contain different kinds of data. A name field, for example, is text (character data). A shoe size field might be a floating point number so that it could contain values like 6 and 9.5. Obviously, the definition of fields is flexible (you could define a shoe size field as a text field rather than a floating point number, for example), but if you define your fields correctly, FlexSearch will be able to interpret them correctly and your users will get better results when they perform a query.

You can tell FlexSearch about the kind of data a field contains by specifying its field type. The field type tells FlexSearch how to interpret the field and how it can be queried. When you add a document, FlexSearch takes the information in the document's fields and adds that information to an index. When you perform a query, FlexSearch can quickly consult the index and return the matching documents.

Field Analysis
Field analysis tells FlexSearch what to do with incoming data when building an index. A more accurate name for this process would be processing or even digestion, but the official name is analysis. 

Consider, for example, a biography field in a person document. Every word of the biography must be indexed so that you can quickly find people whose lives have had anything to do with ketchup, or dragonflies, or cryptography.

However, a biography will likely contains lots of words you don't care about and don't want clogging up your index, words like "the", "a", "to", and so forth. Furthermore, suppose the biography contains the word "Ketchup", capitalized at the beginning of a sentence. If a user makes a query for "ketchup", you want FlexSearch to tell you about the person even though the biography contains the capitalized word.

The solution to both these problems is field analysis. For the biography field, you can tell FlexSearch how to break apart the biography into words. You can tell FlexSearch that you want to make all the words lower case, and you can tell FlexSearch to remove accents marks. Field analysis is an important part of a field type.

.. seealso:: 
    `FlexSearch Analysis <./analysis.html>`_

Field Properties
--------------------
The below table lists the various parameters supported by index field.

.. csv-table::
    :header: "Parameter", "Description"
    :widths: 5, 30

    "``FieldName``","The name of the field. This should be lowercase and should only contain alphabetical characters."
    "``Analyze``","Signifies if the field should be analyzed using an analyzer. Refer: `FlexSearch Analysis <./analysis.html>`_"
    "``Index``","Signifies if a field should be indexed. A field can only be stored without indexing. Refer: `FlexSearch Analysis <./analysis.html>`_"
    "``Store``","Signifies if a field should be stored so that it can retrieved while searching."
    "``FieldTermVector``","Advance property used for highlighting."
    "``FieldType``","The type of field"
    "``IndexAnalyzer``","Analyzer to be used while indexing"
    "``SearchAnalyzer``","Analyzer to be used while searching"
    "``ScriptName``","Fields can get their content dynamically through scripts. This is the name of the script to be used for getting field data at index time. Refer: `Script <./script.html>`_"

	
Field Types
-------------
The field type defines how FlexSearch should interpret data in a field and how the field can be queried. There are many field types included with FlexSearch by default, and custom types can also be defined.

The below table list the various field types supported by FlexSearch.

.. cssclass:: table-striped

==================== ==============================
Field Type            Description
==================== ==============================
Int                    Integer
Double                 Double
ExactText              Field to store keywords. The entire input will be treated as a single word. This is useful for fields like customerid, referenceid etc. These fields only support complete text matching while searching and no partial word match is available.
Text                   General purpose field to store normal textual data
Highlight              Similar to Text field but supports highlighting of search results 
Bool                   Boolean
Date                   Fixed format date field (Supported format: YYYYmmdd)
DateTime               Fixed format datetime field (Supported format: YYYYMMDDhhmmss)
Custom                 Custom field type which gives more granular control over the field configuration 
Stored                 Non-indexed field. Only used for retrieving stored text. Searching is not possible over these fields.
==================== ==============================


The below table lists the various parameters which can be configured for each field type.

.. cssclass:: table-bordered

+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Field Type   | Search Analyzer   | Index Analyzer   | Store   | Index   | Analyze   | Term Vector   |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Int          | No                | No               | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Double       | No                | No               | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| ExactText    | No                | No               | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Bool         | No                | No               | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Date         | No                | No               | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| DateTime     | No                | No               | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Stored       | No                | No               | No      | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Text         | Yes               | Yes              | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Highlight    | Yes               | Yes              | Yes     | No      | No        | No            |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+
| Custom       | Yes               | Yes              | Yes     | Yes     | Yes       | Yes           |
+--------------+-------------------+------------------+---------+---------+-----------+---------------+

.. note::
    By default ``Text`` ``Highlight`` ``Custom`` use ``Standard Analyzer`` for searching and indexing.

.. warning::
    Configuring any unsupported combination for a field type will be ignored and will result in unexpected behaviour.

Field Term Vectors
--------------------

These options instruct FlexSearch to maintain full term vectors for each document, optionally including the position and offset information for each term occurrence in those vectors. These can be used to accelerate highlighting and other ancillary functionality, but impose a substantial cost in terms of index size. These can only be configured for custom field type.

The following options are supported by FlexSearch:

- DoNotStoreTermVector,
- StoreTermVector,
- StoreTermVectorsWithPositions,
- StoreTermVectorsWithPositionsandOffsets

.. seealso:: 
    `Lucene documentation <http://lucene.apache.org/core/4_4_0/index.html>`_


Defining fields in FlexSearch
--------------------------------

Field can be created or modified from an index using the index APIs - `index\create <./api-index-create.html>`_ and `index\update <./api-index-update.html>`_.

Below is a simple example of an index with fields called 'firstname' & 'lastname'. All field names should be lower case and should not contain any spaces. This is to avoid case based mismatching on field names.

.. code-block:: javascript

    {
       "OpenIndex":false,
       "Index":{
          "Fields":{
             "firstname":{
                "FieldType":"Text"
             },
             "lastname":{
                "FieldType":"Text"
             }
          },
          "IndexName":"test"
       }
    }

Fields have many other configurable properties but Field Type is the only mandatory parameter. Refer to `Index Field <./indexfield.html>`_ for more information about field properties.

Fields can be dynamic in nature and can be computed at index time from the passed data. Computed field requires custom scripts which defines the field data creation logic. Let's create an index field called fullname which is a concatenation of 'firstname' and 'lastname'.

.. code-block:: javascript
    
    {
       "OpenIndex":false,
       "Index":{
          "Fields":{
             "firstname":{
                "FieldType":"Text"
             },
             "lastname":{
                "FieldType":"Text"
             },
             "fullname":{
                "FieldType":"Text",
                "ScriptName":"fullname"
             }
          },
          "IndexName":"test",
          "Scripts":{
             "fullname":{
                "ScriptOption":"SingleLine",
                "ScriptSource":"fields[\"firstname\"] + \" \" + fields[\"lastname\"]",
                "ScriptType":"ComputedField"
             }
          }
       }
    }


Computed fields require ScriptName property to be set in order load a custom script. FlexSearch scripts are dynamically compiled to .net dlls so performance wise they are similar to native .net code. Scripts are written in C#. But it would be difficult to write complex scripts in single line to pass to the Script source, that is why Flex supports Multi-line and File based scripts. Refer to `Script <./script.html>`_ for more information about scripts.



