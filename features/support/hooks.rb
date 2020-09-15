#utf-8
require "report_builder"
require "date"

Before do |scenario|
  # class's instancies
  # Class Login
  @validar = ValidarScreen.new

  visit $BASE_URL
end 

def add_screenshot(scenario)
  sufix = ('error' if scenario.failed?) || 'success'
  name = scenario.name.tr(' ', '_').downcase
  foto = save_screenshot("images/#{sufix}-#{name}.png")
  base64_img = Base64.encode64(File.open(foto, 'rb:UTF-8', &:read))
  attach(base64_img, 'image/png;base64')
end

def exception_message(scenario)
  scene = scenario.failed?
  return unless scene == true

  log("\n\n----------------------------------------------")
  log('Reason:')
  log(scenario.exception.message.to_s)
  log("----------------------------------------------\n\n")
end

After do |scenario|
  add_screenshot(scenario)
  exception_message(scenario)
end

AfterConfiguration do |config|
  config.on_event(:test_case_finished) do |event|
    puts "\n\nResults:"
    puts '----------------------------------------------'
    puts "Scenario: #{event.test_case.name}"
    puts "The results is: #{event.result}"
    puts "----------------------------------------------\n\n"
  end
end

at_exit do   
  ReportBuilder.configure do |config|
    config.input_path = 'logs/report.json'
    config.report_path = 'logs/report'
    config.report_types = [:html]
    config.report_title = 'Yaman'
    config.color = "indigo"
    config.additional_info = {browser: 'chrome', environment: ENV['TEST_ENV']}
    end
  ReportBuilder.build_report
end