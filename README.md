
# CS50 Final Project

#### Video Demo:

[Youtube video](https://www.youtube.com/watch?v=lPs29xJWDwE)

#### Description:

This project is a Small-Scale 2D Game with LOVE 2D and Lua. In this game  ‘Isaac Asimov legacy’ his famous character - robot has 30 second for collect materials
to get score before they disappear. To start the game - press space , return, or left , right, up or down button. Also you can use left, right, up down button to let your robot moves. If you want to quit - press escape button. However, you must collected at least 5 materials, otherwise you will be Space Over.

![alt text](https://github.com/MariaSnegireva/robot/blob/main/robot_preview.gif "GIF")

### Assets used

* https://freesound.org/people/jeremysykes/sounds/341229/
* https://www.fontsquirrel.com/fonts/download/amatic
* https://kenney.nl/assets/toon-characters-1
* https://opengameart.org/content/rocket

music by David Bowie – Space Oddity

#### Optional

[download LÖVE 2d](https://love2d.org/)

### Middleclass

A simple OOP library for Lua. It has inheritance, metamethods (operators), class variables and weak mixin support.

### Installation

Just copy the middleclass.lua file wherever you want it (for example on a lib/ folder). Then write this in any Lua file where you want to use it:

```lua
  local class = require 'middleclass'
```

### License

Middleclass is distributed under the MIT license.

### Stateful

* Classes gain the capacity of creating "states"
* States can override instance methods and create new ones
* States are inherited by subclasses
* States are stackable - the state on the top of the stack is the most prioritary
* There are callback functions invoked automatically when a state is entered, exited, pushed, popped ...

### Installation

First, make sure that you have downloaded and installed middleclass
Just copy the stateful.lua file wherever you want it (for example on a lib/ folder). Then write this in any Lua file where you want to use it:

```lua
  local class    = require 'middleclass'
  local stateful = require 'stateful'
```
