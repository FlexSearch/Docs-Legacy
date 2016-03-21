FlexSearch `Scripts` are snippets of code that execute a certain logic at a specific moment in the FlexSearch event pipeline. You can currently have your own custom logic:

- just before a document is added or modified in an index - [`Pre-index scripts`](preindex-scripts).
    This script lets you manipulate the data that is being indexed.
- just before a search request is sent to Lucene - [`Pre-search scripts`](presearch-scripts).
    This script helps you control the data that is being sent for searching.
