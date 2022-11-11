

function GetDataDamage(data)
    local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
    return victim, attacker, victimDied, weapon
end