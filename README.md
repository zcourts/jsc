__J__ekyll __Sc__ientific plugin - JSC
===

A plugin which extends markdown to include features akin to Latex's that make markdown viable for research write-ups.

# How to use it

In your Jekyll _config.yaml file add a gems array and add jsc to it as in
gems : [jsc]

On the command line run

``` bash
   gem install jekyll-scientific
```

That's it, plugin specific config options are included below.

## What it supports Support

* Adds proper formula via [MathJax](http://www.mathjax.org/)
* Citation support for bib files [bibtex-ruby](https://github.com/inukshuk/bibtex-ruby), and [CSL](https://github.com/citation-style-language/styles)

### Todo

* Add [pandoc](http://johnmacfarlane.net/pandoc/) support so that Jekyll site can be completely written in LateX or another format and output to HTML and PDF.
See [pandoc-multiple-formats](https://github.com/fauno/jekyll-pandoc-multiple-formats) or [pandoc-plugin](https://github.com/dsanson/jekyll-pandoc-plugin)

* Unfortunately you can't run custom plugins with GitHub pages (for obv. reasons). So JSC sites need to be built locally and their _site directory pushed to GitHub.
One the list of things to do is use git hooks to automatically build the jekyll site see [Git global hooks](http://stackoverflow.com/a/8842663/400048) and  [Githooks](http://githooks.com/)

# Configuration

Various config options are available for each plugin included.

## Citations

Citations are provided by [jekyll-scholar](https://github.com/inukshuk/jekyll-scholar/).
Visit the link for detailed covered of available options and usage.
In summary the following options are available to configure how citations work

``` yaml
   scholar:
     style: apa
     locale: en

     sort_by: none
     order: ascending

     source: bibtex #says refereces.bib stored in bibtex folder
     bibliography: references #says a file called bibtex/references.bib is the main bib file
     bibliography_template: "%{reference}"

     details_dir:    bibliography
     details_layout: bibtex.html
     details_link:   Details

     query: "@*"
```
To cite a work from the main bib fileuse the cite tag as in:
e.g. {% cite kirsch2006distance %} would cite the entry with the given name.
To append a list of references at the bottom of the page or post use the references tag as in:
{% bibliography -c %},-c tells it to only include citations used on the current page or post without -c all entries from the bibliography file will be listed


## LateX math / Formulas

Formulas are done using the MathJax library. There are two tags available for adding math.

1. {% m %} and {% em %}  pairs are used to add math inline i.e. within a sentence

2. {% math %} and {% endmath %} pairs are used to add math in a centered block as is typical in LateX documents.

For e.g.

``` latex

{% m %}
	e = mc^2
{% em %}

{% math %}
\mathbf{V}_1 \times \mathbf{V}_2 =  \begin{vmatrix}
\mathbf{i} & \mathbf{j} & \mathbf{k} \\
\frac{\partial X}{\partial u} &  \frac{\partial Y}{\partial u} & 0 \\
\frac{\partial X}{\partial v} &  \frac{\partial Y}{\partial v} & 0
\end{vmatrix}
{% endmath %}

```
### todo

Formulas are currently not as configurable as they could be. MathJax has a lot of config options that could be added.