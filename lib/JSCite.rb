require 'bibtex'
require 'citeproc'
require File.dirname(__FILE__) + '/plugin'

module JSC
  class JSCite < Liquid::Tag
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
      ctx['jsc']['cited'] << key
      entry = bib[key.to_s.strip]
      if entry == nil
        missing_ref key
      else
        puts 'entry'
        puts entry
        puts 'citeproc'
        puts entry.to_citeproc
        puts 'key'
        puts entry.key
        citation = CiteProc.process entry.to_citeproc,
                                    :style  => config['bibtex']['style'],
                                    :locale => config['bibtex']['locale'],
                                    :format => config['bibtex']['format'],
                                    :mode   => :citation
        puts 'citation'
        puts citation
        link_to "##{[prefix, key].compact.join('-')}", citation.join
      end
    end
  end
end
Liquid::Template.register_tag('Xcite', JSC::JSCite)