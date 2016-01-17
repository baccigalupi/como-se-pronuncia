module Dictionary
  class Codes < Struct.new(:code_string)
    def collection
      @collection ||= code_string.split(/\W+/)
    end

    def phonetics
      collection.map {|code| Code.fetch(code) }
    end

    class Code < Struct.new(:sound, :augmentation)
      attr_accessor :weight

      def weight
        @weight || 0
      end

      TRANSLATION = {
        'aa'  => Code.new('a'),
        'ae'  => Code.new('ae'),
        'ah'  => Code.new('a', 'a/o'),
        'ao'  => Code.new('o', 'o/a'),
        'aw'  => Code.new('au'),
        'ay'  => Code.new('ai'),
        'b'   => Code.new('b'),
        'ch'  => Code.new('ch'),
        'd'   => Code.new('d', 'd-hard'),
        'dh'  => Code.new('d'),
        'eh'  => Code.new('e'),
        'er'  => Code.new('er'),
        'ey'  => Code.new('ei'),
        'f'   => Code.new('f'),
        'g'   => Code.new('g'),
        'hh'  => Code.new('j'),
        'ih'  => Code.new('i', 'i/e'),
        'iy'  => Code.new('i'),
        'jh'  => Code.new('ch', 'dy'),
        'k'   => Code.new('c'),
        'l'   => Code.new('l'),
        'm'   => Code.new('m'),
        'n'   => Code.new('n'),
        'ng'  => Code.new('ng'),
        'ow'  => Code.new('ou'),
        'oy'  => Code.new('oi'),
        'p'   => Code.new('p'),
        'r'   => Code.new('r'),
        's'   => Code.new('s'),
        'sh'  => Code.new('sh'),
        't'   => Code.new('t'),
        'th'  => Code.new('z', 'z-spanish'),
        'uh'  => Code.new('u', 'u/e'),
        'uw'  => Code.new('u'),
        'v'   => Code.new('v', 'v-hard'),
        'w'   => Code.new('u'),
        'y'   => Code.new('i'),
        'z'   => Code.new('s', 'z-english'),
        'zh'  => Code.new('sh')
      }.freeze

      def self.fetch(phonetic, weight=0)
        matches = phonetic.match(/([a-z]+)(\d+)?/)
        code = TRANSLATION[matches[1]].clone
        code.weight = matches[2]
        code
      end
    end
  end
end
