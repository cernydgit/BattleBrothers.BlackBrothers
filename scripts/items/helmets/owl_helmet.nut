this.owl_helmet <- this.inherit("scripts/items/helmets/mail_coif", {
	m = {},
	function create()
	{
		this.mail_coif.create();
		this.m.ID = "armor.head.owl_helmet";
		this.m.Name = "Owl Helmet";
		this.m.Description = "A light, battered helm hammered into the shape of a grinning skull. Its wide eye holes do not hinder sight at all, and whoever wears it sees through the night like a hunting owl.";
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Named;
		this.m.IsDroppedAsLoot = true;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -4;
		this.m.Vision = 0;
		this.m.Value = 1500;
		this.m.Variant = 232;
		this.updateVariant();
	}

	function updateVariant()
	{
		// vanilla named helmet look: rusted skull-faced helm
		this.m.Sprite = "bust_helmet_232";
		this.m.SpriteDamaged = "bust_helmet_232_damaged";
		this.m.SpriteCorpse = "bust_helmet_232_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_helmet_232.png";
	}

	function getTooltip()
	{
		local result = this.mail_coif.getTooltip();
		result.push({
			id = 20,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Not affected by nighttime penalties"
		});
		return result;
	}

	function onEquip()
	{
		this.mail_coif.onEquip();
		this.addSkill(this.new("scripts/skills/effects/owl_helmet_effect"));
	}

});

