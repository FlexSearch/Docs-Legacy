POST index/openindex
=====================

An index has to be opened before any operation can be performed on it. openindex request is used to open a closed index.

Resource Information
---------------------

.. cssclass:: table-striped
                                                                    
=========================== ==========================================
**Response Formats**         ``XML`` ``JSON`` ``JSV`` ``CSV`` ``X-MSGPACK`` ``X-PROTOBUF`` ``SOAP 1.1`` ``SOAP 1.2``  
**HTTP Methods**             ``POST`` 
**Resource family**            index                                                            
**Minimum API version**        ``v1.0``                                                                        
**Resource URL**            http://localhost:9800/index/openindex
=========================== ==========================================

Usage Examples
---------------

Request to open a closed index.

.. code-block:: javascript

    {
          "IndexName":"test"
    }