module Wac
  class Pod
    include XmlContainer
    include Enumerable
    
    attr_reader :subpods, :query, :states

    delegate :[], :each, :to => :subpods

    def self.collection(xml, options = {})
      Nokogiri::XML(xml.to_s).search('pod').map {|p_xml| new(p_xml, options)}
    end
    
    def initialize(xml, options = {})
      @query = options[:query]
      @xml = Nokogiri::XML(xml.to_s).search('pod').first
      @subpods = Subpod.collection(@xml.search('subpod'), options)
      @states = State.collection(@xml.search('states'), options)
      @xml or raise MissingNodeError, "<pod> node missing from xml: #{xml[0..20]}..."
      types.each {|type| extend type}
    end
    
    def to_s
      "#{title}: #{structured? ? plaintext : "'#{markup[0..20]}...'"} #{states.join(", ") if states.any?}"
    end
    
    def inspect
      "#<#{scanner}: #{to_s}>"
    end
    
    def types
      @types ||= scanner.split(',').map {|type| Wac.mixin(Result, type)}
    end
    
    def plaintext
      subpods.detect(&:plaintext).try(:plaintext)
    end
    
    def img
      subpods.detect(&:img).try(:img)
    end
    
    def markup
      @markup ||= (xml.search('markup').text || '')
    end
    
    def structured?
      subpods.any?
    end
    
    class Subpod
      include XmlContainer
      
      def self.collection(xml, options = {})
        Nokogiri::XML(xml.to_s).search('subpod').map {|s_xml| new(s_xml, options)}
      end

      def initialize(xml, options = {})
        @query = options[:query]
        @xml = Nokogiri::Slop(xml.to_s).search('subpod').first
        @xml or raise MissingNodeError, "<subpod> node missing from xml: #{xml[0..20]}..."
      end
      
      def plaintext
        xml.plaintext.try(:text)
      end
      
      def img
        xml.img
      end
    end
    
    class State
      attr_reader :name
      
      def self.collection(xml, options = {})
        Nokogiri::XML(xml.to_s).search('state').map {|s_xml| new(s_xml['name'], options)}
      end

      def initialize(name, options = {})
        @query = options[:query]
        @name = name
      end

      def to_query(key)
        name.to_query(key)
      end
      
      def to_s
        "[#{name}...]"
      end
      
      def inspect
        "#<State: #{to_s}>"
      end
      
      # create a new query using this state
      def requery
        if podstate = @query.query_options[:podstate]
          podstate = State.new("#{podstate.name},#{name}", :query => @query)
        else
          podstate = self
        end
        
        Query.new(@query.input, @query.options.merge(:session => @query.session, :podstate => podstate))
      end
      
      # refetch using this state
      def refetch
        requery.fetch
      end
    end
  end
end