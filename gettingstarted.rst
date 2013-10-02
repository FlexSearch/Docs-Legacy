Getting Started Guide
======================

Installing FlexSearch
----------------------
This section describes how to install FlexSearch. You can install FlexSearch anywhere that a suitable .net runtime is available. You will need the .net Runtime Environment version 4.5 or higher.

Download pre-compiled binaries
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Latest pre-build releases can be downloaded from the following link:

https://github.com/FlexSearch/FlexSearch/releases

Building from source
^^^^^^^^^^^^^^^^^^^^^^
Download the source code from Github and run build.bat. This will compile the source code and create a build package.

To install FlexSearch
^^^^^^^^^^^^^^^^^^^^^^
- Unpack the FlexSearch distribution to your desired location.
- ``Optional`` Run install.bat from the root directory of FlexSearch. This will install the server as a Windows service which can be accessed from the Local Services under administrative services.
- Start the server by executing `FlexSearch Server.exe` or by running the `FlexSearch Server` service from local services depending upon if the server was installed as Windows service.

To confirm your installation, go to the FlexSearch meta-data page at http://_hostname_:9800/meta/.

Directory Structure
^^^^^^^^^^^^^^^^^^^^^
::

	flexsearch/
	+-- api/
	|   +-- index.html
	+-- conf/
	|   +-- scripts/
	|   |   +-- _ComputedFieldScriptTemplate.cs
	|   |   +-- _ProfileSelectorScriptTemplate.cs
	|   +-- config.xml
	|   +-- conf.sqlite
	+-- data/
	+-- lib/
	+-- licenses/
	+-- plugins/


.. cssclass:: table-striped

========== ==================
 Folder      Description 
========== ==================
api         Swagger assets
conf        Configuration folder
scripts 	Preconfigured scripts
data		Data folder for indexing data
lib			3rd party library
plugins		FlexSearch plugins
========== ==================

Configure global Settings
^^^^^^^^^^^^^^^^^^^^^^^^^^

Configure logging
^^^^^^^^^^^^^^^^^^