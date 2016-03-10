## CompleteMe

__CompleteMe__ explores using a trie to create a simple textual autocomplete system providing the following features:

1. Insert a single word to the autocomplete dictionary
2. Count the number of words in the dictionary
3. Populate a newline-separated list of words into the dictionary
4. Suggest completions for a substring
5. Mark a selection for a substring
6. Weight subsequent suggestions based on previous selections

### Basic Interaction Model

You can interact with __CompleteMe__ from a pry session, using the following model:

```ruby
# open pry from root project directory
require "./lib/complete_me"

completion = CompleteMe.new

completion.insert("pizza")

completion.count
=> 1

completion.suggest("piz")
=> ["pizza"]

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.count
=> 235886

completion.suggest("piz")
=> ["pizza", "pizzeria", "pizzicato"]
```

### Usage Weighting

In order to provide better suggestions over time, CompleteMe can be "trained" based on a user's actual selections. So, if a user consistently selects "pizza" in response to completions for "pizz", pizza becomes their first suggestion when "pizz" is entered.

To facilitate this, the library supports a `select` method, which takes a substring and the selected suggestion. This selection is recorded in the trie, and used to influence future suggestions

Here's what that interaction model looks like:

```ruby
require "./lib/complete_me"

completion = CompleteMe.new

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.suggest("piz")
=> ["pizza", "pizzeria", "pizzicato"]

completion.select("piz", "pizzeria")

completion.suggest("piz")
=> ["pizzeria", "pizza", "pizzicato"]
```


### Substring-Specific Selection Tracking

In order to provide more sophisticated suggestions, selection information is tracked _per completion string_. That is, when `select`ing a given word, that selection is only counted toward subsequent suggestions against the same substring. Here's an example:

```ruby
require "./lib/complete_me"

completion = CompleteMe.new

dictionary = File.read("/usr/share/dict/words")

completion.populate(dictionary)

completion.select("piz", "pizzeria")
completion.select("piz", "pizzeria")
completion.select("piz", "pizzeria")

completion.select("pi", "pizza")
completion.select("pi", "pizza")
completion.select("pi", "pizzicato")

completion.suggest("piz")
=> ["pizzeria", "pizza", "pizzicato"]

completion.suggest("pi")
=> ["pizza", "pizzicato","pizzeria"]
```

In this example, against the substring "piz" we choose "pizzeria" 3 times, making it the dominant choice for this substring.

However for the substring "pi", we choose "pizza" twice and "pizzicato" once. The previous selections of "pizzeria" against "piz" don't count when suggesting against "pi", so now "pizza" and "pizzicato" come up as the top choices.


### Data Structure -- Background on Tries

A common way to solve this problem is using a data structure called a [trie](https://en.wikipedia.org/wiki/Trie). The name comes from the idea of a Re-trie-val tree, and it's useful for storing and then fetching paths through arbitrary (often textual) data.

A Trie is somewhat similar to other [binary trees](https://en.wikipedia.org/wiki/Binary_tree) you may have seen before, but whereas each node in a binary tree points to up to 2 subtrees, nodes within our retrieval tries will point to `N` subtrees, where `N` is the size of the alphabet we want to complete within.

Thus for a simple latin-alphabet text trie, each node will potentially have 26 children, one for each character that could potentially follow the text entered thus far. (In graph theory terms, we could classify this as a Directed, Acyclic graph of order 26, but hey, who's counting?)

What we end up with is a broadly-branched tree where paths from the root to the leaves represent "words" within the dictionary.


### Input File

#### The Dictionary

Of course, our Trie won't be very useful without a good dataset
to populate it. Fortunately, our computers ship with a special
file containing a list of standard dictionary words.
It lives at `/usr/share/dict/words`

Using the unix utility `wc` (word count), we can see that the file
contains 235886 words:

```
$ cat /usr/share/dict/words | wc -l
235886
```

Should be enough for us!

#### Denver Addresses

This implementation also provides support for a larger dataset: [this data file](http://data.denvergov.org/dataset/city-and-county-of-denver-addresses) which contains all the known addresses in the city of Denver.


## Support Tooling

This project also includes support for the following:

* [SimpleCov](https://github.com/colszowka/simplecov) reporting accurate test coverage statistics
* [TravisCI](https://travis-ci.org/) running your all your tests and they all pass
* [CodeClimate](https://codeclimate.com/github/signup) evaluating the quality of your code (best to set it up early to see the change over time)
