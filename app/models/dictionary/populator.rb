module Dictionary
  class Populator
    def initialize(path=nil)
      @path = path
    end

    def path
      @path ||= GetData.data_path
    end

    def perform
      File.open(path, "r").each do |text|
        line = Line.new(text)
        next unless line.word?
        line.save
      end
    end

    class Line
      attr_reader :text

      def initialize(text)
        @text = text || ""
      end

      def word?
        !!attribute_matches
      end

      def save
        Persistence::Word.create(attributes)
      rescue ActiveRecord::RecordNotUnique
        Persistence::Word.where(english: attributes[:english]).first.update_attributes(attributes)
      end

      def attributes
        {
          english: english,
          phonetic: phonetic
        }
      end

      def attribute_matches
        matches = text.match(/^([A-Z0-9']+)\s+([ A-Z0-9]+)/)
        matches && matches[1] && matches[2] ? matches : nil
      end

      def english
        attributes && attribute_matches[1].downcase
      end

      def phonetic
        attributes && attribute_matches[2].downcase
      end
    end
  end
end
