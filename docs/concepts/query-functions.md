### Definition

`Query Functions` are implementations of the `IQueryFunction` interface that execute a certain Lucene query according to the parameters and switches given to the functions. Their role is to simplify the Lucene syntax and create complex queries just by calling a specific function.

### Examples

Examples of query functions offered by default in FlexSearch are:

- `allOf`
- `anyOf`
- `fuzzy`
- `matchall`
- `matchnone`
- `phrasematch`
- `like`
- `regex`
- `gt`
- `ge`
- `lt`
- `le`

@alert tip
You can find usage information regarding query functions [here](../../QueryTypes)
@end

As an example of how `query functions` translate to Lucene queries, the `allOf` query function translates to a Lucene `TermQuery` where all terms are a `MUST`.

### Implementing your own `Query Function`

More details on how to implement your own `query function` will follow soon.