@alert info
@@include(data_notice.html) 
@end

`AllOf` query is the simplest of the term related queries which forces all the specified terms
to match in a given input. This query does not take position in consideration and will match
terms out of order.

@alert tip
`AllOf` uses Search Analyzer to generate tokens.
@end

## Query Examples
The following search query returns all documents containing `Wheat` and `Rice`
both, in the `agriproducts` field.

@@render(partials/search_result.html,examples/post-indices-search-term-2.json)

The above query is semantically similar to the below queries:

```bash
allof(agriproducts, 'rice') and allof(agriproducts, 'wheat')
```

```bash
allof(agriproducts, 'rice', 'wheat')
```

