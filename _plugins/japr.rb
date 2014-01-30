require 'japr'

module JAPR
  # SASS preprocessor
  class SassConverter < JAPR::Converter
    require 'sass'

    def self.filetype
      '.scss'
    end

    def convert
      return Sass::Engine.new(@content, syntax: :scss).render
    end
  end

  # CSS -> Yahoo YUI compressor
  class CssCompressor < JAPR::Compressor
    require 'yui/compressor'

    def self.filetype
      '.css'
    end

    def compress
      return YUI::CssCompressor.new.compress(@content)
    end
  end

  # JS -> Google Closure Compiler compressor
  class JavaScriptCompressor < JAPR::Compressor
    require 'closure-compiler'
  
    def self.filetype
      '.js'
    end
  
    def compress
      return Closure::Compiler.new(:compilation_level => "SIMPLE_OPTIMIZATIONS").compile(@content)
    end
  end
end
