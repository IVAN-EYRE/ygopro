--ファントム·オブ·カオス
function c30312361.initial_effect(c)
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30312361,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c30312361.target)
	e1:SetOperation(c30312361.operation)
	c:RegisterEffect(e1)
	--no battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	c:RegisterEffect(e2)
end
function c30312361.filter(c)
	return c:IsType(TYPE_EFFECT) and not c:IsHasEffect(EFFECT_FORBIDDEN) and c:IsAbleToRemove()
end
function c30312361.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c30312361.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c30312361.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c30312361.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c30312361.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=1 then	return end
		local code=tc:GetOriginalCode()
		local ba=tc:GetBaseAttack()
		local bd=tc:GetBaseDefence()
		local reset_flag=RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END
		c:CopyEffect(code, reset_flag, 1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(reset_flag)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(reset_flag)
		e2:SetCode(EFFECT_SET_BASE_ATTACK)
		e2:SetValue(ba)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetReset(reset_flag)
		e3:SetCode(EFFECT_SET_BASE_DEFENCE)
		e3:SetValue(bd)
		c:RegisterEffect(e3)
	end
end
