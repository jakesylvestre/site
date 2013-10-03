require 'jekyll_asset_pipeline'

module JekyllAssetPipeline
  # SASS preprocessor
  class SassConverter < JekyllAssetPipeline::Converter
    require 'sass'

    def self.filetype
      '.scss'
    end

    def convert
      return Sass::Engine.new(@content, syntax: :scss).render
    end
  end

  # CSS -> Yahoo YUI compressor
  class CssCompressor < JekyllAssetPipeline::Compressor
    require 'yui/compressor'

    def self.filetype
      '.css'
    end

    def compress
      return YUI::CssCompressor.new.compress(@content)
    end
  end

  # JS -> Google Closure Compiler compressor
  class JavaScriptCompressor < JekyllAssetPipeline::Compressor
    require 'closure-compiler'
  
    def self.filetype
      '.js'
    end
  
    def compress
      return Closure::Compiler.new.compile(@content)
    end
  end
end
