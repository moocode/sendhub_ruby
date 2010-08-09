module Sendhub
  class Response
    attr_accessor :id, :status, :from, :to, :error
    def initialize(params={})
      @id = params['id']
      @status = params['status']
      @from = params['from']
      @to = params['to']
      @error = params['error']
    end
  end
end