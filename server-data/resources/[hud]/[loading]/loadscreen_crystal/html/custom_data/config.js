var Config = {
	
	server_name: 'Diego - RP',
	pause_after_intro: 3000,
	bg_video: 'Wqsg2vWHZBM', // https://www.youtube.com/watch?v=Wqsg2vWHZBM

	radio_volume: 0.025,
	radio_playlist: [
        {name: 'Lil jon - Alive', link:'custom_data/lil_jon_alive.mp3' }, // patch
		// {name:'Hardstyle', link:'http://server-23.stream-server.nl:8326/stream?type=http&nocache=63527'} // STREAM
    ],
	
	main_menu: [
		{caption: 'ACCUEIL', onclick: LS.home.show},
		{caption: 'ANNONCES', onclick: LS.news.show},
		{caption: 'REGLES', onclick: LS.rules.show},
		{caption: 'CONTACTS', onclick: LS.contacts.show},
	],
	
	assets :
	{
		bad_tv: './assets/bad_tv.mp4',
	},
};