# What is FlexSearch?

FlexSearch is a high performance REST based full-text searching platform built on top of 
the popular Lucene search library. At its core it is about extensibility and maintainability
with minimum overhead. FlexSearch is written in F# & C# 5.0 (.net framework 4.6.1).

It has an extensive plug-in architecture with ability to customize most of the functionality 
with minimum amount of efforts. It also supports scripting which can be used at both search 
and index time to fine tune the data. One area where FlexSearch particularly excel, is 
providing easy extensible connector model which allows a developer to tap directly into 
core's indexing engine, thus avoiding the reliance on web services. This results in a 
greatly improved indexing performance when indexing over millions of records.

Some ideal use cases for the engine would be:
- Searching across unstructured text data on intranet and websites.
- Searching across structured data coming from SQL, CSV and other sources.
- Duplicate detection over large volume of structured data like customer information
de-duplication, address matching etc.

<div class="card">
    <div class="card-image">
        <img src="/img/material/mb-bg-fb-01.jpg">
        <span class="card-title black">FlexSearch Docs</span>
    </div>
    <div class="card-content">
        <p>Welcome to FlexSearch official help and support site. It contains everything you need to know about using FlexSearch.</p>
    </div>
    <div class="card-action">
        <a href="#">Why FlexSearch?</a>
        <a href="getting-started">Get Started</a>
        <a href="server-setup/5-minute-install">Five-Minute Install</a>
        <a href="https://github.com/FlexSearch/FlexSearch/releases">Download</a>
    </div>
</div>
    
## Other things of interest

* [Guides](../docsGuides) - Let's simplify the tricky bits.
* [Concepts](../docsConcepts) - Understanding the basics of searching and indexing.
* [REST API](../docsRESTAPI) - Consuming the services exposed by FlexSearch.
* [Search](../docsSearch) - Explanation of search capability.
* [Extending FlexSearch](../docsExtendingFlexSearch) - Build upon the existing functionality.
* [Import Handlers](../Connectors) - Bring data from external sources.
* [FAQ](faq)
