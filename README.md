# Simulty

Simulty is a very simple webapp-stress-tool written in ruby. It reads random urls from a file and executes multiple get-requests simultaneously to them.

## Usage

Create a file with one url per line and start the stresstest with:

```
./simulty.rb <urlfile> <number-of-threads>
```

Sample-Urlfile:
```
http://www.somefoobar.com/index.php?fun
https://www.somefoobar.com/user/login.php
http://www.somefoobar.com/whatever/somewhere/over/the/rainbow.php
```

## License
                                                               
Copyright (C) 2015 Wolfgang Hotwagner(code@feedyourhead.at)  
                                                               
