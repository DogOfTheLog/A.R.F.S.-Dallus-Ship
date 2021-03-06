
var/global/list/snowTurfEdgeCache
#define NORTH_EDGING	"north"
#define SOUTH_EDGING	"south"
#define EAST_EDGING		"east"
#define WEST_EDGING		"west"

/turf/simulated/floor/plating/snow
	name = "snow"
	baseturf = /turf/simulated/floor/plating/snow
	icon = 'code/hybi/icons/snow.dmi'
	icon_state = "snow"
	icon_plating = "snow"

/turf/simulated/floor/plating/snow/airless
	oxygen = 0.01
	nitrogen = 0.01
	temperature = TCMB

/turf/simulated/floor/plating/snow/New()
	var/proper_name = name
	..()
	name = proper_name
	if(prob(20))
		icon_state = "snow[rand(0,12)]"
	if(!snowTurfEdgeCache || !snowTurfEdgeCache.len)
		snowTurfEdgeCache = list()
		snowTurfEdgeCache.len = 4
		snowTurfEdgeCache[NORTH_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_n", layer = 6)
		snowTurfEdgeCache[SOUTH_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_s")
		snowTurfEdgeCache[EAST_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_e", layer = 6)
		snowTurfEdgeCache[WEST_EDGING] = image('code/hybi/icons/snow.dmi', "snow_side_w", layer = 6)
	spawn(1)
		var/turf/T
		if((istype(get_step(src, NORTH), /turf/simulated/floor/plating/gravel))) //to do: replace space with path.
			T = get_step(src, NORTH)
			if (T)
				T.overlays += snowTurfEdgeCache[SOUTH_EDGING]
		if((istype(get_step(src, SOUTH), /turf/simulated/floor/plating/gravel)))
			T = get_step(src, SOUTH)
			if (T)
				T.overlays += snowTurfEdgeCache[NORTH_EDGING]
		if((istype(get_step(src, EAST), /turf/simulated/floor/plating/gravel)))
			T = get_step(src, EAST)
			if (T)
				T.overlays += snowTurfEdgeCache[WEST_EDGING]
		if((istype(get_step(src, WEST), /turf/simulated/floor/plating/gravel)))
			T = get_step(src, WEST)
			if (T)
				T.overlays += snowTurfEdgeCache[EAST_EDGING]


/turf/simulated/floor/plating/snow/burn_tile()
	return

/turf/simulated/floor/plating/snow/ex_act(severity, target)
	contents_explosion(severity, target)
	switch(severity)
		if(3)
			return
		if(2)
			if (prob(20))
				ChangeTurf(src,/turf/simulated/floor/plating/gravel/airless)
		if(1)
			ChangeTurf(src,/turf/simulated/floor/plating/gravel/airless)
	return

/turf/simulated/floor/plating/gravel
	name = "gravel"
	baseturf = /turf/simulated/floor/plating/gravel
	icon = 'code/hybi/icons/snow.dmi'
	icon_state = "gravsnow"
	icon_plating = "gravsnow"

/turf/simulated/floor/plating/gravel/airless
	oxygen = 0.01
	nitrogen = 0.01
	temperature = TCMB

/turf/simulated/floor/plating/gravel/burn_tile()
	return

/turf/simulated/floor/plating/gravel/snow/ex_act()
	return