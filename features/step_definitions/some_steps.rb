
Given /^That I am "([^\"]*)"$/ do |arg1|
  # Anyone will make this test pass
end

When /^I am on the homepage$/ do
  # Here is the Nokogiri way:
  @rspns= get "/"
  @ndoc= Nokogiri::HTML(@rspns.body)
  # Here is the webrat way:
  visit "/"
end

Then /^I should see "([^\"]*)"$/ do |arg1|
  # @ndoc.css("h1")[0].content.should match /Haml on Sinatra Example/
  @ndoc.css("h1")[0].content.should match(Regexp.new(arg1))

  # Here is the webrat way:
  last_response.should contain(arg1)
  last_response.should have_selector("div#header h1")
  last_response.should have_xpath("//body/table/tr/td/div[@id='header']/h1")
end

Then /^I should see the png: svtrain\.png$/ do
  # Here is the Nokogiri way:
  @ndoc.xpath("//img[@id='svtrain']/@src")[0].value.should== "/images/svtrain.png"
  # Here is the webrat way:
  last_response.should have_selector("body table tr td img#svtrain")
  last_response.should have_xpath("//body/table/tr/td/img[@id='svtrain'][@src='/images/svtrain.png']")
end


Then /^On LHS I should see links: "([^\"]*)"$/ do |arg1|
  links_from_dot_feature= arg1.split
  lhs_links_from_page= @ndoc.css("table tr#tr_two td#td_lhs a").map{ |ae| ae.content}
  lhs_links_from_page.sort.should== links_from_dot_feature.sort
end



