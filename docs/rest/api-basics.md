FlexSearch follows the following basic URI convention:

	[HTTP VERB] http://{servername}:{portnumber}/{resource}/{resourceId}/{sub-resource|operation}

For example if the users wants to check the status of index with name
`test` then the indexname in the above URI will be replaced by `test`
and the operation will become `status`:

	GET http://{servername}:{portnumber}/inidices/test/status

The various Http verbs are mapped to the following operations:

Verb | Description
--|--
`GET` |Get a resource
`POST` |Create a resource
`PUT` |Update/Create a resource
`DELETE` |Delete a resource

## Formats

FlexSearch supports 2 response formats out of the box:

* JSON
* MessagePack

## JSONP support

To embed the response in a jsonp callback, append `?callback=myCallback`