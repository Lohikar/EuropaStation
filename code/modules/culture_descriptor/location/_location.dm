/decl/cultural_info/location
	desc_type = "Home System"
	secondary_langs = list(
		LANGUAGE_SIGN
	)
	category = TAG_HOMEWORLD
	var/distance = 0
	var/ruling_body = FACTION_OTHER
	var/capital

/decl/cultural_info/location/get_text_details()
	. = list()
	if(!isnull(capital))
		. += "<b>Capital:</b> [capital]."
	if(!isnull(ruling_body))
		. += "<b>Territory:</b> [ruling_body]."
	if(!isnull(distance))
		. += "<b>Distance from Sol:</b> [distance]."
	. += ..()

/decl/cultural_info/location/other
	name = HOME_SYSTEM_OTHER
	description = "You are not from any known system."
