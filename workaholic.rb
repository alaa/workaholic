#!/bin/ruby
require 'time'

class Workaholic
  # Find long running cron jobs.
  #
  # Example:
  #   >> require 'workaholic'
  #   >> workers = Workaholic.new 'cron', 300
  #   >> workers.scan
  #   => => {:"4389"=>71983, :"4335"=>71994}
  #
  # Arguments:
  #   proccess: (String)
  #   limit: (Int)
  attr_accessor :proccess, :limit

  def initialize proccess, limit
    @proccess = proccess
    @limit = limit.to_i
  end

  def scan
    # Get all child processes of the desired parent process.
    pids = %x(ps -o pid,etime --ppid=`pidof -s #{proccess}` --sort=etime | awk '{print $1,$2}' | tr '-' ' ' | awk '{print $1,$3}' | egrep '^[0-9]' | grep ':')
    workaholics = {}
    pids.each_line do |proccess|
      pid, etime = proccess.split
      workaholics[pid.to_sym] = etime_to_i etime if (etime_to_i etime) > limit
    end
    workaholics
  end

  def etime_to_i etime
    h,m,s = etime.split(':')
    (h.to_i * 60 * 60) + (m.to_i * 60) + (s.to_i) 
  end
end
