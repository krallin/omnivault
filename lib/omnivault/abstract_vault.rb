module Omnivault
  class AbstractVault
    def self.from_env
      case ENV['VAULT']
      when 'apple', 'AppleKeychain'
        AppleKeychain.new
      when 'pws', 'PWS'
        PWS.new
      end
    end

    def self.for_platform
      if (/darwin/ =~ RUBY_PLATFORM).nil?
        PWS.new
      else
        AppleKeychain.new
      end
    rescue LoadError
      PWS.new
    end
  end
end
