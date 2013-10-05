POST index/update
====================

Updates an existing index.

Resource Information
---------------------

.. cssclass:: table-striped
                                                                    
=========================== ==========================================
**Response Formats**         ``XML`` ``JSON`` ``JSV`` ``CSV`` ``X-MSGPACK`` ``X-PROTOBUF`` ``SOAP 1.1`` ``SOAP 1.2``  
**HTTP Methods**             ``POST`` 
**Resource family**            index                                                            
**Minimum API version**        ``v1.0``                                                                        
**Resource URL**            http://localhost:9800/index/update
=========================== ==========================================

Usage Examples
---------------

Request to update an existing index.

.. code-block:: javascript

    {
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

The updated index will be in the same state as it was initially before the update.