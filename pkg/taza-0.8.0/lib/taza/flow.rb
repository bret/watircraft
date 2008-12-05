module Taza
  # Flows provide a way to write and manage common actions on a site.
  # For instance, on an e-commerce site you may have multiple tests where a user is supposed to create a 
  # new account and add a product to the shopping bag. In this case you could have two flows. create_an_account 
  # and add_product_to_bag.
  #
  # Here's how you would get this started where your site is called Widgets of the Future:
  #   $ ./script/generate flow create_an_account widgets_of_the_future
  #   $ ./script/generate flow add_product_to_bag widgets_of_the_future
  #
  #   This will generate flows for you in lib/sites/widgets_of_the_future/flows/
  #
  #   From here you can create the logic needed to perform these flows without ever referencing a browser object:
  #
  #   module WidgetsOfTheFuture
  #     class WidgetsOfTheFuture < Taza::Site
  #       def create_an_account_flow(params={})
  #         home_page.create_an_account_link.click
  #         create_an_account_page do |cap|
  #           cap.email.set params[:email]
  #           cap.password.set params[:password]
  #           cap.submit.click
  #         end
  #       end
  #     end
  #   end
  #
  #
  #   Then inside a spec or test you could run this flow like:
  #
  #   describe "Widgets of the Future" do
  #     it "should do widgety things so that we can make more monies" do
  #       WidgetsOfTheFuture.new do |w|
  #         w.create_an_account_flow :email => "i.am@the.widget.store.com", :password => "secret"
  #       end
  #     end
  #   end
  class Flow
  end
end
