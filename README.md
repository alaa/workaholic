### Workaholic
==========
Ruby Gem to find long running child processes like cron jobs.

### Usage

Install workaholic and look for cron jobs that have been running for
more than 5 minutes.

  `gem install workaholic-cron`

  `require 'workaholic'`

  `workers = Workaholic.new 'cron', 300`

  `workers.scan`

### Retrun

Returns a Hash of pid:elapsedtime of all long-running cron jobs.

  `=> {:"4389"=>52205, :"4335"=>52216, :"4342"=>52216}`

### License
The MIT license.
