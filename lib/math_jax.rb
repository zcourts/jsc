require File.dirname(__FILE__) + '/plugin'
module JSC
  class MathJaxBlock < Liquid::Tag
    include JSC::Plugin

    def render(ctx)
      set_ctx ctx
      math_jax + '<script type="math/tex; mode=display">'
    end
  end
  class MathJaxInline < Liquid::Tag
    include JSC::Plugin

    def render(ctx)
      set_ctx ctx
      math_jax + '<script type="math/tex">'
    end
  end
  class MathJaxEnd < Liquid::Tag
    def render(ctx)
      '</script>'
    end
  end
end

Liquid::Template.register_tag('math', JSC::MathJaxBlock)
Liquid::Template.register_tag('m', JSC::MathJaxInline)
Liquid::Template.register_tag('endmath', JSC::MathJaxEnd)
Liquid::Template.register_tag('em', JSC::MathJaxEnd)