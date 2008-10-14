$:.unshift File.join(File.dirname(__FILE__))

require 'auto_it'

class AutoItWindow
  def initialize(autoit, title, text=nil)
    @autoit = autoit
    @title = title
    @text = text
  end

  def self.wait_for(autoit, title, text = nil)
    window = self.new(autoit, title, text)
    window.wait_for_appear
    window
  end

  def self.on_activation(autoit, title, text = nil)
    window = wait_for(autoit, title, text)
    yield window
  end

  def wait_for_activation
    @autoit.WinWaitActive(@title, @text, 30)
  end

  def wait_for_appear
    @autoit.WinWait(@title, @text, 30)
  end

  def activate
    @autoit.WinActivate(@title, @text)
  end

  def active?
    1 == @autoit.WinActive(@title, @text)
  end

  def state
    AutoItWindowState.new(@autoit.WinGetState(@title, @text))
  end

  def send_keys(keys)
    activate_if_needed
    @autoit.Send(keys)
  end

  def close
    @autoit.WinClose(@title)
  end

  def activate_if_needed
    winstate = state
    activate unless winstate.active?
  end
end

class AutoItWindowState
  def initialize(state)
    @state = state
  end

  def exists?
    @state & 1 > 0
  end

  def visible?
    @state & 2 > 0
  end

  def enabled?
    @state & 4 > 0
  end

  def active?
    @state & 8 > 0
  end

  def minimized?
    @state & 16 > 0
  end

  def maxmized?
    @state & 32 > 0
  end
end
