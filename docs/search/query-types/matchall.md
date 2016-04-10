# Matchall Operator

@alert info
@@include(data_notice.html) 
@end

A query that matches all documents. It is a useful query to iterate over all
documents in an index.

@alert tip
Matchall supports <code>matchall</code> function.
@end

## Query Examples
The following search query matches all the documents in the index.

@@render(partials/search_result.html,examples/post-indices-search-matchall-1.json)
