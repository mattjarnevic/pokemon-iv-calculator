# pokemon-iv-calculator

Pokemon Command Line IV Calculator. Does not account for EVs.

## Instructions for Use

Install the gem

`gem install pokemon-iv-calculator`

Open up irb or pry session

Just require the app.

`require 'app'`

It'll automaticall start prompting you for your input!

You can also just require the calculator if you'd rather

`require 'iv-calculator'`

Example Usage:

`calc = IVCalculator.new("marill", "adamant", 10, 37, 13, 18, 8, 18, 16, nil)`

`calc.calculate_ivs`

```ruby
=> ["30-31", "30-31", "30-31", "0-9", "30-31", "30-31"]
```
