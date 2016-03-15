@alert info
@@include(data_notice.html) 
@end

Implements the wildcard search query. Supported wildcards are `*`, which matches
any character sequence (including the empty one), and `?`, which matches any
single character. Note this query can be slow, as it needs to iterate over many
terms.

@alert tip
In order to prevent extremely slow Wildcard Queries, a Wildcard term should not
start with the wildcard *.
@end

@alert important
Like query does not go through analysis phase as the analyzer would remove the
special characters. This will convert the input to lowercase before comparison.
@end

## Query Examples

The following search query returns all documents with `uni` coming anywhere in
the word.

@@render(partials/search_result.html,examples/post-indices-search-wildcard-1.json)

The following query will match any word where it starts with `Unit` followed by
any single character and ends with `d`.

@@render(partials/search_result.html,examples/post-indices-search-wildcard-3.json)
