module Dictionary
  class GetData
    PATH = "http://svn.code.sf.net/p/cmusphinx/code/trunk/cmudict/cmudict-0.7b"

    def initialize(dictionary_path=nil, local_path=nil)
      @path = path
      @local_path = local_path
    end

    def path
      @path ||= PATH
    end

    def local_path
      @local_path ||= self.class.data_path
    end

    def request
      RestClient.get(path)
    end

    def response
      @response ||= request
    end

    def perform
      raise "Could not get dictionary file" unless response.code == 200
      File.open(local_path, "w") {|f| f.write(response.to_str.force_encoding('ISO-8859-1').encode('UTF-8')) }
    end

    def self.data_path
      Rails.root.to_s + "/app/models/dictionary/data.txt"
    end
  end
end
