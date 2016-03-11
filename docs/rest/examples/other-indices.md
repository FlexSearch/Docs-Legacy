### Updating an index configuration

@@render(partials/example.html,examples/put-indices-id-4.json)

### Deleting an index

@@render(partials/example.html,examples/delete-indices-id-1.json)

### Deleting a non existing index will return an error

@@render(partials/example.html,examples/delete-indices-id-2.json)

### Changing the status of an index

In this particular case we are going to bring an index `online`, meaning we are going to set its status to `online`

@@render(partials/example.html,examples/put-indices-id-status-1.json)