!- **Explanation variabls**
!- sc = score; lv = level; hp = health points
!- dim x(),y(),a() - array for enemies: x,y = position a=alive
!- ac - alive counter; how many enemies are alive
!- cs$ = current status - displays sc,lv,hp

!- **Functions**
!- line 1000 - 1130 start menu
!- line 2000 - 2129 game initialisation

10 poke 36879,8
20 print chr$(147)
30 sc=0:lv=0:hp=3
40 gosub 1000
50 gosub 2000
60 rem gosub 3000
70 rem goto 50
100 end

1000 print chr$(147)
1005 print "{white}"
1010 print "space invaders"
1020 print "by arnold streck"
1030 print "-----------------"
1040 print
1050 print "a - move left"
1060 print "d - move right"
1070 print "space - fire"
1080 print
1090 print "destroy all aliens"
1100 print "before they reach the bottom"
1105 print
1110 print "press any key to start"
1120 poke 198,0:wait198,1
1130 return

2000 print chr$(147)
2010 poke 36878,15
2020 lv=lv+1
2030 DIM x(10),y(10),a(10)
2040 sx=11:sy=22
2050 mx=0:my=0:mf=0
2060 ac=10
2070 cs$="score:"+mid$(str$(sc),2)+" lives:"+mid$(str$(ls),2)+" hp:"+mid$(str$(hp),2)
2080 print cs$
2085 for i=1to10
2088 a(i)=1
2089 x(i)=((i-1)-int((i-1)/5)*5)*4+3
2099 y(i)=int((i-1)/5)*2+3
2109 next
2119 gosub 3000
2129 return

3000 poke 7680+sy*22+sx,81
3010 for i=1to10
3020 if a(i)=1 then poke 7680+y(i)*22+x(i),90
3030 next
3035 poke 198,0:wait198,1
3040 return