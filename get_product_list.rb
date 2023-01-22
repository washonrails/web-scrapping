require 'mechanize'
require 'logger'

agent = Mechanize.new
agent.log = Logger.new "mech.log"


page = agent.get('http://localhost:3000')
 

login_form = page.form
 

login_form.field_with(name: 'user[email]').value = 'dummy@email.com'
login_form.field_with(name: 'user[password]').value = '123456'
 
product_list_page = agent.submit(login_form)
 

out_file = File.new('product_list.txt', 'w')
out_file.puts 'Product List:'
 
loop do
  
  product_list_page.search('tbody tr').each do |p|
    
    f = p.search('td')
    line = "title: #{f[0].text}, "
    line += "brand: #{f[1].text}, "
    line += "description: #{f[2].text}, "
    line += "price: #{f[3].text}"
    out_file.puts line
  end
 
  
  break unless product_list_page.link_with(text: 'Next ›')
 
  
  product_list_page = product_list_page.link_with(text: 'Next ›').click
end
 
out_file.close
