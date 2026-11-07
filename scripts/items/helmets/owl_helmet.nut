this.owl_helmet <- this.inherit("scripts/items/helmets/mail_coif", {
	m = {},
	function create()
	{
		this.mail_coif.create();
		this.m.ID = "armor.head.owl_helmet";
		this.m.Name = "Owl Helmet";
		this.m.Description = "A light cap crowned with dark owl feathers, with a strip of cloth to shade the eyes. It does not hinder sight at all, and whoever wears it sees through the night like a hunting owl.";
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Named;
		this.m.IsDroppedAsLoot = true;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -4;
		this.m.Vision = 0;
		this.m.Value = 1500;
		this.m.Variant = 51;
		this.updateVariant();
	}

	function updateVariant()
	{
		// vanilla named helmet look: light cap with a dark feathered crest and a cloth face wrap
		this.m.Sprite = "bust_helmet_51";
		this.m.SpriteDamaged = "bust_helmet_51_damaged";
		this.m.SpriteCorpse = "bust_helmet_51_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_helmet_51.png";
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

