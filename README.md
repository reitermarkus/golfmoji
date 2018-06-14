# ⛳️ golfmoji [![Build Status](https://travis-ci.org/reitermarkus/golfmoji.svg?branch=master)](https://travis-ci.org/reitermarkus/golfmoji)

golfmoji is a new stack-based esoteric golfing language, which is currently heavily under development. 

golfmoji code consists only of emojis. Each emoji calls a specific function which operates on top of a stack. If all emojis are executed, the golfmoji interpreter will print the head of the stack.

## Getting started

**Execute emoji code:**
1. Create a file. (like `example.⛳`)
2. Fill that file with valid emojis.
3. Run `bin/golfmoji -f example.⛳ [arg1, arg2, ...]` to execute it. Those optional arguments will initialize the stack values. So if we call `-f example.⛳ abc def`, all code from `example.⛳` will be executed. The initial stack would be `["abc", "def"]`.

**Use the em😲lator:**
1. Run `bin/emolator [arg1, arg2, ...]`. Those optional arguments would initialize the stack like in the previous example.
2. Type `help` and hit `return` to get more information about how it works.

## Why emojis?!

We want to push golfing languages to the next level by creating a new beautiful, short and (maybe) funny golfing language for everyone!

## What do we have so far?

Theres still a lot to do. Some basic actions are implemented, like executing golfmoji code on top of a stack.

In addition there is also a basic em😲lator ("emolator") which can be used to interactively program code by using human readable instructions which will then translate that code to golfmoji code.

### Important missing features

- We still have to figure out which commands are the most useful ones because we are limited to 256 emojis.
- There is no string mechanic implemented! Currently strings can only be used if they were passed as arguments.

**At the current state of development, we _don't_ recommend to use golfmoji for any serious usecases.**

## Commit-Conventions

Each commit-message *should* contain at least one emoji.

Here are the most important guidelines, which emoji you may use for each commit-type:

| emoji | commit-type |
|-------|-------------|
| ✨ | feature  |
| 🐛 | bugfix    |
| 🔨 | refactoring |
