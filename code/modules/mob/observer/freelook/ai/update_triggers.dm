// CAMERA

// An addition to deactivate which removes/adds the camera from the chunk list based on if it works or not.

/obj/machinery/camera/deactivate(user as mob, var/choice = 1)
	..(user, choice)
	invalidateCameraCache()
	if(!can_use())
		kill_light()
	cameranet.update_visibility(src)

/obj/machinery/camera/New()
	..()
	cameranet.add_source(src)

/obj/machinery/camera/Destroy()
	cameranet.remove_source(src)
	. = ..()

/obj/machinery/camera/proc/update_coverage(var/network_change = 0)
	if(network_change)
		var/list/open_networks = difflist(network, restricted_camera_networks)
		// Add or remove camera from the camera net as necessary
		if(on_open_network && !open_networks.len)
			cameranet.remove_source(src)
		else if(!on_open_network && open_networks.len)
			on_open_network = 1
			cameranet.add_source(src)
	else
		cameranet.update_visibility(src)

	invalidateCameraCache()

// Mobs
/mob/living/silicon/ai/New()
	..()
	cameranet.add_source(src)

/mob/living/silicon/ai/Destroy()
	cameranet.remove_source(src)
	. = ..()

/mob/living/silicon/ai/rejuvenate()
	var/was_dead = stat == DEAD
	..()
	if(was_dead && stat != DEAD)
		// Arise!
		cameranet.update_visibility(src, FALSE)

/mob/living/silicon/ai/death(gibbed)
	. = ..()
	if(.)
		// If true, the mob went from living to dead (assuming everyone has been overriding as they should...)
		cameranet.update_visibility(src, FALSE)
