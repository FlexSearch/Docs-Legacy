FlexSearch Analysis
======================

Field analyzers are used both during ingestion, when a document is indexed, and at query time. An analyzer examines the text of fields and generates a token stream. Analyzers may be a single class or they may be composed of a series of tokenizer and filter classes. 

Tokenizers break field data into lexical units, or tokens. Filters examine a stream of tokens and keep them, transform or discard them, or create new ones. Tokenizers and filters may be combined to form pipelines, or chains, where the output of one is input to the next. Such a sequence of tokenizers and filters is called an analyzer and the resulting output of an analyzer is used to match query results or build indices. 

Although the analysis process is used for both indexing and querying, the same analysis process need not be used for both operations. For indexing, you often want to simplify, or normalize, words. For example, setting all letters to lowercase, eliminating punctuation and accents, mapping words to their stems, and so on. Doing so can increase recall because, for example, "ram", "Ram" and "RAM" would all match a query for "ram". To increase query-time precision, a filter could be employed to narrow the matches by, for example, ignoring all-cap acronyms if you're interested in male sheep, but not Random Access Memory.

The tokens output by the analysis process define the values, or terms, of that field and are used either to build an index of those terms when a new document is added, or to identify which documents contain the terms you are querying for. This section will show you how to configure field analyzers and also serves as a reference for the details of configuring each of the available tokenizer and filter classes. It also serves as a guide so that you can configure your own analysis classes if you have special needs that cannot be met with the included filters or tokenizers.

Analyzer
---------

An analyzer examines the text of fields and generates a token stream. Analyzers are specified as part of the ``Field Properties`` element in the ``Fields`` section of index configuration.

Only the following field types can have an analyzer, if specified the analyzer will be ignored for other field types.

- Text
- Highlight
- Custom

.. note::
    ``StandardAnalyzer`` is used when no analyzer is specified.

For simple cases, such as plain English prose, a single analyzer class like this may be sufficient. But it's often necessary to do more complex analysis of the field content. Even the most complex analysis requirements can usually be decomposed into a series of discrete, relatively simple processing steps. As you will soon discover, the FlexSearch distribution comes with a large selection of tokenizers and filters that covers most scenarios you are likely to encounter.

Tokenizer
-----------

The job of a tokenizer is to break up a stream of text into tokens, where each token is (usually) a sub-sequence of the characters in the text. An analyzer is aware of the field it is configured for, but a tokenizer is not. Tokenizers read from a character stream (a Reader) and produce a Characters in the input stream may be discarded, such as whitespace or other delimiters. They may also be added to or replaced, such as mapping aliases or abbreviations to normalized forms. A token contains various metadata in addition to its text value, such as the location at which the token occurs in the field. Because a tokenizer may produce tokens that diverge from the input text, you should not assume that the text of the token is the same text that occurs in the field, or that its length is the same as the original text. It's also possible for more than one token to have the same position or refer to the same offset in the original text. Keep this in mind if you use token metadata for things like highlighting search results in the field text.

Tokenizer Types
^^^^^^^^^^^^^^^^^

StandardTokenizer
^^^^^^^^^^^^^^^^^^^^

StandardTokenizer is a good general purpose tokenizer that strips many extraneous characters and sets token types to meaningful values. This tokenizer splits the text field into tokens, treating whitespace and punctuation as delimiters. Delimiter characters are discarded, with the following exceptions:

- Periods (dots) that are not followed by whitespace are kept as part of the token.
- Words are split at hyphens.

The Standard Tokenizer supports Unicode standard annex UAX#29 word boundaries with the following token types: ``<ALPHANUM>``, ``<NUM>``, ``<SOUTHEAST_ASIAN>``, ``<IDEOGRAPHIC>`` and ``<HIRAGANA>``.

::

    In: "Please, email john.doe@foo.com by 03-09, re: m37-xq."
    Out: "Please", "email", "john.doe", "foo.com", "by", "03", "09", "re", "m37", "xq"


Classic Tokenizer
^^^^^^^^^^^^^^^^^^^

The Classic Tokenizer preserves the same behaviour as the Standard Tokenizer of Lucene versions 3.1 and previous. It does not use the Unicode standard annex UAX#29 word boundary rules that the Standard Tokenizer uses. This tokenizer splits the text field into tokens, treating whitespace and punctuation as delimiters. Delimiter characters are discarded, with the following exceptions:

- Periods (dots) that are not followed by whitespace are kept as part of the token.
- Words are split at hyphens, unless there is a number in the word, in which case the token is not split and the numbers and hyphen(s) are preserved.
- Recognizes Internet domain names and email addresses and preserves them as a single token.

::

    In: "Please, email john.doe@foo.com by 03-09, re: m37-xq."
    Out: "Please", "email", "john.doe@foo.com", "by", "03-09", "re", "m37-xq"

Keyword Tokenizer
^^^^^^^^^^^^^^^^^^^

This tokenizer treats the entire text field as a single token.

::

    In: "Please, email john.doe@foo.com by 03-09, re: m37-xq."
    Out: "Please, email john.doe@foo.com by 03-09, re: m37-xq."

Letter Tokenizer
^^^^^^^^^^^^^^^^^^

This tokenizer creates tokens from strings of contiguous letters, discarding all non-letter characters.

::

    In: "Please, email john.doe@foo.com by 03-09, re: m37-xq."
    Out: "Please", "email", "john", "doe", "foo", "com", "by", "re", "m", "xq"

Lower Case Tokenizer
^^^^^^^^^^^^^^^^^^^^^^
It tokenizes the input stream by delimiting at non-letters and then converting all letters to lowercase. Whitespace and non-letters are discarded.

::

    In: "Please, email john.doe@foo.com by 03-09, re: m37-xq."
    Out: "please", "email", "john", "doe", "foo", "com", "by", "re", "m", "xq"

UAX29 URL Email Tokenizer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This tokenizer splits the text field into tokens, treating whitespace and punctuation as delimiters. Delimiter characters are discarded, with the following exceptions:

- Periods (dots) that are not followed by whitespace are kept as part of the token.
- Words are split at hyphens, unless there is a number in the word, in which case the token is not split and the numbers and hyphen(s) are preserved.
- Recognizes top-level (.com) Internet domain names; email addresses; file:://, http(s)://, and ftp:// addresses; IPv4 and IPv6 addresses; and preserves them as a single token.
- The UAX29 URL Email Tokenizer supports Unicode standard annex UAX#29 word boundaries with the following token types: ``<ALPHANUM>``, ``<NUM>``, URL, EMAIL, ``<SOUTHEAST_ASIAN>``, ``<IDEOGRAPHIC>`` and ``<HIRAGANA>``.

::

    In: "Visit http://accarol.com/contact.htm?from=external&a=10 or e-mail bob.cratchet@accarol.com"
    Out: "Visit", "http://accarol.com/contact.htm?from=external&a=10", "or", "email", "bob.cratchet@accarol.com"

White Space Tokenizer
^^^^^^^^^^^^^^^^^^^^^^^^^

It is a simple tokenizer that splits the text stream on whitespace and returns sequences of non-whitespace characters as tokens. Note that any punctuation will be included in the tokenization.

::

    In: "Please, email john.doe@foo.com by 03-09, re: m37-xq."
    Out: "Please,", "email", "john.doe@foo.com", "by", "03-09,", "re:", "m37-xq."

Filter
-----------

Like tokenizers, filters consume input and produce a stream of tokens. The job of a filter is usually easier than that of a tokenizer since in most cases a filter looks at each token in the stream sequentially and decides whether to pass it along, replace it or discard it.

A filter may also do more complex analysis by looking ahead to consider multiple tokens at once, although this is less common. One hypothetical use for such a filter might be to normalize state names that would be tokenized as two words. For example, the single token "california" would be replaced with "CA", while the token pair "rhode" followed by "island" would become the single token "RI".

Because filters consume one Token Stream and produce a new Token Stream, they can be chained one after another indefinitely. Each filter in the chain in turn processes the tokens produced by its predecessor. The order in which you specify the filters is therefore significant. Typically, the most general filtering is done first, and later filtering stages are more specialized.

.. code-block:: javascript

    {
        "Index": {
            "Analyzers": {
                "firstnameanalyzer": {
                    "Filters": [
                        {
                            "FilterName": "standardfilter"
                        },
                        {
                            "FilterName": "lowercasefilter"
                        }
                    ],
                    "Tokenizer": {
                        "TokenizerName": "standardtokenizer"
                    }
                }
            },
            "Fields": {
                "firstname": {
                    "FieldType": "Text",
                    "Index": true,
                    "IndexAnalyzer": "firstnameanalyzer",
                }
            },
            "IndexName": "test",
        }
    }


This example starts with FlexSearch's standard tokenizer, which breaks the field's text into tokens. Those tokens then pass through FlexSearch's standard filter, which removes dots from acronyms, and performs a few other common operations. All the tokens are then set to lowercase, which will facilitate case-insensitive matching at query time.


Ascii Folding Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
This filter converts alphabetic, numeric, and symbolic Unicode characters which are not in the Basic Latin Unicode block (the first 127 ASCII characters) to their ASCII equivalents, if one exists. This filter converts characters from the following Unicode blocks:

* C1 Controls and Latin-1 Supplement (PDF)
* Latin Extended-A (PDF)
* Latin Extended-B (PDF)
* Latin Extended Additional (PDF)
* Latin Extended-C (PDF)
* Latin Extended-D (PDF)
* IPA Extensions (PDF)
* Phonetic Extensions (PDF)
* Phonetic Extensions Supplement (PDF)
* General Punctuation (PDF)
* Superscripts and Subscripts (PDF)
* Enclosed Alphanumerics (PDF)
* Dingbats (PDF)
* Supplemental Punctuation (PDF)
* Alphabetic Presentation Forms (PDF)
* Halfwidth and Fullwidth Forms (PDF)

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "asciifoldingfilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }

::

    In: (Unicode character 00E1)
    Out: (ASCII character 160)

Standard Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
This filter removes dots from acronyms and the substring "'s" from the end of tokens. This filter depends on the tokens being tagged with the appropriate term-type to recognize acronyms and words with apostrophes.

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "standardfilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }

::
    
    In: "Bob's I.O.U."
    Tokenizer to Filter: "Bob's", "I.O.U."
    Out: "Bob", "IOU"

.. note:: 
    Even though this is the expected behaviour, we are unable to reproduce it through the unit test. Probably there has been a change in Lucene's behaviour. Refer: http://lucene.472066.n3.nabble.com/StandardAnalyzer-functionality-change-td4015556.html

Beider Morse Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Implements the Beider-Morse Phonetic Matching (BMPM) algorithm, which allows identification of similar names, even if they are spelled differently or in different languages.

Arguments
'''''''''''''

.. csv-table::
    :header: "Parameter", "Default", "Description"
    :widths: 15, 10, 30

    "``nametype``","GENERIC","Types of names. Valid values are GENERIC, ASHKENAZI, or SEPHARDIC. If not processing Ashkenazi or Sephardic names, use GENERIC."
    "``ruletype``","EXACT","Types of rules to apply. Valid values are APPROX or EXACT."

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "beidermorsefilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }

Double Metaphone Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
This filter creates tokens using caverphone2 phonetic encoding algorithm.

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "doublemetaphonefilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }

::    

    In: "four score and twenty"
    Tokenizer to Filter: "four"(1), "score"(2), "and"(3), "twenty"(4)
    Out: "four"(1), "FR"(1), "score"(2), "SKR"(2), "and"(3), "ANT"(3), "twenty"(4), "TNT"(4)

.. note::
    The phonetic tokens have a position increment of 0, which indicates that they are at the same position as the token they were derived from (immediately preceding).

Caverphone2 Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
This filter creates tokens using caverphone2 phonetic encoding algorithm.

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "caverphone2filter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }


Metaphone Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This filter creates tokens using metaphone phonetic encoding algorithm.

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "metaphonefilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }


Refined Soundex Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This filter creates tokens using refined soundex phonetic encoding algorithm.

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "refinedsoundexfilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }
    
Soundex Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
This filter creates tokens using soundex phonetic encoding algorithm.

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "soundexfilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }
    
Keep Words Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This filter discards all tokens except those that are listed in the given word list. This is the inverse of the Stop Words Filter. This filter can be useful for building specialized indices for a constrained set of terms.

Arguments
'''''''''''''

.. csv-table::
    :header: "Parameter", "Default", "Description"
    :widths: 15, 10, 30

    "``filename``","required","Path of a text file containing the list of keep words, one per line. Blank lines and lines that begin with '#' are ignored. This is a simple filename in the FlexSearch config directory."


Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "keepwordsfilter",
                        "Parameters":{"filename":"keepwords.txt"}
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }
    
Where ``keepwords.txt`` contains:

::

    happy
    funny
    silly

::

    In: "Happy, sad or funny"
    Tokenizer to Filter: "Happy", "sad", "or", "funny"
    Out: "Happy", "funny"

Length Filter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
This filter passes tokens whose length falls within the min/max limit specified. All other tokens are discarded.

Arguments
''''''''''''''

.. csv-table::
    :header: "Parameter", "Type" ,"Default", "Description"
    :widths: 10, 10, 10, 30

    "``min``","integer","required","Minimum token length. Tokens shorter than this are discarded."
    "``max``","integer","required","Maximum token length (must be >= min). Tokens longer than this are discarded."

Example
''''''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "lengthfilter",
                        "Parameters":
                            {
                                "min":"3",
                                "max":"7"
                            }
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }
    
::

    In: "turn right at Albuquerque"
    Tokenizer to Filter: "turn", "right", "at", "Albuquerque"
    Out: "turn", "right"

    
Lower Case Filter
^^^^^^^^^^^^^^^^^^

Converts any uppercase letters in a token to the equivalent lowercase token. All other characters are left unchanged.

Example
''''''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "lowercasefilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }

::

    In: "Down With CamelCase"
    Tokenizer to Filter: "Down", "With", "CamelCase"
    Out: "down", "with", "camelcase"

    
Pattern Replace Filter
^^^^^^^^^^^^^^^^^^^^^^

This filter applies a regular expression to each token and, for those that match, substitutes the given replacement string in place of the matched pattern. Tokens which do not match are passed though unchanged.

.. csv-table::
    :header: "Parameter", "Type" ,"Default", "Description"
    :widths: 10, 10, 10, 30

    "``pattern``","string","required","The regular expression to test against each token, as per java.util.regex.Pattern."
    "``replacementtext``","string","required","A string to substitute in place of the matched pattern. This string may contain references to capture groups in the regex pattern. See the Javadoc for java.util.regex.Matcher."
    
Example
''''''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "patternreplacefilter",
                        "Parameters":
                            {
                                "pattern":"cat",
                                "replacementtext":"dog"
                            }
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }

::

    In: "cat concatenate catycat"
    Tokenizer to Filter: "cat", "concatenate", "catycat"
    Out: "dog", "condogenate", "dogycat"

    
Stop Filter
^^^^^^^^^^^^^^^^^^^^^^

This filter discards, or stops analysis of, tokens that are on the given stop words list.

Arguments
'''''''''''''

.. csv-table::
    :header: "Parameter", "Default", "Description"
    :widths: 15, 10, 30

    "``filename``","required","Path of a text file containing the list of stop words, one per line. Blank lines and lines that begin with '#' are ignored. This is a simple filename in the FlexSearch config directory."


Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "stopwordsfilter",
                        "Parameters":{"filename":"stopwords.txt"}
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }
    
Where ``stopwords.txt`` contains:

::

    happy
    funny
    silly

::

    In: "Happy, sad or funny"
    Tokenizer to Filter: "Happy", "sad", "or", "funny"
    Out: "sad", "or"

Synonym Filter
^^^^^^^^^^^^^^^^^^^^^^
This filter does synonym mapping. Each token is looked up in the list of synonyms and if a match is found, then the synonym is emitted in place of the token. The position value of the new tokens are set such they all occur at the same position as the original token.

Arguments
'''''''''''''

.. csv-table::
    :header: "Parameter", "Default", "Description"
    :widths: 15, 10, 30

    "``filename``","required","Path of a text file containing the list of synonyms words, one collection per line. Blank lines and lines that begin with '#' are ignored. This is a simple filename in the FlexSearch config directory."

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "synonymfilter",
                        "Parameters":{"filename":"synonym.txt"}
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }
    
Where ``synonym.txt`` contains:

::

    easy:simple,clear

::

    In: "easy"
    Tokenizer to Filter: "easy"
    Out: "easy", "simple", "clear"
    
ReverseStringFilter
^^^^^^^^^^^^^^^^^^^^^^
This filter reverses the tokens.

Example
'''''''''

.. code-block:: javascript
    
    {
        "Analyzers": {
            "testanalyzer": {
                "Filters": [
                    {
                        "FilterName": "reversestringfilter"
                    }
                ],
                "Tokenizer": {
                    "TokenizerName": "standardtokenizer"
                }
            }
        }
    }

::

    In: "hello how are you"
    Tokenizer to Filter: "hello", "how", "are", "you"
    Out: "olleh", "woh", "era", "uoy"
    
    
TrimFilter
^^^^^^^^^^^^^^^^^^^^^^
This filter trims leading and/or trailing whitespace from tokens. Most tokenizers break tokens at whitespace, so this filter is most often used for special situations.




Defining a custom analyzer
------------------------------

Analyzers can be created or modified from an index using the index APIs - `index\create <./api-index-create.html>`_ and `index\update <./api-index-update.html>`_.

Setting up an analyzer chain is very straightforward; you specify a simple ``analyzer`` element with child elements that name the tokenizer and filters to use, in the order you want them to run.

For example:

.. code-block:: javascript

    {
        "Index": {
            "Analyzers": {
                "firstnameanalyzer": {
                    "Filters": [
                        {
                            "FilterName": "standardfilter"
                        },
                        {
                            "FilterName": "lowercasefilter"
                        }
                    ],
                    "Tokenizer": {
                        "TokenizerName": "standardtokenizer"
                    }
                }
            },
            "Fields": {
                "firstname": {
                    "FieldType": "Text",
                    "Index": true,
                    "IndexAnalyzer": "firstnameanalyzer",
                }
            },
            "IndexName": "test",
        }
    }



This example starts with FlexSearch's standard tokenizer, which breaks the field's text into tokens. Those tokens then pass through FlexSearch's standard filter, which removes dots from acronyms, and performs a few other common operations. All the tokens are then set to lowercase, which will facilitate case-insensitive matching at query time. You can specify more filters if needed. In case filters have associated properties then that can also be specified along with filter definition. You can also specify the same filter more than once. The order in which filters are defined here will be the order in which the filters will be called during the analysis chain.

