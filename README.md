# Arrows

[![Build Status](https://travis-ci.org/petertseng-dp/arrows.svg?branch=master)](https://travis-ci.org/petertseng-dp/arrows)

Find the longest cycle in a grid of arrows.

# Notes

No surprises in this implementation.
Use a set so that we visit each node at most once.
Check for a cycle when attempting to visit an already-visited node.

# Source

https://www.reddit.com/r/dailyprogrammer/comments/2m82yz
