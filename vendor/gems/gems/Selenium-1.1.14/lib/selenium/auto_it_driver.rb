module Selenium
class AutoIt
  @@autoit = nil

  def self.load
    begin
      @@autoit = load_instance
    rescue WIN32OLERuntimeError
      registerAutoItDll
      @@autoit = load_instance
    end
    @@autoit
  end

  def self.load_instance
    @@autoit = WIN32OLE.new('AutoItX3.Control') unless @@autoit
    @@autoit
  end

  def self.reset
    if @@autoit
      @@autoit.ole_free
      @@autoit =nil
      system("regsvr32.exe /s /u #{dll}")
    end
  end

  def self.registerAutoItDll
    system("regsvr32.exe /s #{dll}")
  end

  def self.dll
    File.join(File.dirname(__FILE__), 'autoit', 'AutoItX3.dll')
  end

  def initialize
    @autoit = AutoIt.load
  end

  def on_window_active(title, text = nil)
    @autoit.WinWaitActive(title, text, 30)
    yield @@autoit
  end
end
end