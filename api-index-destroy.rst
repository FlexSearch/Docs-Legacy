POST index/destroy
====================

Destroys an existing index.

Resource Information
---------------------

.. cssclass:: table-striped
                                                                    
=========================== ==========================================
**Response Formats**         ``XML`` ``JSON`` ``JSV`` ``CSV`` ``X-MSGPACK`` ``X-PROTOBUF`` ``SOAP 1.1`` ``SOAP 1.2``  
**HTTP Methods**             ``POST`` 
**Resource family**            index                                                            
**Minimum API version**        ``v1.0``                                                                        
**Resource URL**            http://localhost:9800/index/destroy
=========================== ==========================================

Usage Examples
---------------

Request to delete an existing index.

.. code-block:: javascript

    {
          "IndexName":"test"
    }
