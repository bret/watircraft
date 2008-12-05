class Bar < Taza::Page
  element :foo do
    browser
  end

  filter :name => :baz, :elements => [:foo] do
    true
  end
end
