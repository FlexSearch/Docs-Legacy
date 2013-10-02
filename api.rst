REST API v1.0 Resources
=========================

To override the Content-type in your clients HTTP Accept Header, append the ``.json`` suffix or ``?format=json``

Overview
---------

Formats
^^^^^^^^
FlexSearch supports 9 response formats out of the box:

- JSON
- XML
- JSV (hybrid CSV-style escaping + JSON format that is optimized for both size and speed)
- HTML 5 (provides a readable and semantic HTML layout letting you visualize all the data returned by your web service)
- CSV
- X-MSGPACK
- X-PROTOBUF
- SOAP 1.1
- SOAP 1.2

REST endpoint
^^^^^^^^^^^^^^
You can define which format should be used by adding ?format={format} to the end of the URL.

- ``?format=json``
- ``?format=xml``
- ``?format=jsv``
- ``?format=csv``
- ``?format=html``

Alternatively FlexSearch also recognizes which format should be used with the Accept http header:

- ``Accept: application/json``
- ``Accept: application/xml``

This approach only works with json and xml.

SOAP endpoint
^^^^^^^^^^^^^^
SOAP Endpoints are hosted on ``/[soap11|soap12]`` urls. SOAP endpoints only supports POST requests.

JSONP support
^^^^^^^^^^^^^^^
To embed the response in a jsonp callback, append ``?callback=myCallback``

CORS support
^^^^^^^^^^^^^
FlexSearch supports CORS globally across all the services. The default CORS response header is as follows:

::

    allowedOrigins: * 
    allowedMethods: GET, POST, PUT, DELETE, OPTIONS
	
--------------

REST API Reference
-------------------	

Index
^^^^^^
Contains index creation and management related APIs.

.. cssclass:: table-striped

+--------------------+-----------------------+-----------------------------------+
| Http Method        | Resource              | Description                       |
+====================+=======================+===================================+
| ``POST``           | `index/create`_       | Create a new index                |
+--------------------+-----------------------+-----------------------------------+
| ``POST``           | `index/update`_       | Update an existing index          |
+--------------------+-----------------------+-----------------------------------+
| ``POST``           | `index/destroy`_      | Destroy an existing index         |
+--------------------+-----------------------+-----------------------------------+
| ``POST``           | `index/show`_         | Get an existing index             |
+--------------------+-----------------------+-----------------------------------+
| ``POST`` ``GET``   | `index/exist`_        | Check if an index exists or not   |
+--------------------+-----------------------+-----------------------------------+
| ``POST``           | `index/openindex`_    | Open an existing index            |
+--------------------+-----------------------+-----------------------------------+
| ``POST``           | `index/closeindex`_   | Close an existing index           |
+--------------------+-----------------------+-----------------------------------+

.. _index/create: ./api-index-create.html
.. _index/update: ./api-index-update.html
.. _index/destroy: ./api-index-destroy.html
.. _index/show: ./api-index-show.html
.. _index/exist: ./api-index-exist.html
.. _index/openindex: ./api-index-openindex.html
.. _index/closeindex: ./api-index-closeindex.html

--------------

Document
^^^^^^^^^
Contains document creation and management related APIs.

.. cssclass:: table-striped

+--------------------+-----------------------+-----------------------------------+
| Http Method        | Resource              | Description                       |
+====================+=======================+===================================+
| ``POST``           | `document/create`_    | Create a new document             |
+--------------------+-----------------------+-----------------------------------+
| ``POST``           | `document/update`_    | Update an existing document       |
+--------------------+-----------------------+-----------------------------------+
| ``POST``           | `document/destroy`_   | Destroy an existing document      |
+--------------------+-----------------------+-----------------------------------+
| ``POST`` ``GET``   | `document/show`_      | Get an existing document          |
+--------------------+-----------------------+-----------------------------------+

.. _document/create: ./api-document-create.html
.. _document/update: ./api-document-update.html
.. _document/destroy: ./api-document-destroy.html
.. _document/show: ./api-document-show.html

--------------

Analysis
^^^^^^^^^

.. cssclass:: table-striped

+--------------------+-----------------------+-----------------------------------+
| Http Method        | Resource              | Description                       |
+====================+=======================+===================================+
| ``POST``           | `analysis/analyze`_   | Analyze the text using an analyzer|
+--------------------+-----------------------+-----------------------------------+

.. _analysis/analyze: ./api-analysis-analyze.html

--------------

Job
^^^^^^

.. cssclass:: table-striped

+--------------------+-----------------------+-----------------------------------+
| Http Method        | Resource              | Description                       |
+====================+=======================+===================================+
| ``POST``           | `job/getstatus`_      | Get the status of a job by Id     |
+--------------------+-----------------------+-----------------------------------+

.. _job/getstatus: ./api-job-getstatus.html

--------------

Request Logs
^^^^^^^^^^^^^^^

.. cssclass:: table-striped

+--------------------+-----------------------+-----------------------------------+
| Http Method        | Resource              | Description                       |
+====================+=======================+===================================+
| ``POST``           | `/requestlogs`_       | Log of requests made to the server|
+--------------------+-----------------------+-----------------------------------+

.. _/requestlogs: ./api-requestlogs.html
