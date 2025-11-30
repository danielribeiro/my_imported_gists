# Rakefile

### Description
A Rakefile that standardises program env installation and guides the user, as opposed to crashing with Ruby exceptions such as `LoadError`. The only case where this will *never* work reliably is if you use the `rubygems-bundler` (NOEXEC) plugin, which introduces chicken-and-egg problems.

### Extra
Forked from: https://gist.github.com/alloy/f0292ff380647028e9b1
