this.owl_helmet <- this.inherit("scripts/items/helmets/kettle_hat", {
	m = {},
	function create()
	{
		this.kettle_hat.create();
		this.m.ID = "armor.head.owl_helmet";
		this.m.Name = "Owl Helmet";
		this.m.Description = "A blackened kettle helmet with a pair of round owl eyes hammered into its brow. Its wide, open visor does not hinder sight at all, and whoever wears it sees through the night like a hunting owl.";
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Named;
		this.m.IsDroppedAsLoot = true;
		this.m.Condition = 140;
		this.m.ConditionMax = 140;
		this.m.StaminaModifier = -6;
		this.m.Vision = 0;
		this.m.Value = 2500;
	}

	function getTooltip()
	{
		local result = this.kettle_hat.getTooltip();
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
		this.kettle_hat.onEquip();
		this.addSkill(this.new("scripts/skills/effects/owl_helmet_effect"));
	}

});

