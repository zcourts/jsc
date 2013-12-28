module JSC
  module Plugin
    attr_reader :site, :ctx

    def config
      @config                              ||= Hash.new
      @config['match_jax']                 ||= Hash.new
      @config['match_jax']['config']       ||= 'default.js'
      @config['match_jax']['local_config'] ||= ''
      @config['match_jax']['url']          ||= ''
      @config
    end

    def set_ctx(ctx)
      @ctx, @site, = ctx, ctx.registers[:site]
      @config      = @site.config['jsc'] || {}
      ctx['jsc']   ||= {}
    end

    def mj_config
      config['match_jax']['config']
    end

    def mj_local?
      !config['match_jax']['local_config'].empty?
    end

    def mj_local
      mj_local? ? ',' + config['match_jax']['config'] : ''
    end

    def mj_url
      config['match_jax']['url'].empty? ? 'http://cdn.mathjax.org/mathjax/latest/MathJax.js' : config['match_jax']['url']
    end

    def math_jax
      r                         = !ctx['jsc']['mj_injected'] ?
          "<script type=\"text/javascript\" src=\"#{mj_url}?config=#{mj_config}#{mj_local}\"></script>" : ''
      ctx['jsc']['mj_injected'] ||= true
      r
      #todo need to modify   loadComplete     http://docs.mathjax.org/en/latest/configuration.html#local-config-files
    end
  end
end