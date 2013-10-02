POST index/create
====================

Creates a new index.

Resource Information
---------------------

.. cssclass:: table-striped
																	
=========================== ==========================================
**Response Formats** 		``XML`` ``JSON`` ``JSV`` ``CSV`` ``X-MSGPACK`` ``X-PROTOBUF`` ``SOAP 1.1`` ``SOAP 1.2``  
**HTTP Methods** 			``POST`` 
**Resource family**			index															
**Minimum API version**		``v1.0``																		
**Resource URL**			http://localhost:9800/index/create
=========================== ==========================================

Usage Examples
---------------

Request to create a simple index without any fields.

.. code:: javascript

    {
       "OpenIndex":false,
       "Index":{
          "IndexName":"test"
       }
    }

The newly created index will be offline as the OpenIndex parameter is set to false. An index has to be opened after creation to enable indexing.

There are various parameters which can be set while creating an index. Let's start with adding two simple fields to the index called 'firstname' & 'lastname'. All field names should be lower case and should not contain any spaces. This is to avoid case based mismatching on field names.

.. code:: javascript

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

Computed Fields
-------------------

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

Computed fields requires ScriptName property to be set in order load a custom script. FlexSearch scripts are dynamically compiled to .net dlls so performance wise they are similar to native .net code. Scripts are written in C#. But it would be difficult to write complex scripts in single line to pass to the Script source, that is why Flex supports Multi-line and File based scripts. Refer to `Script <./script.html>`_ for more information about scripts.
