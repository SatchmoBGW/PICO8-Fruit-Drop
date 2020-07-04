pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
//inits

//variables
basket_sprite=1
player_sprite=2
player_x=64
player_y=100
fruits={}
fruit_start=3
fruit_count=6
fruit_interval=16
gravity=1
level=1
points=0

function _init()
	init_menu()
end

function init_menu()
	_update=update_menu
	_draw=draw_menu
end

function init_game()
	_update=update_game
	_draw=draw_game
	make_fruit()
end

function make_fruit()
	
	//create fruit
	for i=1, level do
		fruit={
			sprite=flr(rnd(fruit_count)+fruit_start),
			x=flr(rnd(120)+5),
			y=i*(-fruit_interval)
			}
		add(fruits,fruit)
	end
end
-->8
//updates

function update_menu()
	if btnp(❎) then
		init_game()
	end
end

function update_game()
	//player controls
	if btn(⬅️) then player_x-=2 end
	if btn(➡️) then player_x+=2 end
	if btnp(❎) then init_menu() end
	
	//player collision detection
	if player_x<=0 then player_x=0 end
	if player_x>=119 then player_x=119 end

	for fruit in all(fruits) do
		fruit.y+=gravity
		if fruit.y+4>=player_y-8
		and fruit.y+4<=player_y
		and fruit.x+4>=player_x
		and fruit.x+4<=player_x+8 then
			points+=1
			del(fruits,fruit)
		end
		if fruit.y>100 then
			del(fruits,fruit)
		end
	end
	if #fruits==0 then
		level +=1
		make_fruit()
	end
end
-->8
//draws

function draw_menu()
	cls()
	print("✽fruit drop✽ ver.1.1",20,20)
	print("press ❎ to start",30,60)
end

function draw_game()
	cls()
	rectfill(0,108,127,127,3)
	spr(player_sprite,player_x,player_y)
	spr(basket_sprite,player_x,player_y-8)
	
	for fruit in all(fruits) do
		spr(fruit.sprite,fruit.x,fruit.y)
	end
	
	print("score= "..points)
end
__gfx__
0000000006666660f044440f000043b00000090000b0b0b00000b300000000b00000000000000000000000000000000000000000000000000000000000000000
0000000070000006f0ffff0f000bb03b00000a40000bbb00000b3300000008730099b30000000000000000000000000000000000000000000000000000000000
0070070067777775f0ffff0f00b7bb0000000a4000f9a900088338800000807b099b388000000000000000000000000000000000000000000000000000000000
0007700066060605888ff88800b7bb000000a9400f9a9a40886888880008887b97a9998800000000000000000000000000000000000000000000000000000000
00077000606060d5008888000b7bbb30000a940009a9a490867688820080807b9a99998800000000000000000000000000000000000000000000000000000000
0070070066060d0500cccc000bbbbb300aa940000a9a494088688882088807b39999998800000000000000000000000000000000000000000000000000000000
0000000060d0d05500c00c0003bbbb300994000009a4949008888820b7777b300999988000000000000000000000000000000000000000000000000000000000
00000000055555500dd00dd00033330000000000004949000022220003bbb3000088880000000000000000000000000000000000000000000000000000000000
