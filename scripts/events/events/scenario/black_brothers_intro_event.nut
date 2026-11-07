this.black_brothers_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.black_brothers_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_17.png[/img]{The captain who led you is dead, the company scattered, its banner burned. Only three of you walked away from that field: the Blade, the Wall and the Owl.\n\nYou dyed a strip of cloth black, tied it to a spear and swore to each other that no one would ever again sell your lives cheaply. From now on you fight for coin, for each other - and under your own black banner.\n\nThe Owl hands you an old helmet with a pair of round eyes hammered into its brow. %SPEECH_ON%Found it on a dead night-watchman. Whoever wears it sees in the dark like I do.%SPEECH_OFF%}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Brothers in black, brothers to the end.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The Black Brothers";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

