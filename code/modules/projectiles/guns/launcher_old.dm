/obj/item/gun/launcher
	name = "launcher"
	desc = "A device that launches things."
	w_class = ITEMSIZE_HUGE
	flags =  CONDUCT
	slot_flags = SLOT_BACK

	var/release_force = 0
	var/throw_distance = 10
	muzzle_flash = 0
	fire_sound_text = "a launcher firing"

//Override this to avoid a runtime with suicide handling.
/obj/item/gun/launcher/handle_suicide(mob/living/user)
	user << "<font color='red'>Shooting yourself with \a [src] is pretty tricky. You can't seem to manage it.</font>"
	return

/obj/item/gun/launcher/proc/update_release_force(obj/item/projectile)
	return 0

/obj/item/gun/launcher/process_projectile(obj/item/projectile, mob/user, atom/target, var/target_zone, var/params=null, var/pointblank=0, var/reflex=0)
	update_release_force(projectile)
	projectile.loc = get_turf(user)
	projectile.throw_at(target, throw_distance, release_force, user)
	return 1