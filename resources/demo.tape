Output demo.gif
Require tmux

Set Height 1000
Set Width 1600
Set FontSize 20
Set Theme 'Later This Evening'

Hide
  Type "tmux" Enter
  Ctrl+b
  Type "%"
  Sleep 300ms
  Ctrl+b
  Left
  Sleep 300ms
Show


Type "cat README.md"
Enter
Sleep 2s

Ctrl+b
Right
Sleep 1s

Type "rr 1 # run by index"
Sleep 300ms
Enter
Sleep 2s

Type "rr loop # run the block labeled 'loop'"
Sleep 300ms
Enter
Sleep 2s

Type "rr # list available tasks"
Sleep 300ms
Enter
Sleep 5s