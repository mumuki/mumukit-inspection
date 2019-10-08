require 'mulang'

I18n.load_translations_path File.join(__dir__, 'locales', '*.yml')

module Mumukit
  module Inspection
    module Extension
      def new_inspection(match)
        if match
          Mulang::Inspection.new match['type'],
                                Mulang::Inspection::Target.new(:unknown, match['target']),
                                negated: match['negation'].present?,
                                i18n_namespace: 'mumukit.inspection'
        end
      end
    end

    module Css
      extend Mumukit::Inspection::Extension

      REGEXP = /^(?<negation>Not:)?(?<type>DeclaresStyle|DeclaresTag):(?<target>.*)$/

      def self.parse(inspection_s)
        new_inspection REGEXP.match(inspection_s)
      end
    end

    module Source
      extend Mumukit::Inspection::Extension

      REGEXP = /^(?<negation>Not:)?(?<type>SourceRepeats|SourceContains|SourceEquals|SourceEqualsIgnoreSpaces):(?<target>.*)$/

      def self.parse(inspection_s)
        new_inspection REGEXP.match(inspection_s)
      end
    end
  end
end
