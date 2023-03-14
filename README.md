# *Focusrite Control* Command Line Reset script for MacOS

Fix the "No Hardware Connected" error given by "Focusrite Control"
<a href="scarlett-18i20.png"><img src="scarlett-18i20.png" width="100%"></img></a>
Reset the `Focusrite Control` daemon for the Focusrite Scarlett 18i20 audio interface, on MacOS.

## Usecase:
- We've been running multiple Focusrite `Scarlett 18i20 Gen 3`s into a MacBookPro.
- MacOS supports multiple USB audio interfaces well, this is fine.
- It's been working really well, for >1 year (so far) with multiple `Scarlett 18i20`s and `OctoPre Dynamic`, for 24 analog inputs!
- We're using an `Aggregate Device` in the MacOS's `Audio MIDI Setup` to make the 2 `Scarlett 18i20`s look like one audio device to apps like `Ableton Live`
- Been really happy with this setup
- It allows us to incrementally expand the studio as need arrises, over time, in a budgeted way ($500 per every 8 added inputs).
- Using the S/PDIF IO, we can even monitor the entire sound as well.

## Background
- Focusrite wants you to buy up to their more expensive line and claims "multiple Scarletts aren't supported by our driver".  Which isn't 100% true.
- As it turns out, **USB Audio** on MacOS supports multiple Scarletts really well, but **Focusrite Control** does not, which is an app used to edit mix settings inside the `Scarlett 18i20`.
- `Focusrite Control` could, but doesn't, have a selector for which `Scarlett 18i20` you're editing, and thus doesn't work with more than 1 plugged in at once, there's no way to switch to the other Scarlett, which is a frustrating problem.  But is easy to solve by juggling the USB cables.
- There's no reason a programmer couldn't add a selector, other than funneling customers to more expensive products...
- But we can still run `Focusrite Control` with only one Scarlett connected:
  - Whichever Scarlett we want to edit, is the only USB cable we plug in (unplug the other).
- Which works well for a while...

## Problem:
- Which works well for a while...  Until it doesn't.  `Focusrite Control` kind of corrupts itself after some days/weeks/months of MacOS uptime.
- The `Focusrite Control` app can start to give a `No Hardware Connected` message, even though only one `Scarlet 18i20` is properly connected.
- `Focusrite Control` is clearly confused, or corrupted...  (or perhaps engineered to upsell their pro product line).

## Solution:
- Focusrite's knowledge base gives us the troubleshooting solution to "Quit" the `FocusriteControlService` in MacOS's `Activity Monitor`.
- This can be a pain to hunt for every time (and seriously impacts workflow during the creative process).
- So I've written a [command line script](scarlett_reset.sh) to quickly restart the `FocusriteControlService` from the MacOS *Terminal*

Enjoy!


# Running:
```
# load the function
# put this in your .bashrc, or you can manually run it from a bash shell (to load the function)
  $ source scarlett_reset.sh

# reset your device  (run the bash function)
  $ scarlett_reset

# alternatively, you can uncomment the last line of the script to auto-run on load...
```

# Connection Diagram (how'd we get 24 inputs?)
This is how:
<a href="scarlett-18i20.png"><img src="scarlett-18i20.png" width="100%"></img></a><BR>
<a href="scarlett-18i20-2.png"><img src="scarlett-18i20-2.png" width="100%"></img></a><BR>
<a href="octopre-dynamic-2.png"><img src="octopre-dynamic-2.png" width="100%"></img></a>

And actually, we get 26 analog inputs (2 for blutooth).

Wiring of 2 `Scarlett 18i20 Gen3`s + 1 `OctoPre Dynamic` + bluetooth audio (hey, we wanted to listen to our phone!):
<a href="connection.jpg"><img src="connection.jpg" width="100%"></img></a>

- 24 analog inputs + 2 bluetooth (1 L, 1 R)  (want more?  add another octopre for 32;  or add another scarlet, repeat... etc.)
- Bluetooth Audio input:
  - Here we "save 2 inputs" by using the open S/PDIF stereo input, for our Blutooth audio.
    - To use S/PDIF as an input for Scarlett 18i20, it must be the clocksource.
  - S/PDIF clocksource needs to be stable, so Dont use a blutooth audio device directly:
    - most blutooth devices turn off their digital output when not connected, which kills the entire pipeline (no clock source, your Scarletts are dead).
  - So, get an "always on" A2D (analog to digital) device that runs at 48kHz (see TOHILKEL device pictured above).
    - Select a device with acceptable S/PDIF sample rate, since it clocks your entire rig
    - 48kHz is better than 44hKz... anything faster wont work, with octopre also attached.   So 48hKz is a good goal.
    - Both `Scarlett 18i20` set to `clocksource == S/PDIF`
    - ...if you skip the bluetooth audio-in, then instead set `clocksource == internal` for the First (`Scarlett B` pictured) and `clocksource == S/PDIF` for the Second (`Scarlett A` pictured)
