class Parser::Error < StandardError
  attr_reader :parser

  def initialize(parser)
    @parser = parser
  end
end