@alert info
@@include(data_notice.html) 
@end

Implements the fuzzy search query. The similarity measurement is based on the Damerau-Levenshtein (optimal string alignment) algorithm. At most, this query will match terms up to 2 edits. Higher distances, are generally not useful and will match a significant amount of the term dictionary. If you really want this, consider using an n-gram indexing technique (such as the SpellChecker in the suggest module) instead.

Parameter |Default |Type |Description
--- | --- | --- | ---
`prefixlength` |0 |int |Length of common (non-fuzzy) prefix.
`slop` |1 |int |The number of allowed edits

@alert tip
Fuzzy uses Search Analyzer to generate tokens.
@end

## Query Examples
The following search query returns all documents containing `Iran` and all documents containing `Iran` with 1 character difference, in the `countryname` field.

@@render(partials/search_result.html,examples/post-indices-search-fuzzy-1.json)

The following search query demonstrates the use of `slop` operator. It returns all countries similar to `China` with a difference of two characters.

@@render(partials/search_result.html,examples/post-indices-search-fuzzy-3.json)
