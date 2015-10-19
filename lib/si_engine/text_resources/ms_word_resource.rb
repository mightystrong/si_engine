# This class was NOT originally included in one file; see src/part1/text-resource.rb
# It is a custom class written to handle MS Word files within the context of the
# TextResource class using the anitword gem: https://github.com/yagudaev/ruby-antiword

# SPECIAL NOTES
# Word-To-Markdown
# The word-to-markdown gem has also been included but it requires soffice
# provided by LibreOffice, which needs to be installed on your computer.

# Antiword
# The antiword gem allows for running antiword in backquotes e.g. text = `antiword text.doc`
# It's packaged with the gem so you don't need to install it on your computer.
# According to the gem's author it can be run on Heroku. (NOT TESTED)
# Antiword will not read .docx files so they must be converted to .doc files first.
# A test file has been provided: path = SiEngine::Engine.root/app/assets/docs/test_word_doc.doc

module SiEngine
  class MSWordResource < TextResource
    def initialize(source_uri='')
      super(source_uri)
      text = `antiword #{source_uri}`
      @plain_text = cleanup_plain_text(text)
    end
  end
end
