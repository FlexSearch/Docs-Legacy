# Regex operator

@alert info
@@include(data_notice.html) 
@end

A fast regular expression query based on the `org.apache.lucene.util.automaton`
package. Comparisons are fast.

The term dictionary is enumerated in an intelligent way, to avoid comparisons.
The supported syntax is documented in the Java RegExp class.

@alert warning
This query can be slow, as it needs to iterate over many terms. In order to
prevent extremely slow RegexpQueries, a Regexp term should not start with the
expression <code>*</code>.
@end

@alert tip
Regex supports <code>regex</code> function.
@end

@alert important
Regex query does not go through analysis phase as the analyzer would remove the
special characters. This will convert the input to lowercase before comparison.
@end

## Query Examples

The following search query matches all the documents containing `silk` and `milk`.

@@render(partials/search_result.html,examples/post-indices-search-regex-1.json)
