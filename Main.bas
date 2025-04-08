!- **Explanation variabls**
!- sc = score; lv = level; hp = health points
!- dim x(),y(),a() - array for enemies: x,y = position a=alive
!- ac - alive counter; how many enemies are alive
!- di - direction in which aliens move
!- ti$ - internal timer variable which is initialized with 000000/00h 00min 00sec
!- lt = last time. Last time the movement was triggered
!- sx - position on the x axis of the player
!- sy - position on the y axis of the player
!- mx,my - Position in x and y axis for the shot
!- mf - 0 shot not fired, 1 shot is fired
!- k$ - which key on the keyboard was pressed
!- f - number to determan which enemy will shot
!- ax, ay, af - x,y Position of enemy shot and af=1 if enemy shot is active
!- data in line 15 sprite for rocket
!- data in line 17 sprite for enemy
!- data in line 19 sprite for shot

!- **Functions**
!- line 1000 - 1130 start menu
!- line 2000 - 2129 game initialisation
!- line 3000 - 3040 draw board
!- line 4000 - 4070 game logic
!- line 5000 - 5020 move player right
!- line 5030 - 5050 move player left
!- line 5200 - 5240 shoot shot
!- line 5400 - 5460 refresh score/enemy hit
!- line 5600 - 5640 reset timer for movement
!- line 6000 - 6040 move enemy
!- line 6100 - 6130 move enemy on y axis
!- line 6200 - 6240 enemies shot movement
!- line 6300 - 6340 collision handeling between enemy shot and player ship
!- line 7000 - 7070 winning screen
!- line 7500 - 7570 loosing screen

10 poke 36879,8
11 poke 52,28:poke 56,28: clr
12 for i=7168to7831:poke i, peek(i+25600):next
13 poke 36869,255
14 for c=7168to7175:read a:poke c,a :next
15 data 24,60,60,126,60,60,90,90
16 for c=7664to7671:read a:poke c,a:next
17 data 36,24,60,90,255,189,165,24
18 for c=7392to7399:read a:poke c,a:next
19 data 60,126,126,126,60,24,24,24
20 print chr$(147)
30 sc=0:lv=0:hp=3
40 gosub 1000
50 gosub 2000
60 gosub 4000
100 end

1000 print chr$(147)
1005 print "{white}":print "space invaders":print "by arnold streck"
1030 print "-----------------"
1040 print
1050 print "a - move left":print "d - move right":print "space - fire"
1080 print
1090 print "destroy all aliens":print "before they reach the bottom"
1105 print
1110 print "press any key to start"
1120 poke 198,0:wait198,1
1125 ti$ = "000001"
1128 lt = val(ti$)
1130 return

2000 print chr$(147)
2010 poke 36878,15
2030 DIM x(10),y(10),a(10)
2040 sx=11:sy=22
2050 mx=0:my=0:mf=0
2055 ax=0:ay=0:af=0
2060 ac=10:f=1:di=1
2080 print "score:"+mid$(str$(sc),2)+" level: 1"+" hp:"+mid$(str$(hp),2)
2085 for i=1to10
2088 a(i)=1
2089 x(i)=((i-1)-int((i-1)/5)*5)*4+3
2099 y(i)=int((i-1)/5)*2+3
2109 next
2119 gosub 3000
2129 return

3000 poke 7680+sy*22+sx,0
3010 for i=1to10:if a(i)=1 then poke 7680+y(i)*22+x(i),62:next
3040 return

4000 get k$
4010 if k$="a" and sx>1 then sx=sx-1:gosub 5030
4020 if k$="d" and sx<21 then sx=sx+1:gosub 5000
4030 if k$=" " and mf=0 then mf=1:mx=sx:my=sy-1:poke 36876,220:for t=1to30:next:poke 36876,0
4040 if mf=1 then gosub 5200
4041 if val(ti$) - lt > 5 then gosub 5600
4051 if ac=0 then goto 7000
4058 if val(ti$) - lt > 3 and af=0 and a(f)=1 then af=1:ax=x(f):ay=y(f)+1
4060 if f=10 then f=1
4061 if f<10 then f=f+1
4062 if af=1 then gosub 6200:poke 7680+sy*22+sx,0
4065 goto 4000
4070 return

5000 poke 7680+sy*22+(sx-1),32:poke 7680+sy*22+sx,0
5020 return

5030 poke 7680+sy*22+(sx+1),32:poke 7680+sy*22+sx,0
5050 return

5200 poke 7680+my*22+mx,32
5210 my=my-1
5220 if my<2 then mf=0:return
5230 poke 7680+my*22+mx,28
5235 for i=1to10
5238 if a(i)=1 and x(i)=mx and y(i)=my then gosub 5400:goto 5240
5239 next
5240 return

5400 poke 7680+y(i)*22+x(i),32
5410 poke 7680+my*22+mx,32
5420 a(i)=0:ac=ac-1:mf=0
5430 sc=sc+1
5444 print "{home}":print "score:"+mid$(str$(sc),2)+" level: 1"+" hp:"+mid$(str$(hp),2)
5450 poke 36877,220:for t=1to100:next:poke 36877,0
5460 return

5600 for i=1to10
5610 if a(i) =1 then gosub 6000
5620 next
5630 lt = val(ti$)
5640 return

6000 poke 7680+y(i)*22+x(i),32
6010 x(i)=x(i)+di
6020 if (x(i)>20 or x(i)<2) and a(i)=1 then di=-di:gosub 6100
6030 poke 7680+y(i)*22+x(i),62
6040 return

6100 for j=1to10
6105 if y(j)>19 then goto 7500
6110 if a(j)=1 then poke 7680+y(j)*22+x(j),32:y(j)=y(j)+1:poke 7680+y(j)*22+x(j),62
6120 next
6130 return

6200 poke 7680+ay*22+ax,32
6205 for i=1to10:if a(i)=1 and x(i)=ax and y(i)=ay then poke 7680+y(i)*22+x(i),62:next
6210 ay=ay+1
6220 if ay > 22 then af=0:return
6230 poke 7680+ay*22+ax,33
6235 if ax=sx and ay=sy then gosub 6300
6240 return

6300 hp = hp-1
6305 if hp=0 then goto 7500
6320 print "{home}":print "score:"+mid$(str$(sc),2)+" level: 1"+" hp:"+mid$(str$(hp),2)
6340 return

7000 print chr$(147)
7001 print "congratulations!!!":print "you won the game!":print
7002 print "your score: "+mid$(str$(sc),2)
7003 print
7004 poke 36878,15
7005 for s=1to3
7006 poke 36876,220:for d=1to100:next
7007 poke 36876,200:ford=1to100:next
7008 poke 36876,230:for d=1to150:next
7009 next s
7010 poke 36876,0
7022 print "press r to restart":print "press e to end game"
7030 get k$:if k$="" goto 7030
7040 if k$="r" then goto 10
7050 if k$="e" then goto 7070
7070 end

7500 print chr$(147):print "you lost":print "better luck next time!"
7540 print
7550 print "your score: " + mid$(str$(sc),2)
7560 print
7570 goto 7022