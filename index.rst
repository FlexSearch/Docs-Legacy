.. FlexSearch documentation master file, created by
   sphinx-quickstart on Thu Sep 05 13:49:18 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to {F}lexSearch's documentation!
========================================

FlexSearch is a high performance REST/SOAP services based full-text searching platform built on top of the popular Lucene search library. At its core it is about extensibility and maintainability with minimum overhead. FlexSearch is written in F# & C# 5.0 (.net framework 4.5). It exposes REST, SOAP and Binary based web service endpoints enabling easy integration. It has an extensive plug-in architecture with ability to customize most of the functionality with minimum amount of efforts. One area where FlexSearch particularly excel over competition is providing easy extensible connector model which allows a developer to tap directly into core's indexing engine, thus avoiding the reliance on web services. This results in a greatly improved indexing performance when indexing over millions of records.

Contents:
^^^^^^^^^^^^
.. toctree::
	:maxdepth: 3
   
	gettingstarted
	api

Search DSL:
^^^^^^^^^^^^
.. toctree::
	:maxdepth: 3
   
	searchbasics
	searchprofile
	
Concepts:
^^^^^^^^^^^^
.. toctree::
	:maxdepth: 3
	
	indexfield
	analysis
	script
	metadatapage
	swaggerui

Development Guide:
^^^^^^^^^^^^^^^^^^^
.. toctree::
	:maxdepth: 3
	
	

.. seealso::
 
	The documentation contains information from various sources and at times excerpts from third party documentation. In case more information is required then you can refer to the following sources directly:

#. `ServiceStack wiki <https://github.com/ServiceStack/ServiceStack/wiki>`_
#. `Lucene documentation <http://lucene.apache.org/core/4_4_0/index.html>`_
#. `Apache Solr Reference Guide 4.4 <https://www.apache.org/dyn/closer.cgi/lucene/solr/ref-guide/>`_

	 
.. note:: 
	FlexSearch and all related documentation is Licensed under the Apache License, Version 2.0


.. note:: 	
	In case you observe any glaring issues then please contact us through GitHub or submit pull request for the documentation repository at https://github.com/FlexSearch/Documentation to make the necessary corrections.
