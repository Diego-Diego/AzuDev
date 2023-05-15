ConfigMarker = {}
ConfigMarker.D3Text = false
ConfigMarker.Marqueurs = {
    ['WL - Ambulance - Sonette Réception'] = {
		['Pos'] = {x = 489.39, y = -964.35, z = 27.29},
		['DistancePressed'] = 1.2,
		['DistanceView'] = 5.5,
        ['JobNeed'] = 'none',
		['Type'] = 'Normal',
		['Trigger'] = "esx_ambulancejob:receptionBell",
		['Message'] = "[~b~E~s~] Utiliser la sonnette",
		['Marker'] = 6,
	},
}

ConfigJobs = {
	tabac = {
		['WL - Tabarico - Vestiaire'] = {
			['Pos'] = {x = 2896.232, y = 4420.219, z = 50.359},
			['DistancePressed'] = 2.2,
			['DistanceView'] = 12.5,
			['JobNeed'] = 'tabac',
			['Marker'] = 6,
			['Type'] = 'Normal',
			['Trigger'] = "MyCity_Jobs:Vestiaire",
			['Message'] = "Appuyez sur [~b~E~s~] pour mettre votre tenue",
		    ['MinimumGrade'] = 0,
		},
	},
}