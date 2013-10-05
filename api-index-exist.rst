POST index/exists
====================

Checks if a given index exists or not.

Resource Information
---------------------

.. cssclass:: table-striped
                                                                    
=========================== ==========================================
**Response Formats**         ``XML`` ``JSON`` ``JSV`` ``CSV`` ``X-MSGPACK`` ``X-PROTOBUF`` ``SOAP 1.1`` ``SOAP 1.2``  
**HTTP Methods**             ``POST`` ``GET``
**Resource family**            index                                                            
**Minimum API version**        ``v1.0``                                                                        
**Resource URL**            http://localhost:9800/index/exists
=========================== ==========================================

Usage Examples
---------------

Request to check if a given index exists or not.

.. code-block:: javascript

    {
          "IndexName":"test"
    }
