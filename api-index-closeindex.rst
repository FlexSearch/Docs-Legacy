POST index/closeindex
=======================

An index has to be opened before any operation can be performed on it. closeindex request is used to close an open index.

Resource Information
---------------------

.. cssclass:: table-striped
                                                                    
=========================== ==========================================
**Response Formats**         ``XML`` ``JSON`` ``JSV`` ``CSV`` ``X-MSGPACK`` ``X-PROTOBUF`` ``SOAP 1.1`` ``SOAP 1.2``  
**HTTP Methods**             ``POST`` 
**Resource family**            index                                                            
**Minimum API version**        ``v1.0``                                                                        
**Resource URL**            http://localhost:9800/index/closeindex
=========================== ==========================================

Usage Examples
---------------

Request to close an open index.

.. code-block:: javascript

    {
          "IndexName":"test"
    }