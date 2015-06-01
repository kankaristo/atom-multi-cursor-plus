# multi-cursor-plus

https://atom.io/packages/multi-cursor-plus

`multi-cursor-plus` allows you to create multiple cursor anywhere in a buffer
using only your keyboard.

To avoid conflicts with Atom's core and other packages, **this package does not
define any key bindings by default**.

See the *Key bindings* section for a set of "recommended" key bindings.

**TODO: Add a GIF showcase. Send me one, if you'd like!**


## Usage

The basic usage of this package (with the "recommended" key bindings) goes like
this:
- Move to where you want your first cursor to be
- "Mark" this position with `Alt-X` (`multi-cursor-plus:mark`)
- Move to a new position while holding down `Alt` (`multi-cursor-plus:move-*`)
- "Mark" the new position
- Rinse and repeat!

If you want to remove one of your cursors, just "mark" it again!

The package provides all the usual movement and selection commands. You can move
to the beginning of the line with `Alt-Home`, select text by holding down `Alt`
and `Shift`, etc.

In short: do everything you normally do, just add the `Alt` key.


**NOTE:**  
This package is meant for "keyboard only" navigation. Atom already has support
for multiple cursors if you use the mouse (`Ctrl-click`). This works seamlessly
with `multi-cursor-plus`.


## Installation

1. Either go to Settings > Install and search for `multi-cursor-plus`.
2. Add key bindings to `~/.atom/keymap.cson` (also available via Settings >
   Keybindings > "your keymap file"). You can use the "recommended" key bindings
   below and customize them to your liking.


## Key bindings

Below is a "recommended" set of key bindings, which you can add to your
`keymap.cson`. Please note that these key bindings override Atom's default
multi-cursor functionality.

```
'atom-workspace':
  # Key bindings for multi-cursor
  'alt-x':                'multi-cursor-plus:mark'
  'alt-up':               'multi-cursor-plus:move-up'
  'alt-down':             'multi-cursor-plus:move-down'
  'alt-left':             'multi-cursor-plus:move-left'
  'alt-right':            'multi-cursor-plus:move-right'
  'ctrl-alt-left':        'multi-cursor-plus:move-to-beginning-of-word'
  'ctrl-alt-right':       'multi-cursor-plus:move-to-end-of-word'
  'alt-home':             'multi-cursor-plus:move-to-first-character-of-line'
  'alt-end':              'multi-cursor-plus:move-to-end-of-line'
  'ctrl-alt-home':        'multi-cursor-plus:move-to-top'
  'ctrl-alt-end':         'multi-cursor-plus:move-to-bottom'
  'alt-shift-up':         'multi-cursor-plus:select-up'
  'alt-shift-down':       'multi-cursor-plus:select-down'
  'alt-shift-left':       'multi-cursor-plus:select-left'
  'alt-shift-right':      'multi-cursor-plus:select-right'
  'ctrl-alt-shift-left':  'multi-cursor-plus:select-to-beginning-of-word'
  'ctrl-alt-shift-right': 'multi-cursor-plus:select-to-end-of-word'
  'alt-shift-home':       'multi-cursor-plus:select-to-first-character-of-line'
  'alt-shift-end':        'multi-cursor-plus:select-to-end-of-line'
  'ctrl-alt-shift-home':  'multi-cursor-plus:select-to-top'
  'ctrl-alt-shift-end':   'multi-cursor-plus:select-to-bottom'
```

**Also recommended:**  
Substitute `up/down/left/right` with `i/k/j/l` or `w/s/a/d` so you don't even
have to reach for the cursor keys. ;)


## Known issues

Currently you cannot mark the first *and* last positions in the buffer. Pull
request are welcome to fix this!

Don't hesitate to report any issues you have! Before sending in a pull request,
consider creating an issue for discussion. :)


## Other recommended packages

If you're a fan of "keyboard only" navigation, have a look at these packages:
- [ctrl-dir-scroll](https://atom.io/packages/ctrl-dir-scroll)
- [line-jumper](https://atom.io/packages/line-jumper)
  (*note:* conflicts with "recommended" key bindings)
- [easy-motion-redux](https://atom.io/packages/easy-motion-redux)
