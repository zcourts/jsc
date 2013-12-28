module JSC
  module Plugin
    attr_reader :key, :site, :ctx

    def config
      @config                                  ||= Hash.new
      @config['bibtex']                        ||= Hash.new
      #apa, mla etc, any valid CSL style
      @config['bibtex']['style']               ||= 'apa'
      #language to use when formatting localized terms e.g. 'Eds.' for editors in en
      @config['bibtex']['locale']              ||= 'en'
      @config['bibtex']['format']              ||= 'html'
      #prefix used when generating links to references
      @config['bibtex']['prefix']              ||= 'ref'
      #directory where bib files are located
      @config['bibtex']['dir']                 ||= 'bibtex'
      #list of bib files to use to lookup citations
      @config['bibtex']['file']                ||= 'references.bib'
      @config['bibtex']['include_unused_refs'] ||= false
      @config['bibtex']['missing_ref']         ||= 'missing-ref(%s)'
      @config['bibtex']['bib_template']        ||= '%{reference}'
      @config['bibtex']['query']               ||= '@*'
      @config
    end

    def missing_ref(key)
      sprintf config['bibtex']['missing_ref'], key
    end

    def prefix
      config['bibtex']['prefix']
    end

    def entries
      bib[config['bibtex']['query']]
    end

    def bib
      ctx['jsc']['bib'] ||= BibTeX.open(File.join(config['bibtex']['dir'], config['bibtex']['file']))
      ctx['jsc']['bib']
    end

    def link_to(href, content, attributes = {})
      content_tag :a, content || href, attributes.merge(:href => href)
    end

    def set_ctx(ctx)
      @ctx, @site, = ctx, ctx.registers[:site]
      @config      = @site.config['jsc'] || {}
    end

    def content_tag(name, c_or_a, attributes = {})
      if c_or_a.is_a?(Hash)
        content, attributes = nil, c_or_a
      else
        content = c_or_a
      end

      attributes = attributes.map { |k, v| %Q(#{k}="#{v}") }

      if content.nil?
        "<#{[name, attributes].flatten.compact.join(' ')}/>"
      else
        "<#{[name, attributes].flatten.compact.join(' ')}>#{content}</#{name}>"
      end
    end

  end
end