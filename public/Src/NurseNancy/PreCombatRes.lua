NurseNancy.NurseNancy = NurseNancy.NurseNancy or {}

-- Lines for "combat" ress spells that are cast before the pull (out of combat).
-- For now this only covers the Warlock's Soulstone; see NurseNancy.SpellIds.isPreCombatRess.
function NurseNancy.NurseNancy.speakPreCombatRess(targetGUID, spellId)
  local pickedLine
  local prefix = NurseNancyVars.usePrefix == true and "[Soulstone on ${targetName}]: " or ""
  local Class = NurseNancy.Constants.Class
  local Race = NurseNancy.Constants.Race

  -- dateFormat
  local rawTime = date("*t")
  local d = {
    day = rawTime.day,
    month = rawTime.month,
    year = rawTime.year,
  }

  local playerName, playerGender, playerClass, playerRace, playerLevel =
    NurseNancy.Helpers.GetPlayerInformation()
  local targetName, targetGender, targetClass, targetRace =
    NurseNancy.Helpers.GetTargetInformationByUID(targetGUID)

  local playerGuyGirl = NurseNancy.Helpers.GetGuyGirl(playerGender)
  local playerManWoman = NurseNancy.Helpers.GetManWoman(playerGender)

  local targetHimHer = NurseNancy.Helpers.GetHimHer(targetGender)
  local targetHeShe = NurseNancy.Helpers.GetHeShe(targetGender)

  local zoneName = GetRealZoneText()

  local oppositeSex = "guys"

  if (playerGender == "male") then
    oppositeSex = "girls"
  end

  local preCombatRessLines = {
    "Do not worry, ${targetName}, this soulstone - shouldn't - hurt a bit...",
    "According to my Failometer, ${targetName} has a high chance of dying in the next fifteen minutes.",
    "I'm just gonna borrow your soul for a bit, ${targetName}, I promise I'll give it back... when you're dead.",
    "One spare soul coming straight up for you, ${targetName}.",
    "Soulstone on ${targetName}. It's not that I think you're going to die, honestly ${targetName}.",
    "Soulstoning is a routine procedure. I totally don't think ${targetName} will die in the next 15 minutes.",
    "${targetName}, this soulstone is just my way of saying `I don't trust you.`",
    "Soulstoning ${targetName}. I promise to not devour your soul in the next 15 minutes, if you are a tank, a healer or a fellow Warlock. Maybe.",
    "${targetName}, I heard you love to get stoned, so I will stone you, so you will be stoned, while you are stoned. Or something.",
    "Stoning ${targetName}. Suicide is no longer an option for you.",
    "Stoning ${targetName}. If you hate my rock, feel free to go to your nearest Death Knight.",
    "Soulstoning ${targetName}. ARCHSURGEON'S WARNING: Soulstones contain puppy hearts, and are linked to ghoul fever in laboratory tests.",
    "Package for you, ${targetName}. Contents: One(1) soul.",
    "FYI, ${targetName}, using a soulstone removes any chance of getting into heaven.",
  }

  if (targetClass == "Paladin") then
    table.insert(preCombatRessLines, "I too, can be a paladin: My judgement for ${targetName} is ${targetHeShe} is going to die soon.")
  end

  -- eastern
  if (d.month == 4 and d.day == 4) then
    table.insert(preCombatRessLines, "Here's some cool 'chocolate egg', ${targetName}.")
  end

  pickedLine = preCombatRessLines[fastrandom(1, #preCombatRessLines)]

  return NurseNancy.Helpers.parseText(prefix .. pickedLine, {
    playerName = playerName,
    playerGender = playerGender,
    playerClass = playerClass,
    playerRace = playerRace,
    playerLevel = playerLevel,
    playerManWoman = playerManWoman,
    playerGuyGirl = playerGuyGirl,
    targetName = targetName,
    targetGender = targetGender,
    targetClass = targetClass,
    targetRace = targetRace,
    targetHimHer = targetHimHer,
    oppositeSex = oppositeSex,
    targetHeShe = targetHeShe,
    zoneName = zoneName,
  })
end
