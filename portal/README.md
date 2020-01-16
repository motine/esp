# MoHA

For now we want to try to avoid build tools such as webpacker.

```bash
ruby -rwebrick -e's=WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start'
```