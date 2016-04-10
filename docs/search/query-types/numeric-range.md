# Numeric range operator

@alert info
@@include(data_notice.html) 
@end

A Query that matches numeric values within a specified range. To use this, you
must first index the numeric values using `Int`, `Long`, `DateTime`, `Date` or `Double`.

@alert tip
Range supports <code>gt</code> (greater than), <code>ge</code> (greater or equal), <code>lt</code> (less than) and 
<code>le</code> (less or equal) functions.
@end

## Query Examples
@@render(partials/search_result.html,examples/post-indices-search-range-1.json)
@@render(partials/search_result.html,examples/post-indices-search-range-2.json)
@@render(partials/search_result.html,examples/post-indices-search-range-3.json)
@@render(partials/search_result.html,examples/post-indices-search-range-4.json)
