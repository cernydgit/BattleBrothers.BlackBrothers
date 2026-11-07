// Added by the Owl Helmet while it is worn; removed automatically when the helmet is unequipped.
// Runs first (SkillOrder.First) so the vanilla night effect sees IsAffectedByNight = false.
this.owl_helmet_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.owl_helmet";
		this.m.Name = "Eyes of the Owl";
		this.m.Description = "The Owl Helmet lets its wearer see through the dark. Not affected by nighttime penalties.";
		this.m.Icon = "skills/status_effect_00.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.First;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByNight = false;
	}

});

