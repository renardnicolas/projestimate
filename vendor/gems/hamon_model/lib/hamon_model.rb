require "hamon_model/version"

module HamonModel
  class HamonModel
    attr_accessor :k, :r, :p, :m, :e, :s, :d

    def initialize(input)
      @k = input[:ksloc].blank? ? @k = nil : @k = input[:ksloc].to_f
      @r = input[:real_time_constraint].blank? ? @r = nil : @r = input[:real_time_constraint].to_f
      @p = input[:platform_maturity].blank? ? @p = nil : @p = input[:platform_maturity].to_f
      @m = input[:methodology].blank? ? @m = nil : @m = input[:methodology].to_f
    end

    def get_effort_man_week
      begin
        (450/(@p+@m))*(1 - Math.exp(((-1)*@k*@k*0.01)/32))
      rescue
        nil
      end
    end

    def get_schedule
      begin
        (@k/2.5)*(1+(@r/10))
      rescue
        nil
      end
    end

    def get_defects
      begin
        (Math.sqrt(@k))*@k*(1/@m)
      rescue
        nil
      end
    end
  end
end
