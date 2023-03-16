module EbDeployer
  class InactiveSmokeTest
    def initialize(test_body, settings)
      @test_body = test_body
      @settings = settings
    end

    def run(host_name, logger=nil)
      return unless @test_body
      logger.log("running smoke test for #{host_name}...") if logger

      case @test_body
      when Proc
        @test_body.call(host_name, @settings)
      when String
        eval(@test_body, binding)
      else
        raise "smoke test can only be a string to evaluate or a proc object such as lambda"
      end

      logger.log("smoke test succeeded.") if logger
    end
  end
end
