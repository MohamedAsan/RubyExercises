# Ruby Exercises

## 1 - Polynomials
You just started working for CoolNewCompany which is developing mathematics related software. Since you are new to the team, your boss gives you an easy task to test your abilities. Write a class that pretty-prints polynomials, following some simple rules:

- if a coefficient is 1, it doesn't get printed
- if a coefficient is negative, you have to display something like "-2x^3", not "+-2x^3"
- if a coefficient is 0, nothing gets added to the output
- for x^1, the ^1 part gets omitted
- as x^0 == 1, we don't need to display it

Here's a couple of usage examples:
```ruby
Polynomial.new([-3,-4,1,0,6]) # => -3x^4-4x^3+x^2+6
Polynomial.new([1,0,2]) # => x^2+2
```

Don't concern yourself too much with error handling, but if somebody tries to create a polynomial with less than 2 elements, your program has to raise an `ArgumentError` with the message "Need at least 2 coefficients"

**Requirements:** This has to be a pure Ruby script, using only the Ruby Standard Libraries (meaning, no external Gems). You do not need to build a gem for this. Pure Ruby code is all that is needed.

## 2 - Business Hours
Chunky Bacon Begone is a dry-cleaning company known for its speedy service. The problem is, when the customers drop off the clothes, they need to know what time they are guaranteed to be done.

It is your job to write a ruby script which will determine the guaranteed time given a business hour schedule. You must create a class called `BusinessHours` which allows one to define the opening and closing time for each day. It should provide the following interface:

```ruby
hours = BusinessHours.new("9:00 AM", "3:00 PM")
hours.update :fri, "10:00 AM", "5:00 PM"
hours.update "Dec 24, 2010", "8:00 AM", "1:00 PM"
hours.closed :sun, :wed, "Dec 25, 2010"
```

The `update` method should change the opening and closing time for a given day. The `closed` method should specify which days the shop is not open. Notice days can either be a `symbol` for week days or a `string` for specific dates. Any given day can only have one opening time and one closing time — there are no off-hours in the middle of the day.

A method called `calculate_deadline` should determine the resulting business time given a time interval (in seconds) along with a starting time (as a `string`). The returned object should be an instance of `Time`. Here are some examples:

```ruby
hours.calculate_deadline(2*60*60, "Jun 7, 2010 9:10 AM") # => Mon Jun 07 11:10:00 2010
hours.calculate_deadline(15*60, "Jun 8, 2010 2:48 PM") # => Thu Jun 10 09:03:00 2010
hours.calculate_deadline(7*60*60, "Dec 24, 2010 6:45 AM") # => Mon Dec 27 11:00:00 2010
```

In the first example the time interval is 2 hours (7,200 seconds). Since the 2 hours fall within business hours the day does not change and the interval is simply added to the starting time.

In the second line an interval of 15 minutes (900 seconds) is used. The starting time is 12 minutes before closing time which leaves 3 minutes remaining to be added to the next business day. The next day is Wednesday and therefore closed, so the resulting time is 3 minutes after opening on the following day.

The last example is 7 hours (25200 seconds) which starts before opening on Dec 24th. There are only 5 business hours on Dec 24th which leaves 2 hours remaining for the next business day. The next two days are closed (Dec 25th and Sunday) therefore the deadline is not until 2 hours after opening on Dec 27th.

**Tip:** Use `Time.parse` to generate a `Time` from a `string`. You may need to `require "time"` in order to do this.

**Requirements:** This has to be a pure ruby script, using only the ruby standard libraries (meaning, no external gems, libraries). You do not need to build a gem for this. Pure ruby code is all that is needed.


## 3 - Music Player

Things are pretty quiet at the Head First Lounge. There's a problem with the JukeBox at the Head First Lounge. The guys were working on some of the playlist code and now it's broken :(

The playlist is stored as an `array` of `strings` like this:

```ruby
playlist = ["New York, New York",
"When You're Drinking",
"Fly Me To The Moon",
...
"Mac The Knife"]
```

The playlists can get real long and sometimes customers like to skip ahead by a few tracks using the `skip_tracks()` function:

```ruby
skip_tracks(playlist, 2) # This will skip past the first 2 tracks in the array
```

When the function's called the playlist changes to something like this:

```ruby
["Fly Me To The Moon",
...
"Mac The Knife",
"New York, New York",
"When You're Drinking"]
```

It has moved the first couple of tracks to the end of the `array`.

**Note:** The function should be able to skip by any number of tracks. It should even be able to take negative numbers and skip backwards if someone wants to play some songs again.
