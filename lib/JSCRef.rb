require 'bibtex'
require 'citeproc'
require File.dirname(__FILE__) + '/plugin'

module JSC
  class JSCRef < Liquid::Tag
    include JSC::Plugin

    def initialize(tag_name, markup, tokens)
      super
      @key    = markup
      @config = Hash.new
    end

    def render(ctx)
      set_ctx ctx
      ctx['jsc']          ||= {}
      ctx['jsc']['cited'] ||= []
      refs                = ctx['jsc']['cited'].uniq.map { |key|
        entries.detect { |e| e.key == key.to_s.strip }
      }
      bibliography        = refs.each_with_index.map { |entry, index|
        if entry == nil
          content_tag :li, missing_ref(ctx['jsc']['cited'][index])
        else
          citation = CiteProc.process entry.to_citeproc,
                                      :style  => config['bibtex']['style'],
                                      :locale => config['bibtex']['locale'],
                                      :format => config['bibtex']['format']

          reference = config['bibtex']['bib_template'] % {
              :reference => citation,
              :key       => entry.key,
              :type      => entry.type,
              :index     => index+1
          }

          #link_to "##{[prefix, key].compact.join('-')}", citation.join
          content_tag :li, reference
        end
      }.join("\n")
      content_tag :ol, bibliography
    end
  end
end
Liquid::Template.register_tag('Xrefs', JSC::JSCRef)