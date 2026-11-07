this.black_brothers_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.black_brothers";
		this.m.Name = "Black Brothers";
		this.m.Description = "[p=c][img]gfx/ui/events/event_133.png[/img][/p][p]Three men who have bled together for years: a blade, a wall and an owl in the dark. Now they fight under their own black banner.\n\n[color=#bcad8c]Black Brothers:[/color] Start with three seasoned men of level 2 - a swordsman, a shield-bearing tank and a night archer.\n[color=#bcad8c]Owl Helmet:[/color] Start with a unique helmet that removes all nighttime penalties from its wearer.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 15;
	}

	function isValid()
	{
		return true;
	}

	function setupBro( _bro, _background, _title, _formation, _traits, _talents, _description )
	{
		_bro.setStartValuesEx([
			_background
		]);
		_bro.getBackground().m.RawDescription = _description;
		_bro.getBackground().buildDescription(true);
		_bro.setTitle(_title);
		_bro.setPlaceInFormation(_formation);
		_bro.m.HireTime = this.Time.getVirtualTimeF();

		// replace the random traits with hand-picked ones
		// (the background is also of type Trait, so it must be kept)
		foreach( s in _bro.getSkills().getAllSkillsOfType(this.Const.SkillType.Trait) )
		{
			if (!s.isType(this.Const.SkillType.Background))
			{
				_bro.getSkills().remove(s);
			}
		}

		foreach( t in _traits )
		{
			_bro.getSkills().add(this.new("scripts/skills/traits/" + t));
		}

		// level 2 with one unspent perk point and one pending level-up
		_bro.m.Level = 2;
		_bro.m.LevelUps = 1;
		_bro.m.PerkPoints = 1;
		_bro.m.XP = this.Const.LevelXP[_bro.m.Level - 1];

		// talents (stars) and re-rolled level-up values that follow them
		_bro.m.Talents = [];
		local talents = _bro.getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);

		foreach( attribute, stars in _talents )
		{
			talents[attribute] = stars;
		}

		_bro.m.Attributes = [];
		_bro.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);

		local items = _bro.getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		return items;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = ++i )
		{
			local bro = roster.create("scripts/entity/tactical/player");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		local a = this.Const.Attributes;
		local items;

		// 1) The Blade - swordsman: attack and speed
		local bladeTalents = {};
		bladeTalents[a.MeleeSkill] <- 3;
		bladeTalents[a.Initiative] <- 3;
		bladeTalents[a.MeleeDefense] <- 2;
		items = this.setupBro(bros[0], "sellsword_background", "the Blade", 4, [
			"dexterous_trait",
			"quick_trait",
			"brave_trait"
		], bladeTalents, "%name% learned the sword in the fighting pits and the free companies of the south. Quick on his feet and quicker with his blade, he swore himself to the Black Brothers after they pulled him half-dead out of a lost battle.");
		items.equip(this.new("scripts/items/weapons/shortsword"));
		items.equip(this.new("scripts/items/armor/gambeson"));
		items.equip(this.new("scripts/items/helmets/owl_helmet"));

		// 2) The Wall - tank: defense, fatigue and hitpoints
		local wallTalents = {};
		wallTalents[a.MeleeDefense] <- 3;
		wallTalents[a.Fatigue] <- 3;
		wallTalents[a.Hitpoints] <- 3;
		items = this.setupBro(bros[1], "hedge_knight_background", "the Wall", 3, [
			"tough_trait",
			"iron_lungs_trait",
			"sure_footing_trait"
		], wallTalents, "A landless knight of broad shoulders and few words, %name% has held more shield walls than he can count. Where he plants his feet, the line holds - and the Black Brothers have never been broken while he stood among them.");
		items.equip(this.new("scripts/items/weapons/bludgeon"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		items.equip(this.new("scripts/items/helmets/nasal_helmet"));

		// 3) The Owl - archer: night owl, speed and ranged combat
		local owlTalents = {};
		owlTalents[a.RangedSkill] <- 3;
		owlTalents[a.Initiative] <- 3;
		owlTalents[a.RangedDefense] <- 2;
		items = this.setupBro(bros[2], "hunter_background", "the Owl", 13, [
			"night_owl_trait",
			"quick_trait",
			"eagle_eyes_trait"
		], owlTalents, "%name% hunted deer by moonlight long before he ever hunted men. The others call him the Owl, for he sees in the dark what other men only hear - and by then his arrow has already flown.");
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.equip(this.new("scripts/items/armor/leather_tunic"));
		items.equip(this.new("scripts/items/helmets/hunters_hat"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 2 && !randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			local tile = this.World.getTileSquare(x, y);

			if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
			{
				continue;
			}

			if (tile.getDistanceTo(randomVillageTile) <= 1)
			{
				continue;
			}

			local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

			if (!path.isEmpty())
			{
				randomVillageTile = tile;
				break;
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.black_brothers_scenario_intro");
		}, null);
	}

});

