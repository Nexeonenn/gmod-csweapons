AddCSLuaFile()
DEFINE_BASECLASS( "weapon_csbasegun" )


--Jvs: I wish this weapon defining shit was this easy
CSParseWeaponInfo( SWEP , [[WeaponData
{
	"MaxPlayerSpeed"		"221"
	"WeaponType"			"Rifle"
	"FullAuto"				1
	"WeaponPrice"			"2500"
	"WeaponArmorRatio"		"1.55"
	"CrosshairMinDistance"		"4"
	"CrosshairDeltaDistance"	"4"
	"Team" 				"TERRORIST"
	"BuiltRightHanded" 		"0"
	"PlayerAnimationExtension" 	"ak"
	"MuzzleFlashScale"		"1.6"
	"MuzzleFlashStyle"		"CS_MUZZLEFLASH_X"
	"CanEquipWithShield"		"0"


	// Weapon characteristics:
	"Penetration"			"2"
	"Damage"			"36"
	"Range"				"8192"
	"RangeModifier"			"0.98"
	"Bullets"			"1"
	"CycleTime"			"0.1"
	"AccuracyDivisor"		"200"
	"AccuracyOffset"		"0.35"
	"MaxInaccuracy"			"1.25"
	"TimeToIdle"			"1.9"
	"IdleInterval"			"20"

	// New accuracy model parameters
	"Spread"					0.00060
	"InaccuracyCrouch"			0.00687
	"InaccuracyStand"			0.00916
	"InaccuracyJump"			0.43044
	"InaccuracyLand"			0.08609
	"InaccuracyLadder"			0.10761
	"InaccuracyFire"			0.01158
	"InaccuracyMove"			0.09222

	"RecoveryTimeCrouch"		0.34868
	"RecoveryTimeStand"			0.48815

	// Weapon data is loaded by both the Game and Client DLLs.
	"printname"			"#Cstrike_WPNHUD_AK47"
	"viewmodel"			"models/weapons/v_rif_ak47.mdl"
	"playermodel"			"models/weapons/w_rif_ak47.mdl"

	"anim_prefix"			"anim"
	"bucket"			"0"
	"bucket_position"		"0"

	"clip_size"			"30"

	"primary_ammo"			"BULLET_PLAYER_762MM"
	"secondary_ammo"		"None"

	"weight"			"25"
	"item_flags"			"0"

	// Sounds for the weapon. There is a max of 16 sounds per category (i.e. max 16 "single_shot" sounds)
	SoundData
	{
		"single_shot"		"Weapon_AK47.Single"
	}

	// Weapon Sprite data is loaded by the Client DLL.
	TextureData
	{
		//Weapon Select Images
		"weapon"
		{
				"font"		"CSweaponsSmall"
				"character"	"B"
		}
		"weapon_s"
		{
				"font"		"CSweapons"
				"character"	"B"
		}
		"ammo"
		{
				"font"		"CSTypeDeath"
				"character"		"V"
		}
		"crosshair"
		{
				"file"		"sprites/crosshairs"
				"x"			"0"
				"y"			"48"
				"width"		"24"
				"height"	"24"
		}
		"autoaim"
		{
				"file"		"sprites/crosshairs"
				"x"			"0"
				"y"			"48"
				"width"		"24"
				"height"	"24"
		}
	}
	ModelBounds
	{
		Viewmodel
		{
			Mins	"-9 -3 -13"
			Maxs	"30 11 0"
		}
		World
		{
			Mins	"-9 -9 -9"
			Maxs	"30 9 7"
		}
	}
}]] )

SWEP.Spawnable = true
SWEP.Slot = 0

function SWEP:Initialize()
	BaseClass.Initialize( self )
	self:SetHoldType( "ar2" )
	self:SetWeaponID( CS_WEAPON_AK47 )
end

function SWEP:PrimaryAttack()
	if self:GetNextPrimaryAttack() > CurTime() then return end

	self:GunFire( self:BuildSpread() )
end

function SWEP:GunFire( spread )

	if not self:BaseGunFire( spread, self:GetWeaponInfo().CycleTime, true ) then
		return
	end

	--Jvs: this is so goddamn lame

	if self:GetOwner():GetAbsVelocity():Length2D() > 5 then
		self:KickBack( 1.5, 0.45, 0.225, 0.05, 6.5, 2.5, 7 )
	elseif not self:GetOwner():OnGround() then
		self:KickBack( 2, 1.0, 0.5, 0.35, 9, 6, 5 )
	elseif self:GetOwner():Crouching() then
		self:KickBack( 0.9, 0.35, 0.15, 0.025, 5.5, 1.5, 9 )
	else
		self:KickBack( 1, 0.375, 0.175, 0.0375, 5.75, 1.75, 8 )
	end
end
