/datum/round_event_control/spooky
	name = "2 SPOOKY! (Halloween)"
	holidayID = HALLOWEEN
	typepath = /datum/round_event/spooky
	weight = -1							//forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 0

/datum/round_event/spooky/start()
	..()
	for(var/mob/living/carbon/human/H in mob_list)
		var/obj/item/weapon/storage/backpack/b = locate() in H.contents
		new /obj/item/weapon/storage/spooky(b)
		if(ishuman(H) || islizard(H))
			if(prob(50))
				H.set_species(/datum/species/skeleton)
			else
				H.set_species(/datum/species/zombie)

	for(var/mob/living/simple_animal/pet/dog/corgi/Ian/Ian in mob_list)
		Ian.place_on_head(new /obj/item/weapon/bedsheet(Ian))
	for(var/mob/living/simple_animal/parrot/Poly/Poly in mob_list)
		new /mob/living/simple_animal/parrot/Poly/ghost(Poly.loc)
		qdel(Poly)

/datum/round_event/spooky/announce()
	priority_announce(pick("RATTLE ME BONES!","THE RIDE NEVER ENDS!", "A SKELETON POPS OUT!", "SPOOKY SCARY SKELETONS!", "CREWMEMBERS BEWARE, YOU'RE IN FOR A SCARE!") , "THE CALL IS COMING FROM INSIDE THE HOUSE")

//Eyeball migration
/datum/round_event_control/carp_migration/eyeballs
	name = "Eyeball Migration"
	typepath = /datum/round_event/carp_migration/eyeballs
	holidayID = HALLOWEEN
	weight = 25
	earliest_start = 0

/datum/round_event/carp_migration/eyeballs/start()
	for(var/obj/effect/landmark/C in landmarks_list)
		if(C.name == "carpspawn")
			new /mob/living/simple_animal/hostile/carp/eyeball(C.loc)

//Pumpking meteors waves
/datum/round_event_control/meteor_wave/spooky
	name = "Pumpkin Wave"
	typepath = /datum/round_event/meteor_wave/spooky
	holidayID = HALLOWEEN
	weight = 20
	max_occurrences = 2

/datum/round_event/meteor_wave/spooky
	endWhen	= 40

/datum/round_event/meteor_wave/spooky/tick()
	if(IsMultiple(activeFor, 4))
		spawn_meteors(3, meteorsSPOOKY) //meteor list types defined in gamemode/meteor/meteors.dm

//Creepy clown invasion
/datum/round_event_control/creepy_clowns
	name = "Clowns"
	typepath = /datum/round_event/creepy_clowns
	holidayID = HALLOWEEN
	weight = 20
	earliest_start = 0

/datum/round_event/creepy_clowns
	endWhen = 40

/datum/round_event/creepy_clowns/start()
	for(var/mob/living/carbon/human/H in living_mob_list)
		if(!H.client || !istype(H))
			return
		to_chat(H, "<span class='danger'>Mysterious stranger in danger!</span>")
		to_chat(H, 'sound/f13music/mysterious_stranger.ogg')
		var/turf/T = get_turf(H)
		if(T)
			new /obj/effect/hallucination/simple/clown(T, H, 50)

/datum/round_event/creepy_clowns/tick()
	if(IsMultiple(activeFor, 4))
		for(var/mob/living/carbon/human/H in living_mob_list)
			if (prob(66))
				playsound(H.loc, pick('sound/harmonica/fharp1.ogg','sound/harmonica/fharp2.ogg','sound/harmonica/fharp3.ogg','sound/harmonica/fharp4.ogg','sound/harmonica/fharp5.ogg','sound/harmonica/fharp6.ogg','sound/harmonica/fharp7.ogg','sound/harmonica/fharp8.ogg'), 100, 1)
			if (prob(33))
				var/turf/T = get_turf(H)
				if(T)
					new /obj/effect/hallucination/simple/clown(T, H, 25)
			else if (prob(25))
				var/turf/T = get_turf(H)
				if(T)
					new /obj/effect/hallucination/simple/clown/scary(T, H, 25)
			else if (prob(5))
				var/turf/T = get_turf(H)
				if(T)
					spawn_atom_to_turf(/obj/effect/mob_spawn/human/clown/corpse, H, 1)
			else if (prob(1))
				spawn_atom_to_turf(/mob/living/simple_animal/hostile/retaliate/clown, H, 1)

/datum/round_event/creepy_clowns/announce()
	priority_announce("Mayday, mayday! Main system has failed! We are losing altitude! Where the hell is Chief Engineer?! Critical failure of all systems! It's too late, brace for...", "Unknown Battlecruiser", 'sound/f13machines/vertibird_crash.ogg')

//spooky foods (you can't actually make these when it's not halloween)
/obj/item/weapon/reagent_containers/food/snacks/sugarcookie/spookyskull
	name = "skull cookie"
	desc = "Spooky! It's got delicious calcium flavouring!"
	icon = 'icons/obj/halloween_items.dmi'
	icon_state = "skeletoncookie"

/obj/item/weapon/reagent_containers/food/snacks/sugarcookie/spookycoffin
	name = "coffin cookie"
	desc = "Spooky! It's got delicious coffee flavouring!"
	icon = 'icons/obj/halloween_items.dmi'
	icon_state = "coffincookie"


//spooky items

/obj/item/weapon/storage/spooky
	name = "trick-o-treat bag"
	desc = "A pumpkin-shaped bag that holds all sorts of goodies!"
	icon = 'icons/obj/halloween_items.dmi'
	icon_state = "treatbag"

/obj/item/weapon/storage/spooky/New()
	..()
	for(var/distrobuteinbag=0 to 5)
		var/type = pick(/obj/item/weapon/reagent_containers/food/snacks/sugarcookie/spookyskull,
		/obj/item/weapon/reagent_containers/food/snacks/sugarcookie/spookycoffin,
		/obj/item/weapon/reagent_containers/food/snacks/candy_corn,
		/obj/item/weapon/reagent_containers/food/snacks/candy,
		/obj/item/weapon/reagent_containers/food/snacks/candiedapple,
		/obj/item/weapon/reagent_containers/food/snacks/chocolatebar,
		/obj/item/organ/brain ) // OH GOD THIS ISN'T CANDY!
		new type(src)

/obj/item/weapon/card/emag/halloween
	name = "hack-o'-lantern"
	desc = "It's a pumpkin with a cryptographic sequencer sticking out."
	icon_state = "hack_o_lantern"
