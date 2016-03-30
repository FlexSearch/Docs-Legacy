@alert info
@@include(data_notice.html) 
@end

`AnyOf` query is the simplest of the term related queries which forces one of the specified term
to match in a given input. This query does not take position in consideration and will match
terms out of order.

@alert tip
`AnyOf` uses Search Analyzer to generate tokens.
@end

## Query Examples
The following search query returns all documents containing `Wheat` or `Rice`
or both, in the `agriproducts` field.

@@render(partials/search_result.html,examples/post-indices-search-term-4.json)

The above query is semantically similar to the below queries:

```bash
anyOf(agriproducts, 'rice') and anyOf(agriproducts, 'wheat')
```

```bash
anyOf(agriproducts, 'rice', 'wheat')
```