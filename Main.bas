!- **Explanation variabls**
!- sc = score; lv = level; hp = health points

!- **Functions**
!- line 1000 - 1130 start menu

10 poke 36879,8
15 print chr$(29)
20 print chr$(147)
30 sc=0:lv=0:hp=3
40 gosub 1000
50 rem gosub 2000
60 rem gosub 3000
70 rem goto 50
100 end

1000 print chr$(147)
1010 print "space invaders"
1020 print "by arnold streck"
1030 print "-----------------"
1040 print
1050 print "a - move left"
1060 print "d - move right"
1070 print "space - fire"
1080 print
1090 print "destroy all aliens before they reach the bottom"
1100 print
1110 print "press any key to start"
1120 poke 198,0:wait198,1
1130 return