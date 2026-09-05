local a=game:GetService('Players')local b=game:GetService('ReplicatedStorage')
local c=game:GetService('Workspace')local d=game:GetService('CollectionService')
local e=game:GetService('StarterGui')local f=game:GetService('RunService')local
g=a.LocalPlayer local h=b:WaitForChild('Util'):WaitForChild('Net')local i=
getgenv and getgenv().AnimalHospitalAutomation local j=i and i.Config if i and i
.Unload then pcall(i.Unload)end local k={ScriptBuild='patch-hub-ui-1.1',
Connections={},TreatedPatients={},PromptCooldown={},StepCooldown={},
ItemPickupCooldown={},PendingItemPickup={},TreatmentAppliedItems={},
TreatmentApplyCooldown={},ActiveTreatmentSession={},SurgeryLastApplied={},
XRaySequences={},ExtinguishCooldown={},PromptCache={},ESP={},Running=true,Config
={Autofarm=false,TPToPrompts=true,RemotePrompts=false,ServerValidatedPrompts=
true,AllowTeleportFallback=true,ReturnAfterPrompt=false,InstantProximityPrompts=
true,AutoCheckPatients=true,AutoTreatment=true,PrioritizeCriticalPatients=true,
AutoSleepPatient=true,AutoXRayMinigame=true,AutoSurgeryTreatment=true,
AutoCarryFaintedPatient=true,AutoProcessPCResults=true,AutoHeartMinigame=true,
AutoExtinguish=true,TreatmentKillAnomaly=true,AutoShutterAnomaly=true,
AutoDumpUselessItems=true,AutoTalkIdleVisitors=true,AutoBarney=true,
AutoCoffeeHeadBanger=true,AnomalyESP=true,InfiniteSanity=true,AntiJumpscare=true
,AutoPickupTreatmentItems=true,PauseAutofarmWhileMoving=true,
TriggerDisabledPrompts=false,Noclip=true,AnchorDuringPrompt=true,
PromptCooldownSeconds=0.6,PromptDistance=100000,CheckInStepCooldownSeconds=1.5,
TeleportYOffset=2.5,TeleportBackstep=4,TeleportSettleRepeats=1,
TeleportSettleSeconds=0.05,XRayCycleQuietSeconds=1.3,XRayReplayDelaySeconds=0.22
,XRayClickSettleSeconds=0.18,SurgeryApplySettleSeconds=0.55,
SurgeryDetectRecheckSeconds=0.12,ManualMovePauseSeconds=0.8,FocusHoldSeconds=2,
ItemPickupWaitSeconds=0.25,ItemPickupPendingSeconds=0.5,
TreatmentApplyVerifySeconds=0.2,ShutterWaitSeconds=2.5,CheckInAnomalyRadius=36}}
if getgenv then getgenv().AnimalHospitalAutomation=k end local l={checkInRoots=
nil,checkInRootsAt=0,roomByName={},requiredCounts={},treatmentProgress={},
readyRooms=nil,readyRoomsAt=0,checkInPositions=nil,checkInPositionsAt=0,
noclipParts={},noclipChar=nil,noclipAt=0,objectiveLabel=nil}if j then for m,n in
pairs(j)do if k.Config[m]~=nil then k.Config[m]=n end end end k.Config.
ItemPickupWaitSeconds=0.25 k.Config.ItemPickupPendingSeconds=0.5 k.Config.
TeleportYOffset=2.5 k.Config.CheckInAnomalyRadius=k.Config.CheckInAnomalyRadius
or 36 k.Config.TeleportSettleRepeats=1 k.Config.TeleportSettleSeconds=0.05 k.
Config.PromptCooldownSeconds=math.min(k.Config.PromptCooldownSeconds or 0.6,0.6)
k.Config.TreatmentApplyVerifySeconds=0.2 k.Config.XRayCycleQuietSeconds=1.3 k.
Config.XRayReplayDelaySeconds=0.22 k.Config.XRayClickSettleSeconds=0.18 k.Config
.SurgeryApplySettleSeconds=k.Config.SurgeryApplySettleSeconds or 0.55 k.Config.
SurgeryDetectRecheckSeconds=k.Config.SurgeryDetectRecheckSeconds or 0.12 k.
Config.Noclip=k.Config.Noclip~=false k.Config.AnchorDuringPrompt=k.Config.
AnchorDuringPrompt~=false local m={['Medicine']=true,['Coffee']=true,[
'Transplant']=true,['Bandages']=true,['Antibiotics']=true,['Scissors']=true,[
'Scalpel']=true,['Medkit']=true,['Organ']=true,['IV Drops']=true,['Eye Drops']=
true,['Herbs']=true,['Ointment']=true,['Thermo']=true,['Chocolate (60% Sanity)']
=true}local n={['Cough Syrup']=true,['Maple Syrup']=true}local o={['Stamp Forms'
]=true,['Take Photo']=true,['Register']=true,['Print Badge']=true,['Take']=true}
local p={['Take DNA Sample']=true,['Analyze Sample']=true,['Apply Treatment']=
true,['Prepare Patient']=true,['Sleep Patient']=true,['Begin X-Ray']=true,[
'Collect']=true,['Set Up']=true,['Turn On']=true,['Begin']=true}local q={[
'Process Results']=true,['Register']=true,['Print Badge']=true,['Collect']=true}
local r={}local function s(t)if t then table.insert(k.Connections,t)end return t
end local function t(u)pcall(function()e:SetCore('SendNotification',{Title=
'Animal Hospital',Text=u,Duration=4})end)end local function u(v)return h:
FindFirstChild('RE/'..v)end local function v(w,...)local x=u(w)if x then pcall(
function(...)x:FireServer(...)end,...)end end local function w()return g.
Character or g.CharacterAdded:Wait()end local function x()local y=w()return y:
FindFirstChild('HumanoidRootPart')or y:FindFirstChild('RootPart')end local 
function y(z)table.clear(l.noclipParts)l.noclipChar=z l.noclipAt=os.clock()if
not z then return end for A,B in ipairs(z:GetDescendants())do if B:IsA(
'BasePart')then table.insert(l.noclipParts,B)end end end local function z()if
not k.Config.Noclip then return end local A=g.Character if not A then return end
if A~=l.noclipChar or os.clock()-l.noclipAt>3 then y(A)end for B,C in ipairs(l.
noclipParts)do if C.Parent and C.CanCollide then C.CanCollide=false end end end
local function A(B)local C=B.Parent if C:IsA('Attachment')then return C.
WorldCFrame end if C:IsA('BasePart')then return C.CFrame end local function D(E)
local F for G,H in ipairs(E:GetDescendants())do if H:IsA('BasePart')then local I
=string.lower(H.Name or'')if not I:find('roof',1,true)and not I:find('ceiling',1
,true)then return H end F=F or H end end return F end local E=D(C)if E then
return E.CFrame end local F=C while F and F~=c do if F:IsA('BasePart')then
return F.CFrame end if F:IsA('Model')then local G=D(F)if G then return G.CFrame
end if F.PrimaryPart then return F.PrimaryPart.CFrame end end F=F.Parent end
return nil end local function B(C)local D=A(C)local E=x()if not D or not E then
return D end local F=E.Position-D.Position if F.Magnitude<1 then F=-D.LookVector
end F=Vector3.new(F.X,0,F.Z)if F.Magnitude<1 then F=Vector3.new(0,0,-1)end F=F.
Unit local G=D.Position+F*k.Config.TeleportBackstep G=Vector3.new(G.X,D.Position
.Y+k.Config.TeleportYOffset,G.Z)return CFrame.lookAt(G,Vector3.new(D.Position.X,
G.Y,D.Position.Z))end local function C(D,E)local F=x()local G=B(D)or A(D)if not
F or not G then return false end E=math.max(1,E or 1)for H=1,E do z()pcall(
function()F.AssemblyLinearVelocity=Vector3.zero F.AssemblyAngularVelocity=
Vector3.zero end)F.CFrame=G pcall(function()local I=w():FindFirstChildOfClass(
'Humanoid')if I then I:ChangeState(Enum.HumanoidStateType.GettingUp)end end)task
.wait(k.Config.TeleportSettleSeconds)end return true end local function D(E)if
not k.Config.AllowTeleportFallback then return end if k.Config.RemotePrompts
then return end if not k.Config.TPToPrompts then return end C(E,k.Config.
TeleportSettleRepeats)end local function E(F)if not F:IsA('ProximityPrompt')then
return end pcall(function()F.HoldDuration=0 F.MaxActivationDistance=math.max(F.
MaxActivationDistance,k.Config.PromptDistance)F.RequiresLineOfSight=false end)
end local function F(G,H)return string.lower(r.promptAction(G))==string.lower(H)
end local function G()local H=c:FindFirstChild('Misc')return H and H:
FindFirstChild('CheckIn')end local H=nil local I=0 local function J()if l.
checkInRoots and os.clock()-l.checkInRootsAt<5 then return l.checkInRoots end
local K={}local L={}local M=c:FindFirstChild('Misc')local function N(O)if O and
not L[O]then L[O]=true table.insert(K,O)end end N(G())if M then for O,P in
ipairs(M:GetDescendants())do local Q=P.Name:lower():gsub('[^%w]','')if(P:IsA(
'Folder')or P:IsA('Model'))and Q:find('checkin',1,true)then N(P)end end end l.
checkInRoots=K l.checkInRootsAt=os.clock()return K end local function K(L)local
M=J()for N in pairs(k.PromptCache)do if N.Parent then for O,P in ipairs(M)do if
N:IsDescendantOf(P)then if L(N,P)then return end break end end end end end local 
function L(M,N)local O local P K(function(Q,R)if N and r.promptAction(Q)~=N then
return false end local S=Q.Parent local T=S while T and T.Parent~=R and T.Parent
do T=T.Parent end local U=M==nil or(S and S.Name==M)or(T and T.Name==M)or(M==
'BadgeBase'and r.promptAction(Q)=='Take')if U then if Q.Enabled then P=Q return
true end O=O or Q end return false end)return P or O end local function M()local
N local O K(function(P)if r.promptAction(P)=='Take'then if P.Enabled then O=P
return true end N=N or P end return false end)if O then return O end if k.Config
.TriggerDisabledPrompts then return N end return nil end local function N(O,P,Q)
local R if P=='BadgeBase'then R=M()else R=L(P,Q)end if not R or(not k.Config.
TriggerDisabledPrompts and not R.Enabled)then return false end if not r.
canRunStep('CheckIn:'..O)then return false end k.LastCheckInStep=O k.
LastCheckInPrompt=R:GetFullName()return r.triggerPrompt(R)end local function O(P
,Q)return P and d:HasTag(P,Q)end local function P(Q)if not Q then return false
end local R,S=pcall(d.GetTags,d,Q)if not R or not S then return false end for T,
U in ipairs(S)do if U:match('^VisitorAtCheckIn%d*$')or U:match(
'^PatientAtCheckIn%d*$')then return true end end return false end local function 
Q(R)return r.nearestModelAncestor(R)end local R=nil local function S()if R and R
.Parent then return R.Text or''end local T=g:FindFirstChild('PlayerGui')local U=
T and T:FindFirstChild('Objective')and T.Objective:FindFirstChild('Frame')and T.
Objective.Frame:FindFirstChild('keys')and T.Objective.Frame.keys:FindFirstChild(
'objective')if U and U:IsA('TextLabel')then R=U return U.Text or''end return''
end local function T(U)U=string.lower(U or'')if U:find('stamp',1,true)or U:find(
'form',1,true)then return true end if U:find('photo',1,true)then return true end
if U:find('register',1,true)or U:find('computer',1,true)then return true end if
U:find('badge',1,true)then return true end if U:find('talk',1,true)then return
true end return false end local function U(V)V=string.lower(V or'')return V:
find('follow',1,true)and V:find('room',1,true)end local function V()for W in
pairs(k.PromptCache)do if W.Parent then E(W)end end end local function W(X)if
not X or not X:IsA('ProximityPrompt')then return false end if not k.Config.
TriggerDisabledPrompts and not X.Enabled then return false end local Y=os.clock(
)local Z=k.PromptCooldown[X]if Z and Y-Z<k.Config.PromptCooldownSeconds then
return false end k.PromptCooldown[X]=Y return true end function r.triggerPrompt(
X)if not W(X)then return false end k.LastPrompt=X:GetFullName()E(X)local Y=x()
local Z=Y and Y.CFrame local _=Y and Y.Anchored D(X)if k.Config.
AnchorDuringPrompt and Y then pcall(function()Y.Anchored=true Y.
AssemblyLinearVelocity=Vector3.zero Y.AssemblyAngularVelocity=Vector3.zero end)
end local aa=false if typeof(fireproximityprompt)=='function'then aa=pcall(
function()fireproximityprompt(X)end)end if not aa then aa=pcall(function()X:
InputHoldBegin()task.wait(math.max(X.HoldDuration,0.03))X:InputHoldEnd()end)end
task.wait(0.08)if k.Config.ReturnAfterPrompt and Z and Y and Y.Parent then Y.
CFrame=Z end if _~=nil and Y and Y.Parent then pcall(function()Y.Anchored=_ end)
end return aa end function r.promptAction(aa)return tostring(aa.ActionText or'')
end local function aa(X)for Y in pairs(k.PromptCache)do if not k.Running then
return end if Y.Parent and Y:IsDescendantOf(c)then X(Y,r.promptAction(Y),Y:
GetFullName())else k.PromptCache[Y]=nil end end end local function X(Y)return Y
and Y:IsA('Model')and Y:GetAttribute('IsPatient')==true end local function Y(Z)
if not X(Z)or r.isPatientHealed(Z)then return false end if Z:GetAttribute(
'InBed')==true then return true end if Z:GetAttribute('CompletedCheckIn')and not
P(Z)then return true end return false end function r.nearestModelAncestor(Z)
local _=Z while _ and _~=c do if _:IsA('Model')then return _ end _=_.Parent end
return nil end local Z={'Medicine','Antibiotics','Bandages','IV Drops',
'Eye Drops','Herbs','Ointment','Thermo','Medkit','Scissors','Scalpel','Organ',
'Transplant','Cough Syrup','Maple Syrup'}local _={['IV Drops']=true,['Medicine']
=true,['Antibiotics']=true,['Bandages']=true,['Scissors']=true,['Scalpel']=true,
['Medkit']=true,['Transplant']=true,['Organ']=true}local ab pcall(function()ab=
require(b:WaitForChild('Data'):WaitForChild('IllnessesAndCures'))end)local ac={}
local function ad(ae)if not ae or ae==''then return nil end local af=ac[ae]if af
and af.Parent then return af end local ag=c:FindFirstChild('Rooms')if not ag
then return nil end for ah,ai in ipairs(ag:GetDescendants())do if(ai:IsA(
'Folder')or ai:IsA('Model'))and ai.Name==ae then ac[ae]=ai return ai end end
return nil end local function ae(af)local ag=af while ag and ag~=c do if(ag:IsA(
'Folder')or ag:IsA('Model'))and ag.Name:match('^Room%d+$')then return ag end ag=
ag.Parent end return nil end local function af(ag)ag=tostring(ag or'')local ah=
ag:match('[Rr]oom%s*(%d+)')return ah and('Room'..ah)or nil end local function ag
()local ah=c:FindFirstChild('NPCs')if not ah then return nil end local ai local
aj=math.huge for ak,al in ipairs(ah:GetChildren())do if Y(al)then local am=
tostring(al:GetAttribute('DesignatedRoom')or'')local an=tonumber(am:match('%d+')
)or math.huge if not P(al)and an<aj then ai=al aj=an end end end return ai end
local ah={['Ratthew']=true}local function ai(aj)if not aj then return false end
return ah[aj.Name]==true or O(aj,'SkinwalkerIgnore')end function r.
isAnomalyModel(aj)if not aj or not aj:IsA('Model')then return false end if ai(aj
)then return false end local ak={'Ghost','Hider','GhostAnomaly','Skinwalker',
'HeadBanger','HeadBangerAnomaly','Headbang','Anomaly','Monster',
'TallMonsterSpawn','StalkerJumpscare','AnomalyShadow'}for al,am in ipairs(ak)do
if O(aj,am)then return true end end for al,am in pairs(aj:GetAttributes())do
local an=string.lower(tostring(al))if am==true and(an:find('anomaly',1,true)or
an:find('monster',1,true)or an:find('head',1,true)or an:find('ghost',1,true)or
an:find('hider',1,true)or an:find('skin',1,true)or an:find('walker',1,true))then
return true end end return false end function r.isPatientHealed(aj)if not aj
then return false end if k.TreatedPatients[aj]then return true end for ak,al in
ipairs({'Healed','Recovered','CompletedTreatment','TreatmentComplete','Cured'})
do if aj:GetAttribute(al)==true then return true end end if aj:GetAttribute(
'InBed')==false and aj:GetAttribute('CompletedCheckIn')then return true end
return false end function r.shouldIgnorePatientRoom(aj)if not aj then return
false end local ak=r.patientForRoom and r.patientForRoom(aj)if not ak then
return true end return r.isPatientHealed(ak)end local function aj(ak)return ak
and tostring(ak:GetAttribute('Minigame')or'')=='SurgeryRoom'end function r.
isXRayRoom(ak)return ak and tostring(ak:GetAttribute('Minigame')or'')==
'XRayRoom'end local function ak(al)return al and al:IsA('ProximityPrompt')and al
:GetFullName():find('Minigame.Colors',1,true)~=nil and al:GetFullName():find(
'Button',1,true)~=nil end local function al(am)if not ak(am)then return false
end if am.Enabled then return true end local an=am.Parent if not an or not an:
IsA('BasePart')then return false end local ao=an:GetAttribute('MainColor')if
typeof(ao)=='Color3'then local ap=math.abs(an.Color.R-ao.R)+math.abs(an.Color.G-
ao.G)+math.abs(an.Color.B-ao.B)if ap<0.25 then return true end end return an.
Material==Enum.Material.Neon end local function am(an)if not r.isXRayRoom(an)
then return nil end for ao,ap in ipairs(an:GetDescendants())do if ak(ap)and(ap.
Enabled or al(ap))then return ap end end return nil end local an=0.02 local ao=
0.5 local ap=3 local aq=4 local ar=6 local function as(at)local au={}local av=at
and at:FindFirstChild('Minigame')local aw=av and av:FindFirstChild('Colors')if
not aw then return au end for ax,ay in ipairs(aw:GetDescendants())do if ay:IsA(
'BasePart')and ay.Name=='Button'then local az=ay:FindFirstChildOfClass(
'ClickDetector')local aA=ay:GetAttribute('MainColor')if az and typeof(aA)==
'Color3'then table.insert(au,{part=ay,click=az,mainColor=aA})end end end return
au end local function at(au)local av=au and au:GetFullName()or'NoRoom'local aw=k
.XRaySequences[av]if aw then return aw end aw={buttons=as(au),sequence={},
lastLitAt=0,lastNudgeAt=0,replaying=false,phase='colors'}k.XRaySequences[av]=aw
for ax,ay in ipairs(aw.buttons)do s(ay.part:GetPropertyChangedSignal('Color'):
Connect(function()if aw.replaying then return end local az=os.clock()local aA=ay
.part.Color local aB=math.abs(aA.R-ay.mainColor.R)+math.abs(aA.G-ay.mainColor.G)
+math.abs(aA.B-ay.mainColor.B)if aB>an then if#aw.sequence>0 then aw.lastLitAt=
az end return end if az-aw.lastLitAt>ap then table.clear(aw.sequence)end if aw.
sequence[#aw.sequence]==ay and az-aw.lastLitAt<ao then aw.lastLitAt=az return
end table.insert(aw.sequence,ay)aw.lastLitAt=az aw.phase='colors'end))end return
aw end local function au(av)local aw=av and av:GetFullName()or'NoRoom'local ax=k
.XRaySequences[aw]if ax then table.clear(ax.sequence)ax.lastLitAt=0 ax.
lastNudgeAt=os.clock()ax.replaying=false ax.phase='colors'end end function r.
hasActiveXRayButton(av)if am(av)~=nil then return true end local aw=k.
XRaySequences[av and av:GetFullName()or'NoRoom']return aw~=nil and#aw.sequence>0
end local function av(aw)if not aw then return false end for ax in pairs(k.
PromptCache)do if ax.Parent and ax.Enabled and ax:IsDescendantOf(aw)then local
ay=r.promptAction(ax)local az=ax:GetFullName()if ay=='Inspect'and az:find(
'Monitor',1,true)then continue end if r.isXRayRoom(aw)and ak(ax)then return true
end if p[ay]or q[ay]then return true end end end return false end local function 
aw(ax)if not ax or r.shouldIgnorePatientRoom(ax)then return false end if r.
allTreatmentItemsApplied and r.allTreatmentItemsApplied(ax)then return false end
if av(ax)then return true end if r.firstMissingTreatmentItem(ax)or r.
nextTreatmentItemToApply(ax)then return true end if aj(ax)and r.
surgeryRequestedItem and r.surgeryRequestedItem(ax)then return true end if aj(ax
)and k.Config.AutoSurgeryTreatment then return true end if r.isXRayRoom(ax)and k
.Config.AutoXRayMinigame then return true end return false end local function ax
()local ay=r.firstReadyTreatmentRoom()if ay then return ay end local az=ad(af(S(
)))if az and not r.shouldIgnorePatientRoom(az)then k.CurrentTreatmentRoomName=az
.Name return az end local aA=ad(k.CurrentTreatmentRoomName)if aA and not r.
shouldIgnorePatientRoom(aA)then return aA end local aB=c:FindFirstChild('Rooms')
if not aB then return nil end for aC,aD in ipairs(aB:GetDescendants())do if aD:
IsA('ProximityPrompt')and aD.Enabled then local aE=ae(aD)if aE and not r.
shouldIgnorePatientRoom(aE)and p[r.promptAction(aD)]then k.
CurrentTreatmentRoomName=aE.Name return aE end end end local aC=ag()local aD=aC
and ad(aC:GetAttribute('DesignatedRoom'))if aD and not r.isPatientHealed(aC)then
k.CurrentTreatmentRoomName=aD.Name return aD end return nil end function r.
patientForRoom(ay)if not ay then return nil end local az=c:FindFirstChild('NPCs'
)if not az then return nil end for aA,aB in ipairs(az:GetChildren())do if X(aB)
and aB:GetAttribute('DesignatedRoom')==ay.Name and Y(aB)then return aB end end
return nil end local ay=nil local az=0 local function aA()local aB={}if not k.
Config.PrioritizeCriticalPatients then return aB end for aC,aD in ipairs(d:
GetTagged('EmergencyEventCounter'))do if aD:IsDescendantOf(c)then local aE local
aF=aD:IsA('Model')and aD or r.nearestModelAncestor(aD)if X(aF)then aE=aF else
local aG=ae(aD)aE=aG and r.patientForRoom(aG)or nil end if aE and not r.
isPatientHealed(aE)then local aG=tonumber(aD:GetAttribute('TimeLeft'))or math.
huge if not aB[aE]or aG<aB[aE]then aB[aE]=aG end end end end return aB end
function r.hasCriticalPatient()return next(aA())~=nil end local function aB()if
ay and os.clock()-az<0.2 then return ay end local aC={}local aD=c:
FindFirstChild('NPCs')if not aD then ay=aC az=os.clock()return aC end local aE=
aA()for aF,aG in ipairs(aD:GetChildren())do if Y(aG)and not P(aG)then local aH=
ad(aG:GetAttribute('DesignatedRoom'))if aH and aw(aH)then table.insert(aC,{room=
aH,patient=aG,number=tonumber(aH.Name:match('%d+'))or math.huge,criticalTime=aE[
aG],surgery=aj(aH)})end end end table.sort(aC,function(aF,aG)if(aF.criticalTime
~=nil)~=(aG.criticalTime~=nil)then return aF.criticalTime~=nil end if aF.
criticalTime and aG.criticalTime and aF.criticalTime~=aG.criticalTime then
return aF.criticalTime<aG.criticalTime end if aF.surgery~=aG.surgery then return
aF.surgery end if aF.number==aG.number then return aF.patient.Name<aG.patient.
Name end return aF.number<aG.number end)ay=aC az=os.clock()return aC end
function r.firstReadyTreatmentRoom()local aC=aB()local aD=aC[1]if aD then k.
CurrentTreatmentRoomName=aD.room.Name return aD.room end return nil end local 
function aC(aD,aE,aF)local aG=r.patientForRoom(aD)if not aG then return false
end for aH,aI in ipairs(aF)do for aJ,aK in ipairs(aG:GetDescendants())do if aK:
IsA('ProximityPrompt')and r.promptAction(aK)==aI and(k.Config.
TriggerDisabledPrompts or aK.Enabled)then if not r.canRunStep('Patient:'..aG:
GetFullName()..':'..aE)then return false end k.LastTreatmentRoom=aD:GetFullName(
)k.CurrentTreatmentRoomName=aD.Name k.LastTreatmentStep=aE k.LastTreatmentPrompt
=aK:GetFullName()return r.triggerPrompt(aK)end end end return false end local 
function aD(aE,aF,aG)if not aE then return nil end local aH={}for aI,aJ in
ipairs(aF)do aH[aJ]=aI end local aI,aJ for aK in pairs(k.PromptCache)do if aK.
Parent and(k.Config.TriggerDisabledPrompts or aK.Enabled)and aK:IsDescendantOf(
aE)then local aL=aH[r.promptAction(aK)]if aL and(not aJ or aL<aJ)then local aM=
aK:GetFullName()if not aG or aG(aM,aK)then aI=aK aJ=aL if aL==1 then break end
end end end end return aI end local function aE(aF)return aF and aF:IsA(
'ProximityPrompt')and r.promptAction(aF)=='Inspect'and aF:GetFullName():find(
'Monitor',1,true)~=nil end local function aF(aG,aH,aI,aJ)local aK=aD(aG,aI,aJ)if
not aK then return false end if not r.canRunStep('Room:'..aG:GetFullName()..':'
..aH)then return false end k.LastTreatmentRoom=aG:GetFullName()k.
CurrentTreatmentRoomName=aG.Name k.LastTreatmentStep=aH k.LastTreatmentPrompt=aK
:GetFullName()return r.triggerPrompt(aK)end local function aG(aH)aH=string.
lower(tostring(aH or''))for aI,aJ in ipairs(Z)do if aH:find(string.lower(aJ),1,
true)then return aJ end end return nil end local function aH(aI)if not aI then
return nil end for aJ,aK in ipairs({'RequiredItem','RequiredCure',
'TreatmentItem','Cure','HealedWith','Medicine'})do local aL=aI:GetAttribute(aK)
if m[aL]then return aL end end if ab then for aJ,aK in ipairs({'Illness',
'IllnessName','CurrentIllness','Disease','Diagnosis'})do local aL=aI:
GetAttribute(aK)if type(aL)=='string'and aL~=''then local aM if type(ab.
GetIllnessByName)=='function'then pcall(function()aM=ab:GetIllnessByName(aL)end)
end if aM then local aN if type(ab.GetCureForIllness)=='function'then pcall(
function()aN=ab:GetCureForIllness(aM)end)end if aN and m[aN.Name]then return aN.
Name end if m[aM.HealedWith]then return aM.HealedWith end end end end end return
nil end local aI={}function r.requiredTreatmentCounts(aJ)local aK=aJ or'NoRoom'
local aL=aI[aK]if aL and os.clock()-aL.at<0.25 then return aL.value end local aM
={}local aN={}if aJ then for aO,aP in ipairs(aJ:GetDescendants())do if aP:IsA(
'Frame')then local aQ=aP:GetFullName()if not aQ:find('Template',1,true)and(aQ:
find('.inv.',1,true)or aQ:find('Report.inv',1,true))then local aR=aP:
FindFirstChild('name')local aS=aG(aP.Name)or(aR and aG(aR.Text))if aS then local
aT=aN[aS]if not aT then aT={name=aS,total=0,cured=0}aN[aS]=aT table.insert(aM,aT
)end aT.total+=1 if aP:GetAttribute('Cured')==true then aT.cured+=1 end end end
end end end local aO=aM if#aM==0 then local aP,aQ=r.treatmentProgress(aJ)if aP
and aQ and aQ>0 and aP>=aQ then aI[aK]={at=os.clock(),value=aM}return aM end
local aR=aG(S())if aR then aO={{name=aR,total=1,cured=0}}else local aS=aH(r.
patientForRoom(aJ)or ag())if aS then aO={{name=aS,total=1,cured=0}}end end end
aI[aK]={at=os.clock(),value=aO}return aO end local function aJ(aK,aL)if not aL
then return 0 end for aM,aN in ipairs(r.requiredTreatmentCounts(aK))do if aN.
name==aL then return math.max(0,aN.total-aN.cured)end end return 0 end function
r.requiredTreatmentItems(aK)local aL={}for aM,aN in ipairs(r.
requiredTreatmentCounts(aK))do table.insert(aL,aN.name)end return aL end local 
function aK(aL)local aM=r.requiredTreatmentItems(aL)return aM[1]end local 
function aL(aM)local aN=r.patientForRoom(aM)if aN then return table.concat({aM
and aM:GetFullName()or'',aN:GetFullName(),tostring(aN:GetAttribute(
'CompletedCheckIn')or''),tostring(aN:GetAttribute('DesignatedRoom')or'')},'|')
end return aM and aM:GetFullName()or'NoRoom'end local function aM(aN)local aO=aN
and aN:GetFullName()or'NoRoom'local aP=aL(aN)if k.ActiveTreatmentSession[aO]~=aP
then k.ActiveTreatmentSession[aO]=aP k.TreatmentAppliedItems[aP]={}end return aP
,k.TreatmentAppliedItems[aP]end local function aN(aO,aP)if not aP then return
end local aQ,aR=aM(aO)aR[aP]=os.clock()end local function aO(aP,aQ)if not aQ
then return false end local aR,aS=aM(aP)return aS[aQ]~=nil end function r.
firstMissingTreatmentItem(aP)for aQ,aR in ipairs(r.requiredTreatmentCounts(aP))
do local aS=math.max(0,aR.total-aR.cured)if aS>0 and r.toolCountByName(aR.name)
==0 then return aR.name end end return nil end function r.
nextTreatmentItemToApply(aP)for aQ,aR in ipairs(r.requiredTreatmentCounts(aP))do
local aS=math.max(0,aR.total-aR.cured)if aS>0 and r.getToolByName(aR.name)then
return aR.name end end return nil end local function aP(aQ,aR)local aS=aR and r.
getToolByName(aR)if aS then k.LastRequiredTreatmentItem=aR r.equipTool(aS)return
aR end return nil end local function aQ(aR)for aS,aT in ipairs(r.
requiredTreatmentItems(aR))do if not aO(aR,aT)then return aT end end return nil
end function r.allTreatmentItemsApplied(aR)local aS=r.requiredTreatmentCounts(aR
)if#aS==0 then return false end local aT,aU=r.treatmentProgress(aR)if aT and aU
then return aU>0 and aT>=aU end for aV,aW in ipairs(aS)do if aW.cured<aW.total
then return false end end return true end local function aR(aS)local aT=g.
Character if not aT then return nil end for aU,aV in ipairs(aT:GetChildren())do
if aV:IsA('Tool')and aJ(aS,aV.Name)>0 then return aV.Name end end return nil end
local aS={}function r.treatmentProgress(aT)if not aT then return nil,nil end
local aU=aS[aT]if aU and os.clock()-aU.at<0.25 then return aU.done,aU.total end
local aV,aW for aX,aY in ipairs(aT:GetDescendants())do if aY:IsA('TextLabel')or
aY:IsA('TextButton')or aY:IsA('TextBox')then local aZ=tostring(aY.Text or'')
local a_,a0=aZ:match(
[[[Tt][Rr][Ee][Aa][Tt][Mm][Ee][Nn][Tt]%s*:%s*(%d+)%s*/%s*(%d+)]])if a_ and a0
then aV,aW=tonumber(a_),tonumber(a0)break end end end aS[aT]={at=os.clock(),done
=aV,total=aW}return aV,aW end local function aT(aU)local aV=r.treatmentProgress(
aU)if not aV or aV<=0 then return end local aW,aX=aM(aU)local aY=0 for aZ,a_ in
ipairs(r.requiredTreatmentItems(aU))do if aY>=aV then break end aX[a_]=aX[a_]or
0 aY+=1 end end local function aU(aV)local aW=0 for aX,aY in ipairs(r.
requiredTreatmentItems(aV))do if not aO(aV,aY)then aW+=1 end end return aW end
local function aV(aW)aT(aW)local aX=r.firstMissingTreatmentItem(aW)if aX then k.
LastRequiredTreatmentItem=aX if k.Config.AutoPickupTreatmentItems then if r.
dumpUnneededTreatmentItem(aW)then return true,nil end return r.
triggerSpecificItem(aX,aW,aJ(aW,aX)),nil end return false,nil end local aY=r.
nextTreatmentItemToApply(aW)if aY then aP(aW,aY)return false,aY end return false
,nil end local function aW(aX)aT(aX)local aY=r.firstMissingTreatmentItem(aX)if
aY then k.LastRequiredTreatmentItem=aY if k.Config.AutoPickupTreatmentItems then
if r.dumpUnneededTreatmentItem(aX)then return true,nil end return r.
triggerSpecificItem(aY,aX,aJ(aX,aY)),nil end return false,nil end local aZ=r.
nextTreatmentItemToApply(aX)if aZ then aP(aX,aZ)return false,aZ end return false
,nil end local function aX(aY)aT(aY)return r.firstMissingTreatmentItem(aY)or r.
nextTreatmentItemToApply(aY)end local function aY(aZ,a_)local a0,a1=aM(aZ)local
a2=a_ and a1[a_]return a2 and a2>0 and os.clock()-a2<1.5 end local function aZ(
a_)return aR(a_)or r.nextTreatmentItemToApply(a_)end local function a_(a0)return
r.firstMissingTreatmentItem(a0)end local function a0(a1)return aZ(a1)or r.
nextTreatmentItemToApply(a1)end local function a1(a2,a3)return aL(a2)..':'..
tostring(a3 or'')end local function a2(a3,a4)aN(a3,a4)end local function a3(a4)
if r.shouldIgnorePatientRoom(a4)then k.CurrentTreatmentRoomName=nil end end
local function a4(a5)return a0(a5)end local function a5(a6)return aW(a6)end
local function a6(a7,a8)aT(a7)a3(a7)end local function a7(a8,a9)local ba=a1(a8,
a9)return k.TreatmentApplyCooldown[ba]and os.clock()-k.TreatmentApplyCooldown[ba
]<0.6 end local function a8(a9,ba)k.TreatmentApplyCooldown[a1(a9,ba)]=os.clock()
end local function a9(ba,bb)return bb and aJ(ba,bb)>0 and not a7(ba,bb)end local 
function ba(bb,bc)if not bc or not a9(bb,bc)then return false end local bd=r.
treatmentProgress(bb)or 0 local be=aJ(bb,bc)a8(bb,bc)local bf=r.getToolByName(bc
)if bf then local bg=g.Character if bg and bf.Parent~=bg then r.equipTool(bf)for
bh=1,5 do if bf.Parent==bg then break end task.wait(0.03)end end end if aF(bb,
'ApplyTreatment:'..bc,{'Apply Treatment'},function(bg)return bg:find('Bed',1,
true)end)or aC(bb,'ApplyTreatment:'..bc,{'Apply Treatment'})then task.wait(k.
Config.TreatmentApplyVerifySeconds)aI[bb or'NoRoom']=nil aS[bb]=nil local bg=r.
treatmentProgress(bb)or bd local bh=aJ(bb,bc)if bg>bd or bh<be then a2(bb,bc)end
a6(bb,bc)if r.allTreatmentItemsApplied(bb)then k.LastRequiredTreatmentItem=nil
local bi=r.patientForRoom(bb)if bi then k.TreatedPatients[bi]=os.clock()end k.
CurrentTreatmentRoomName=nil end return true end return false end local function 
bb(bc)aT(bc)local bd,be=a5(bc)if bd then return true end if not be then return
false end return ba(bc,be)end local function bc(bd)aT(bd)if r.
firstMissingTreatmentItem(bd)then return'Pick',r.firstMissingTreatmentItem(bd)
end if r.nextTreatmentItemToApply(bd)then return'Apply',r.
nextTreatmentItemToApply(bd)end return'Done',nil end local function bd(be)local
bf,bg=bc(be)if bf=='Pick'then k.LastRequiredTreatmentItem=bg if k.Config.
AutoPickupTreatmentItems then if r.dumpUnneededTreatmentItem(be)then return true
end if r.triggerSpecificItem(bg,be,aJ(be,bg))then for bh=1,10 do if r.
getToolByName(bg)then break end task.wait(0.05)end if r.getToolByName(bg)then
aP(be,bg)ba(be,bg)end return true end return false end return false elseif bf==
'Apply'then aP(be,bg)return ba(be,bg)end return false end local function be(bf,
bg)bg=string.lower(tostring(bg or''))if aG(bg)then return true end if bg:find(
'give',1,true)or bg:find('apply',1,true)or bg:find('treat',1,true)or bg:find(
'heal',1,true)or bg:find('medicine',1,true)or bg:find('cure',1,true)then return
true end return aD(bf,{'Apply Treatment'},function(bh)return bh:find('Bed',1,
true)end)~=nil end local function bf()local bg=ag()if not bg then return false
end local bh=x()local bi=bg:FindFirstChild('HumanoidRootPart')or bg.PrimaryPart
or bg:FindFirstChildWhichIsA('BasePart',true)if bh and bi and r.canRunStep(
'FollowPatientToRoom',0.75)then local bj=bi.Position-bi.CFrame.LookVector*3 bj=
Vector3.new(bj.X,bi.Position.Y+1.5,bj.Z)bh.AssemblyLinearVelocity=Vector3.zero
bh.AssemblyAngularVelocity=Vector3.zero bh.CFrame=CFrame.lookAt(bj,Vector3.new(
bi.Position.X,bj.Y,bi.Position.Z))k.LastPrompt='FollowPatientToRoom:'..bg:
GetFullName()return true end local bj=ad(bg:GetAttribute('DesignatedRoom'))local
bk=bj and bj:FindFirstChild('MovePoints')and bj.MovePoints:FindFirstChild(
'Patient')if bh and bk and r.canRunStep('FollowPatientToRoom',0.75)then local bl
=bk.Position-bk.CFrame.LookVector*3 bl=Vector3.new(bl.X,bk.Position.Y+1.5,bl.Z)
bh.AssemblyLinearVelocity=Vector3.zero bh.AssemblyAngularVelocity=Vector3.zero
bh.CFrame=CFrame.lookAt(bl,Vector3.new(bk.Position.X,bl.Y,bk.Position.Z))k.
LastPrompt='FollowPatientToRoom:'..bj:GetFullName()return true end return false
end function r.toolCountByName(bg)local bh=0 local bi=g.Character local bj=g:
FindFirstChildOfClass('Backpack')for bk,bl in ipairs({bi,bj})do if bl then for
bm,bn in ipairs(bl:GetChildren())do if bn:IsA('Tool')and bn.Name==bg then bh+=1
end end end end return bh end function r.triggerSpecificItem(bg,bh,bi)if not bg
then return false end bi=math.max(1,bi or 1)if r.toolCountByName(bg)>=bi then k.
PendingItemPickup[bg]=nil return true end local bj=os.clock()local bk=k.
PendingItemPickup[bg]if type(bk)=='number'then bk={time=bk,count=0}end if bk and
r.toolCountByName(bg)>(bk.count or 0)then k.PendingItemPickup[bg]=nil return
true end if bk and bj-(bk.time or 0)<k.Config.ItemPickupPendingSeconds then
return false end if bk then k.PendingItemPickup[bg]=nil end local bl=k.
ItemPickupCooldown[bg]if bl and bj-bl<k.Config.ItemPickupWaitSeconds then return
false end local bm={}local bn={}aa(function(bo,bp,bq)if bp~=bg or not(k.Config.
TriggerDisabledPrompts or bo.Enabled)then return end if bh and bo:
IsDescendantOf(bh)then table.insert(bm,bo)elseif bq:find('Items',1,true)or bq:
find('Medicine',1,true)or(bg=='Coffee'and bq:find('CoffeeMachine',1,true))then
table.insert(bn,bo)end end)for bo,bp in ipairs(bm)do if r.triggerPrompt(bp)then
k.ItemPickupCooldown[bg]=os.clock()k.PendingItemPickup[bg]={time=os.clock(),
count=r.toolCountByName(bg)}return true end end for bo,bp in ipairs(bn)do if r.
triggerPrompt(bp)then k.ItemPickupCooldown[bg]=os.clock()k.PendingItemPickup[bg]
={time=os.clock(),count=r.toolCountByName(bg)}return true end end return false
end local function bg(bh)local bi={}aa(function(bj,bk,bl)if(k.Config.
TriggerDisabledPrompts or bj.Enabled)and bh(bj,bk,bl)then table.insert(bi,bj)end
end)for bj,bk in ipairs(bi)do if r.triggerPrompt(bk)then return true end end
return false end local function bh(bi)if not bi or not bi:IsA('Model')then
return false end if not P(bi)then return false end if r.isAnomalyModel(bi)then
return false end return X(bi)or bi:GetAttribute('IsVisitor')~=nil end local 
function bi()local bj=c:FindFirstChild('NPCs')if not bj then return false end
for bk,bl in ipairs(bj:GetChildren())do if bl:IsA('Model')and P(bl)and r.
isAnomalyModel(bl)then return true end end return false end local function bj()
return bg(function(bk,bl)if bl~='Talk'then return false end return bh(Q(bk))end)
end local function bk()local bl=c:FindFirstChild('NPCs')if bl then for bm,bn in
ipairs(bl:GetChildren())do if bh(bn)then return true end end end return false
end local function bl()if r.firstReadyTreatmentRoom and r.
firstReadyTreatmentRoom()then return true end for bm in pairs(k.PromptCache)do
if bm.Parent and bm.Enabled and not aE(bm)then local bn=bm:GetFullName()local bo
=bm.ActionText if bn:find('Rooms',1,true)and not bn:find('Medicine.Model',1,true
)then local bp=ae(bm)if bp and aw(bp)and(p[bo]or q[bo])then return true end end
end end return false end local function bm()local bn={}local bo=g.Character
local bp=g:FindFirstChildOfClass('Backpack')for bq,br in ipairs({bo,bp})do if br
then for bs,bt in ipairs(br:GetChildren())do if bt:IsA('Tool')then table.insert(
bn,bt)end end end end return bn end local function bn(bo)local bp={}for bq,br in
ipairs(r.requiredTreatmentItems(bo))do bp[br]=true end return bp end local bo={[
'Coffee']=true,['Chocolate (60% Sanity)']=true}local function bp(bq)if bo[bq]
then return true end local br=tostring(bq):lower()return br:find('exting',1,true
)~=nil or br:find('fire ext',1,true)~=nil end local function bq(br)local bs=x()
local bt local bu=math.huge aa(function(bv,bw,bx)if not(k.Config.
TriggerDisabledPrompts or bv.Enabled)then return end if not br(bv,bw,bx)then
return end local by=A(bv)local bz=0 if bs and by then bz=(bs.Position-by.
Position).Magnitude end if bz<bu then bt=bv bu=bz end end)return bt end local 
function br(bs)if not bs then return false end local bt=bs.Name local bu='Dump:'
..bt local bv=k.ItemPickupCooldown[bu]if bv and os.clock()-bv<1.5 then return
false end local bw=bq(function(bw,bx,by)return bx=='Trash Item'and by:find(
'Trash',1,true)end)if not bw then return false end local bx=g.Character if not
bx then return false end for by=1,6 do if bs:IsDescendantOf(bx)then break end r.
equipTool(bs)task.wait(0.05)end if not bs:IsDescendantOf(bx)then return false
end k.ItemPickupCooldown[bu]=os.clock()if not r.triggerPrompt(bw)then return
false end local by=os.clock()while os.clock()-by<1.25 do if not bs.Parent or not
r.getToolByName(bt)then return true end task.wait(0.1)end return not bs.Parent
or not r.getToolByName(bt)end function r.dumpUnneededTreatmentItem(bs)if not k.
Config.AutoDumpUselessItems then return false end local bt={}for bu,bv in
ipairs(r.requiredTreatmentCounts(bs))do bt[bv.name]=math.max(0,bv.total-bv.cured
)end if not next(bt)then return false end local bu={}for bv,bw in ipairs(bm())do
bu[bw.Name]=(bu[bw.Name]or 0)+1 if not bp(bw.Name)and bu[bw.Name]>(bt[bw.Name]or
0)then return br(bw)end end return false end function r.canRunStep(bs,bt)local
bu=os.clock()local bv=k.StepCooldown[bs]if bv and bu-bv<(bt or k.Config.
CheckInStepCooldownSeconds)then return false end k.StepCooldown[bs]=bu return
true end local function bs()if not k.Config.AutoCheckPatients then return end if
not bk()and bi()then return false end local bt=string.lower(S())if bt:find(
'stamp',1,true)or bt:find('form',1,true)then return N('StampForms','Form',
'Stamp Forms')elseif bt:find('photo',1,true)then return N('TakePhoto','Camera',
'Take Photo')elseif bt:find('register',1,true)or bt:find('computer',1,true)then
return N('Register','Computer','Register')elseif bt:find('print',1,true)and bt:
find('badge',1,true)then return N('PrintBadge','Printer','Print Badge')elseif bt
:find('take',1,true)and bt:find('badge',1,true)then return N('TakeBadge',
'BadgeBase','Take')elseif bt:find('talk',1,true)then if r.canRunStep(
'CheckIn:TalkPatient')then k.LastCheckInStep='TalkPatient'return bj()end return
false end local bu={{key='TakeBadge',station='BadgeBase',action='Take'},{key=
'StampForms',station='Form',action='Stamp Forms'},{key='TakePhoto',station=
'Camera',action='Take Photo'},{key='Register',station='Computer',action=
'Register'},{key='PrintBadge',station='Printer',action='Print Badge'}}for bv,bw
in ipairs(bu)do if N(bw.key,bw.station,bw.action)then return true end end if r.
canRunStep('CheckIn:TalkPatient')and bj()then k.LastCheckInStep='TalkPatient'
return true end return false end local function bt()if not k.Config.
AutoProcessPCResults then return false end local bu=ax()if r.
shouldIgnorePatientRoom(bu)then return false end return aF(bu,'ProcessResults',{
'Process Results'},function(bv)return bv:find('Monitor',1,true)end)end local bu=
{'Sleep Patient','Prepare Patient'}local function bv()if not k.Config.
AutoSleepPatient then return false end local bw=ax()if r.
shouldIgnorePatientRoom(bw)then return false end return aF(bw,'SleepPatient',bu,
function(bx)return bx:find('Bed',1,true)end)end local function bw(bx,by)if not
bx then return nil end for bz,bA in ipairs(bx:GetDescendants())do if bA:IsA(
'TextLabel')or bA:IsA('TextButton')or bA:IsA('TextBox')then local bB=bA:
GetFullName()if not bB:find('Medicine.Model',1,true)and not bB:find('Template',1
,true)then local bC=aG(bA.Text)if bC and(not by or by[bC])then return bC end end
end end return nil end local function bx(by)if not by then return nil end local
bz=by:FindFirstChild('Bed',true)local bA=bw(bz,_)if bA then return bA end local
bB=by:FindFirstChild('Minigame')if bB then for bC,bD in ipairs(bB:
GetDescendants())do if(bD:IsA('TextLabel')or bD:IsA('TextButton')or bD:IsA(
'TextBox'))and bD:IsA('GuiObject')and bD.Visible then local bE=bD:GetFullName()
if not bE:find('Monitor',1,true)and not bE:find('TV',1,true)and not bE:find(
'Report',1,true)and not bE:find('Medicine.Model',1,true)then local bF=aG(bD.Text
)if bF and _[bF]then return bF end end end end end return nil end function r.
surgeryRequestedItem(by)if not aj(by)then return nil end local bz=bx(by)if bz
then return bz end local bA=r.patientForRoom(by)for bB,bC in ipairs({bA,by})do
if bC then for bD,bE in pairs(bC:GetAttributes())do local bF=m[bE]and bE or aG(
tostring(bE))if bF and _[bF]then return bF end local bG=aG(tostring(bD))if bG
and _[bG]and bE==true then return bG end end end end local bB=aG(S())if bB and _
[bB]then return bB end local bC=by:FindFirstChild('Monitor',true)if bC then
local bD=bw(bC,_)if bD then return bD end end return nil end local function by(
bz,bA)local bB=(bz and bz:GetFullName()or'NoRoom')..':'..tostring(bA)local bC=k.
SurgeryLastApplied[bB]return bC and os.clock()-bC<0.9 end local function bz(bA,
bB)local bC=(bA and bA:GetFullName()or'NoRoom')..':'..tostring(bB)k.
SurgeryLastApplied[bC]=os.clock()end local function bA(bB,bC)if not bC or by(bB,
bC)then return false end r.equipTool(r.getToolByName(bC))if aF(bB,
'SurgeryApply:'..bC,{'Apply Treatment'},function(bD)return bD:find('Bed',1,true)
end)then bz(bB,bC)k.PendingItemPickup[bC]=nil k.SurgeryAppliedAt=os.clock()task.
wait(k.Config.SurgeryApplySettleSeconds)return true end return false end local 
function bB(bC)local bD=r.surgeryRequestedItem(bC)if not bD then return nil end
if k.SurgeryAppliedAt and os.clock()-k.SurgeryAppliedAt<k.Config.
SurgeryApplySettleSeconds then return nil end task.wait(k.Config.
SurgeryDetectRecheckSeconds)local bE=r.surgeryRequestedItem(bC)if bD==bE then
return bD end return nil end local function bC(bD)if not k.Config.
AutoSurgeryTreatment or not aj(bD)then return false end if aF(bD,
'SurgeryPreparePatient',bu,function(bE)return bE:find('Bed',1,true)end)then
return true end local bE=bB(bD)if bE then k.LastRequiredTreatmentItem=bE for bF,
bG in ipairs(bm())do if _[bG.Name]and bG.Name~=bE then return br(bG)end end if
not r.getToolByName(bE)then return r.triggerSpecificItem(bE,bD)end return bA(bD,
bE)end return false end local function bD(bE)if not k.Config.AutoXRayMinigame or
typeof(fireclickdetector)~='function'then return false end local bF=at(bE)if#bF.
buttons==0 or bF.replaying then return false end local bG=os.clock()if#bF.
sequence==0 then if bF.phase~='colors'then return false end if bF.lastLitAt>0
and bG-bF.lastLitAt<=aq then return false end if bG-bF.lastNudgeAt<ar then
return false end bF.lastNudgeAt=bG bF.replaying=true local bH=bF.buttons[1]local
bI=bH.part:FindFirstChildOfClass('ProximityPrompt')if bI then C(bI,1)end pcall(
fireclickdetector,bH.click)k.LastTreatmentStep='XRayColorNudge'task.wait(k.
Config.XRayClickSettleSeconds)bF.replaying=false return true end if bG-bF.
lastLitAt<k.Config.XRayCycleQuietSeconds then k.LastTreatmentStep=
'XRayColorRecording'return true end bF.replaying=true local bH=bF.sequence[1].
part:FindFirstChildOfClass('ProximityPrompt')if bH then C(bH,1)end bF.lastAnswer
={}for bI,bJ in ipairs(bF.sequence)do if bJ.click.Parent then table.insert(bF.
lastAnswer,tostring(bJ.mainColor))pcall(fireclickdetector,bJ.click)k.
LastTreatmentStep='XRayColor:'..bJ.part:GetFullName()task.wait(k.Config.
XRayReplayDelaySeconds+k.Config.XRayClickSettleSeconds)end end table.clear(bF.
sequence)bF.lastLitAt=0 bF.lastNudgeAt=os.clock()bF.replaying=false return true
end local function bE(bF)if not k.Config.AutoXRayMinigame or not r.isXRayRoom(bF
)then return false end local bG=at(bF)if d:HasTag(g,'InMinigame')then k.
LastTreatmentStep='XRayScanMinigame'return true end if aF(bF,'BeginXRay',{
'Begin X-Ray'},function(bH)return bH:find('xrayMonitor',1,true)end)then au(bF)
return true end if aF(bF,'ProcessXRayResults',{'Process Results'},function(bH)
return bH:find('Monitor',1,true)and not bH:find('xrayMonitor',1,true)end)then bG
.phase='done'return true end if aF(bF,'CollectXRayResults',{'Collect'},function(
bH)return bH:find('xresult',1,true)end)then bG.phase='done'return true end if#bG
.sequence>0 and bD(bF)then return true end if#r.requiredTreatmentItems(bF)>0 or
be(bF,S())then if bd(bF)then return true end end if bD(bF)then return true end
return false end local function bF(bG)if not bG then return false end if ai(bG)
then return false end if bG:GetAttribute('Skinwalker')==true then return true
end return O(bG,'Skinwalker')or O(bG,'SkinwalkerMonster')or r.isAnomalyModel(bG)
end local function bG(bH)local bI={}for bJ,bK in ipairs(r.
requiredTreatmentCounts(bH))do bI[bK.name]=true end for bJ,bK in ipairs(bm())do
if m[bK.Name]and not bI[bK.Name]and not bo[bK.Name]then return bK.Name end end
for bJ,bK in ipairs(Z)do if m[bK]and not bI[bK]then return bK end end return nil
end local function bH(bI)if not k.Config.TreatmentKillAnomaly then return false
end local bJ=r.patientForRoom(bI)if not bJ or not bF(bJ)then return false end
local bK=bG(bI)if not bK then return false end k.LastAnomalyKillTarget=bJ:
GetFullName()local bL=r.getToolByName(bK)if not bL then return r.
triggerSpecificItem(bK,bI,1)end r.equipTool(bL)if aF(bI,'AnomalyKill:'..bK,{
'Apply Treatment'},function(bM)return bM:find('Bed',1,true)end)or aC(bI,
'AnomalyKill:'..bK,{'Apply Treatment'})then return true end return false end
local function bI()if not k.Config.AutoTreatment then return false end local bJ=
string.lower(S())local bK=ax()if not bK then return false end if r.
shouldIgnorePatientRoom(bK)then k.CurrentTreatmentRoomName=nil return false end
if T(bJ)and not r.firstReadyTreatmentRoom()then return false end if U(bJ)and not
r.firstReadyTreatmentRoom()then return false end if bH(bK)then return true end
if bC(bK)then return true end if bE(bK)then return true end local bL local bM if
bJ:find('process',1,true)or bJ:find('result',1,true)or(bJ:find('complete',1,true
)and(bJ:find('analysis',1,true)or bJ:find('pc',1,true)))then bL=
'Process Results'bM=function(bN)return bN:find('Monitor',1,true)end elseif bJ:
find('take',1,true)and bJ:find('sample',1,true)then bL='Take DNA Sample'elseif
bJ:find('analy',1,true)then bL='Analyze Sample'elseif bJ:find('dna',1,true)or bJ
:find('inspect',1,true)then bL='Take DNA Sample'elseif bJ:find('prepare',1,true)
or bJ:find('sleep',1,true)then bL='BedRest'bM=function(bN)return bN:find('Bed',1
,true)end elseif bJ:find('apply',1,true)or bJ:find('treat',1,true)or bJ:find(
'heal',1,true)then bL='Apply Treatment'bM=function(bN)return bN:find('Bed',1,
true)end elseif bJ:find('x-ray',1,true)or bJ:find('xray',1,true)then bL=
'Begin X-Ray'elseif bJ:find('collect',1,true)then bL='Collect'elseif bJ:find(
'print',1,true)and bJ:find('badge',1,true)then bL='Print Badge'elseif bJ:find(
'set up',1,true)or bJ:find('iv',1,true)then bL='Set Up'elseif bJ:find('turn on',
1,true)or bJ:find('machine',1,true)then bL='Turn On'elseif bJ:find('heart',1,
true)or bJ:find('begin',1,true)then bL='Begin'end if bL then if bL==
'Take DNA Sample'then if aC(bK,'TakeDNASample',{'Take DNA Sample'})then return
true end end if bL=='Apply Treatment'then return bd(bK)end if bL=='BedRest'then
if aF(bK,'SleepPatient',bu,bM)then return true end elseif aF(bK,bL,{bL},bM)then
return true end end if aC(bK,'TakeDNASample',{'Take DNA Sample'})then return
true end if aF(bK,'DNASample',{'Inspect'},function(bN)return not bN:find(
'Monitor',1,true)end)then return true end if aF(bK,'AnalyzeSample',{
'Analyze Sample'})then return true end if aF(bK,'ProcessResults',{
'Process Results'},function(bN)return bN:find('Monitor',1,true)end)then return
true end if be(bK,bJ)then return bd(bK)end if aF(bK,'SleepPatient',bu,function(
bN)return bN:find('Bed',1,true)end)then return true end if aF(bK,'BeginXRay',{
'Begin X-Ray'})then return true end if aF(bK,'HeartBegin',{'Begin'})then return
true end if aF(bK,'SetUp',{'Set Up'})then return true end if aF(bK,'TurnOn',{
'Turn On'})then return true end if aF(bK,'Collect',{'Collect'})then return true
end if aF(bK,'PrintBadge',{'Print Badge'})then return true end return false end
local function bJ()if k.Config.AutoTreatment then local bK=bI()if bK then return
true end end if k.Config.AutoProcessPCResults and bt()then return true end if k.
Config.AutoSleepPatient and bv()then return true end return false end local 
function bK()if not k.Config.AutoTalkIdleVisitors then return end bg(function(bL
,bM,bN)if bM~='Talk'then return false end local bO=r.nearestModelAncestor(bL)if
X(bO)then return false end return bN:find('NPCs',1,true)end)end local function 
bL()if not k.Config.AutoCarryFaintedPatient then return false end local bM aa(
function(bN,bO,bP)if bM or not bN.Enabled then return end if bO=='Place Patient'
and bP:find('Rooms',1,true)and bP:find('Bed',1,true)then bM=bN end end)if bM
then return r.triggerPrompt(bM)end local bN aa(function(bO,bP,bQ)if bN or not bO
.Enabled then return end if bP=='Carry'and bQ:find('NPCs',1,true)then bN=bO end
end)if bN then return r.triggerPrompt(bN)end return false end function r.
getToolByName(bM)local bN=g.Character local bO=g:FindFirstChildOfClass(
'Backpack')if bN then local bP=bN:FindFirstChild(bM)if bP and bP:IsA('Tool')then
return bP end end if bO then local bP=bO:FindFirstChild(bM)if bP and bP:IsA(
'Tool')then return bP end end return nil end function r.equipTool(bM)local bN=w(
):FindFirstChildOfClass('Humanoid')if bN and bM then if bM.Parent==g.Character
then return end pcall(function()bN:EquipTool(bM)end)task.wait(0.04)end end local 
function bM()if not k.Config.AutoDumpUselessItems then return end local bN=ax()
if bN and r.dumpUnneededTreatmentItem(bN)then return end for bO in pairs(n)do
local bP=r.getToolByName(bO)if bP then br(bP)return end end end local function 
bN()if not k.Config.AutoHeartMinigame then return end local bO=u(
'StartHeartbeatMinigame')if bO and not k._heartHooked then k._heartHooked=true
s(bO.OnClientEvent:Connect(function(bP)if k.Config.AutoHeartMinigame then task.
wait(0.2)v('HeartbeatMinigameComplete',bP,true)end end))end local bP=g:
FindFirstChild('PlayerGui')bP=bP and bP:FindFirstChild('HeartbeatMinigameUI')if
bP and bP:FindFirstChild('Frame')and bP.Frame.Visible then v(
'HeartbeatMinigameComplete',true,true)end end local function bO(bP)if not bP
then return nil end if bP:IsA('BasePart')then return bP.Position end if bP:IsA(
'Model')then local bQ=bP:FindFirstChild('HumanoidRootPart')or bP.PrimaryPart or
bP:FindFirstChildWhichIsA('BasePart',true)return bQ and bQ.Position or nil end
local bQ=bP:FindFirstChildWhichIsA('BasePart',true)return bQ and bQ.Position or
nil end local function bP()for bQ,bR in ipairs(bm())do local bS=bR.Name:lower()
if bS:find('exting',1,true)or bS:find('fire ext',1,true)then return bR end end
return nil end local function bQ()local bR=c:FindFirstChild('Misc')local bS=bR
and bR:FindFirstChild('ExtinguisherStation')local bT=bS and bS:
FindFirstChildWhichIsA('ProximityPrompt',true)if bT and bT.Enabled then return
bT end return nil end local function bR()local bS=bP()if bS then return bS end
local bT=bQ()if not bT or tostring(bT.ActionText):lower():find('return',1,true)
then return nil end if r.triggerPrompt(bT)then for bU=1,10 do bS=bP()if bS then
return bS end task.wait(0.05)end end return bP()end local function bS()local bT=
{}local bU={}local function bV(bW,bX)if not bW or bU[bW]or not bW:
IsDescendantOf(c)then return end local bY=k.ExtinguishCooldown[bW]if bY and os.
clock()-bY<2 then return end bU[bW]=true table.insert(bT,{inst=bW,remote=bX})end
for bW,bX in ipairs(d:GetTagged('OnFire'))do if bX:IsA('Model')and d:HasTag(bX,
'NPC')then bV(bX,'ExtinguisherBubbleHitFireNPC')elseif bX.Parent and bX.Parent:
IsA('Model')and d:HasTag(bX.Parent,'NPC')then bV(bX.Parent,
'ExtinguisherBubbleHitFireNPC')else bV(bX,'ExtinguisherBubbleHit')end end for bW
,bX in ipairs(d:GetTagged('Grime'))do bV(bX,'ExtinguisherBubbleHitGrime')end for
bW,bX in ipairs({'Ghost','Hider'})do for bY,bZ in ipairs(d:GetTagged(bX))do bV(
bZ,'ExtinguisherBubbleHit'..bX)end end local bW=c:FindFirstChild('NPCs')if bW
then for bX,bY in ipairs(bW:GetChildren())do if bY:IsA('Model')and bY:
GetAttribute('WaterEntity')then bV(bY,'ExtinguisherBubbleHit'..bY.Name)end end
end return bT end local function bT(bU,bV)local bW=x()local bX=bO(bU.inst)if not
bW or not bX then return false end local bY=bW.Position-bX bY=Vector3.new(bY.X,0
,bY.Z)if bY.Magnitude<1 then bY=Vector3.new(0,0,-1)end bY=bY.Unit local bZ=bX+bY
*6 bZ=Vector3.new(bZ.X,bX.Y+k.Config.TeleportYOffset,bZ.Z)z()pcall(function()bW.
AssemblyLinearVelocity=Vector3.zero bW.AssemblyAngularVelocity=Vector3.zero end)
bW.CFrame=CFrame.lookAt(bZ,Vector3.new(bX.X,bZ.Y,bX.Z))task.wait(k.Config.
TeleportSettleSeconds)r.equipTool(bV)pcall(function()bV:Activate()end)k.
ExtinguishCooldown[bU.inst]=os.clock()v(bU.remote,bU.inst)task.wait(0.2)pcall(
function()bV:Deactivate()end)k.LastExtinguishTarget=bU.inst:GetFullName()return
true end local function bU()if not k.Config.AutoExtinguish then return false end
local bV=bS()if#bV==0 then local bW=bP()if not bW then k.
NoExtinguishTargetsSince=nil return false end k.NoExtinguishTargetsSince=k.
NoExtinguishTargetsSince or os.clock()if os.clock()-k.NoExtinguishTargetsSince<3
then return false end local bX=bQ()if bX and tostring(bX.ActionText):lower():
find('return',1,true)and r.canRunStep('ReturnExtinguisher',2)then r.equipTool(bW
)if r.triggerPrompt(bX)then k.NoExtinguishTargetsSince=nil return true end end
return false end k.NoExtinguishTargetsSince=nil local bW=bR()if not bW then for
bX,bY in ipairs(bV)do k.ExtinguishCooldown[bY.inst]=os.clock()v(bY.remote,bY.
inst)task.wait(0.04)end return true end local bX=x()local bY,bZ for b_,b0 in
ipairs(bV)do local b1=bO(b0.inst)local b2=(bX and b1)and(bX.Position-b1).
Magnitude or math.huge if not bY or b2<bZ then bY=b0 bZ=b2 end end return bT(bY,
bW)end local function bV()for bW,bX in ipairs({'AnomalyShadow',
'StalkerJumpscare','TallMonsterSpawn','DontLookUp'})do for bY,bZ in ipairs(d:
GetTagged(bX))do pcall(function()if bX=='AnomalyShadow'then bZ:SetAttribute(
'AnomalyShadowActive',false)elseif bX=='StalkerJumpscare'then bZ:SetAttribute(
'StalkerJumpscare',false)elseif bX=='TallMonsterSpawn'then bZ:SetAttribute(
'TallMonsterSpawn',false)end end)end end end local bW={'Ghost','Hider',
'GhostAnomaly','Skinwalker','HeadBanger','HeadBangerAnomaly','Headbang',
'Anomaly','Monster','TallMonsterSpawn','StalkerJumpscare','AnomalyShadow',
'DontLookUp'}local function bX(bY)if not bY then return false end local bZ=
string.lower(bY.Name or'')if bZ:find('head',1,true)or bZ:find('banger',1,true)or
bZ:find('bang',1,true)then return true end for b_,b0 in ipairs({'HeadBanger',
'HeadBangerAnomaly','Headbang'})do if d:HasTag(bY,b0)then return true end end
for b_,b0 in pairs(bY:GetAttributes())do local b1=string.lower(tostring(b_))if
b0==true and(b1:find('head',1,true)or b1:find('bang',1,true))then return true
end end return false end local function bY(bZ)if not bZ or not bZ:
IsDescendantOf(c)then return false end if d:HasTag(bZ,'TallMonsterSpawn')then
return bZ:GetAttribute('TallMonsterSpawn')==true end if d:HasTag(bZ,
'StalkerJumpscare')then return bZ:GetAttribute('StalkerJumpscare')==true end if
d:HasTag(bZ,'AnomalyShadow')then return bZ:GetAttribute('AnomalyShadowActive')==
true end if d:HasTag(bZ,'DontLookUp')then return bZ:GetAttribute('DontLookUp')==
true end for b_,b0 in ipairs(bW)do if d:HasTag(bZ,b0)then return true end end if
bZ:IsA('Model')then return r.isAnomalyModel(bZ)end return false end local 
function bZ(b_)local b0={}local b1={}local function b2(b3)if not b3 or b1[b3]or
not bY(b3)then return end if not b_ and bX(b3)then return end b1[b3]=true table.
insert(b0,b3)end for b3,b4 in ipairs(bW)do for b5,b6 in ipairs(d:GetTagged(b4))
do b2(b6)end end local b3=c:FindFirstChild('NPCs')if b3 then for b4,b5 in
ipairs(b3:GetChildren())do if b5:IsA('Model')then b2(b5)end end end return b0
end local function b_(b0)local b1={}for b2,b3 in ipairs(b0)do table.insert(b1,b3
:GetFullName())end table.sort(b1)return table.concat(b1,'|')end local function 
b0(b1)if not b1 then return nil end if b1:IsA('BasePart')then return b1.Position
end if b1:IsA('Model')then local b2=b1:FindFirstChild('HumanoidRootPart')or b1.
PrimaryPart or b1:FindFirstChildWhichIsA('BasePart',true)return b2 and b2.
Position or nil end local b2=b1:FindFirstChildWhichIsA('BasePart',true)return b2
and b2.Position or nil end local function b1(b2,b3)if not b2 or not b3 then
return math.huge end local b4=Vector3.new(b2.X-b3.X,0,b2.Z-b3.Z)return b4.
Magnitude end local b2=nil local b3=0 local function b4()if b2 and os.clock()-b3
<10 then return b2 end local b5={}for b6,b7 in ipairs(J())do local b8=b0(b7)if
b8 then table.insert(b5,b8)end for b9,ca in ipairs(b7:GetDescendants())do if ca:
IsA('ProximityPrompt')then local cb=A(ca)if cb then table.insert(b5,cb.Position)
end end end end b2=b5 b3=os.clock()return b5 end local function b5(b6)local b7=
b6 and(b6:IsA('Model')and b6 or r.nearestModelAncestor(b6))if b7 and P(b7)then
return true end local b8=b0(b7 or b6)if not b8 then return false end for b9,ca
in ipairs(b4())do if b1(b8,ca)<=k.Config.CheckInAnomalyRadius then return true
end end return false end local function b6()local b7={}for b8,b9 in ipairs(bZ(
false))do if b5(b9)then table.insert(b7,b9)end end return b7 end local function 
b7()if not k.Config.AutoShutterAnomaly then return end local b8=b6()if k.
LastShutterAt and os.clock()-k.LastShutterAt<k.Config.ShutterWaitSeconds then
return false end local b9=c:FindFirstChild('Misc')and c.Misc:FindFirstChild(
'Shutters')local ca=c:FindFirstChild('Misc')and c.Misc:FindFirstChild(
'ShutterButton')local cb=ca and ca:FindFirstChildWhichIsA('ProximityPrompt',true
)if not b9 or not cb or not cb.Enabled or cb.ActionText=='Locked'then return
false end local cc=b9:GetAttribute('Open')==true local cd=r.promptAction(cb)if#
b8>0 then local ce=b_(b8)k.ShutterAnomalyKey=ce if not cc then k.
ShutterClosedForAnomaly=true return false end if cd~='Close'and cd~='Interact'
then return false end local cf=r.triggerPrompt(cb)if cf then k.
ShutterClosedForAnomaly=true k.LastShutterAt=os.clock()end return cf end k.
ShutterAnomalyKey=nil k.ShutterClosedForAnomaly=false if cc then return false
end if cd~='Open'and cd~='Interact'then return false end local ce=r.
triggerPrompt(cb)if ce then k.LastShutterAt=os.clock()end return ce end local 
function b8(b9)return b9 and b9:IsA('ProximityPrompt')and F(b9,'Ask to Leave')
end local function b9()for ca in pairs(k.PromptCache)do if ca.Parent and b8(ca)
and(k.Config.TriggerDisabledPrompts or ca.Enabled)then local cb=r.
nearestModelAncestor(ca)if cb and cb:IsDescendantOf(c)then return cb end end end
for ca,cb in ipairs(bZ(true))do local cc=cb:IsA('Model')and cb or r.
nearestModelAncestor(cb)if cc and bX(cc)then return cc end end local ca=c:
FindFirstChild('NPCs')if ca then for cb,cc in ipairs(ca:GetChildren())do if cc:
IsA('Model')and bX(cc)and r.isAnomalyModel(cc)then return cc end end end return
nil end local function ca(cb)if not cb or not cb:IsDescendantOf(c)then return
nil end for cc,cd in ipairs(cb:GetDescendants())do if b8(cd)and(k.Config.
TriggerDisabledPrompts or cd.Enabled)then return cd end end return nil end
function r.hasLiveHeadBangerTarget()return ca(b9())~=nil end local function cb()
local cc=c:FindFirstChild('Misc')local cd=cc and cc:FindFirstChild(
'CoffeeMachine')local ce=cd and cd:FindFirstChild('Coffee')local cf=ce and ce:
FindFirstChildWhichIsA('ProximityPrompt')if cf and(k.Config.
TriggerDisabledPrompts or cf.Enabled)then return cf end return nil end local 
function cc()if r.getToolByName('Coffee')then return true end local cd=cb()if
not cd then return false end if r.triggerPrompt(cd)then for ce=1,8 do if r.
getToolByName('Coffee')then return true end task.wait(0.05)end end return r.
getToolByName('Coffee')~=nil end local function cd()if not k.Config.
AutoCoffeeHeadBanger then return false end local ce=b9()local cf=ca(ce)if not cf
then return false end if k.LastCoffeeHeadBangerAt and os.clock()-k.
LastCoffeeHeadBangerAt<1.5 then return false end local cg=r.getToolByName(
'Coffee')if not cg then if not cc()then return false end cg=r.getToolByName(
'Coffee')end if cg then r.equipTool(cg)end k.LastCoffeeHeadBangerAt=os.clock()
return r.triggerPrompt(cf)end local function ce()local cf=c:FindFirstChild(
'NPCs')if not cf then return nil end for cg,ch in ipairs(cf:GetChildren())do if
ch:IsA('Model')and(d:HasTag(ch,'CoffeeNPC')or ch.Name=='Barney')then return ch
end end return nil end local function cf(cg)for ch,ci in ipairs(cg:
GetDescendants())do if ci:IsA('ProximityPrompt')and(k.Config.
TriggerDisabledPrompts or ci.Enabled)then return ci end end return nil end local 
function cg(ch)local ci=g:FindFirstChild('PlayerGui')local cj=ci and ci:
FindFirstChild('Dialogue')local ck=cj and cj:FindFirstChild('Frame')local cl=ck
and ck:FindFirstChild('Options')if not cl or not cl.Visible then return false
end local cm=ck:FindFirstChild('nameframe')local cn=cm and tostring(cm.Text or''
)or''local co=tostring(ch:GetAttribute('DisplayDialogName')or'')if cn~=ch.Name
and(co==''or cn~=co)then return false end if not r.canRunStep('BarneyDecision',2
)then return false end v('DialogDecision',ch,1)k.LastBarneyStep='Decision'return
true end local function ch()if not k.Config.AutoBarney then return false end
local ci=ce()if not ci or not ci:IsDescendantOf(c)then return false end if cg(ci
)then return true end if b5(ci)and not bk()then local cj=L('Camera','Take Photo'
)if cj and cj.Enabled and r.canRunStep('BarneyPhoto',2)then k.LastBarneyStep=
'Photo'if r.triggerPrompt(cj)then return true end end end local cj=cf(ci)if not
cj then return false end if k.LastBarneyGiveAt and os.clock()-k.LastBarneyGiveAt
<1.5 then return false end if k.LastBarneyFailAt and os.clock()-k.
LastBarneyFailAt<2 then return false end local ck=string.lower(r.promptAction(cj
))local cl if ck:find('coffee',1,true)then cl='Coffee'else cl=aG(ck)end if cl==
'Coffee'then if not cc()then k.LastBarneyFailAt=os.clock()return false end
elseif cl then if not r.getToolByName(cl)then if not r.triggerSpecificItem(cl,
nil,1)then k.LastBarneyFailAt=os.clock()return false end for cm=1,10 do if r.
getToolByName(cl)then break end task.wait(0.05)end if not r.getToolByName(cl)
then k.LastBarneyFailAt=os.clock()return false end end end if cl then r.
equipTool(r.getToolByName(cl))end k.LastBarneyGiveAt=os.clock()k.LastBarneyStep=
'Prompt:'..r.promptAction(cj)return r.triggerPrompt(cj)end local function ci()if
k._SanityHooked then return end local cj,ck=pcall(function()return require(b:
WaitForChild('Lib'))end)if not cj or type(ck)~='table'then return end k._Lib=ck
if type(ck.Network)=='table'and type(ck.Network.FireServer)=='function'then k.
_origFireServer=ck.Network.FireServer ck.Network.FireServer=function(cl,cm,...)
if k.Config.InfiniteSanity and cm=='PlayerLostSanity'then return end return k.
_origFireServer(cl,cm,...)end end if type(ck.PlayerLostSanity)=='function'then k
._origPlayerLostSanity=ck.PlayerLostSanity ck.PlayerLostSanity=function(...)if k
.Config.InfiniteSanity then return end return k._origPlayerLostSanity(...)end
end k._SanityHooked=true end local function cj()local ck=k._Lib if not ck then
return end if k._origFireServer and type(ck.Network)=='table'then ck.Network.
FireServer=k._origFireServer end if k._origPlayerLostSanity then ck.
PlayerLostSanity=k._origPlayerLostSanity end k._origFireServer=nil k.
_origPlayerLostSanity=nil k._Lib=nil k._SanityHooked=false end local function ck
()if not k.Config.InfiniteSanity then return end ci()pcall(function()if g:
GetAttribute('SanityImpactMultiplier')~=0 then g:SetAttribute(
'SanityImpactMultiplier',0)end local cl=g:GetAttribute('Sanity')if cl==nil or cl
<100 then g:SetAttribute('Sanity',100)end end)end local function cl()if not(k.
Config.InfiniteSanity or k.Config.AutoExtinguish)then return false end local cm=
os.clock()if k.LastSelfFireCheckAt and cm-k.LastSelfFireCheckAt<0.15 then return
false end k.LastSelfFireCheckAt=cm local cn=g.Character if not cn then return
false end local co={}if d:HasTag(cn,'OnFire')then table.insert(co,cn)end for cp,
cq in ipairs(cn:GetDescendants())do if d:HasTag(cq,'OnFire')then table.insert(co
,cq)end end if#co==0 then return false end for cp,cq in ipairs(co)do v(
'ExtinguisherBubbleHit',cq)end k.LastSelfExtinguishAt=cm k.LastExtinguishTarget=
'SELF:'..cn:GetFullName()return true end local function cm()if not k.Config.
AntiJumpscare then return end bV()ck()if not k.LastJumpscareSweep or os.clock()-
k.LastJumpscareSweep>0.5 then k.LastJumpscareSweep=os.clock()local cn=g:
FindFirstChild('PlayerGui')if cn then for co,cp in ipairs(cn:GetDescendants())do
local cq=cp.Name:lower()if cq:find('jumpscare',1,true)or cq=='vignette2'then if
cp:IsA('GuiObject')then cp.Visible=false elseif cp:IsA('Sound')then cp:Stop()end
end end end end local cn=c.CurrentCamera if cn then cn.FieldOfView=70 if cn.
CameraType==Enum.CameraType.Scriptable then cn.CameraType=Enum.CameraType.Custom
end end end function k.ClearESP()for cn,co in pairs(k.ESP)do if co then pcall(
function()co:Destroy()end)end k.ESP[cn]=nil end end function k.SetESP(cn,co)if
not cn or not cn:IsDescendantOf(c)then return end local cp=k.ESP[cn]if not cp or
not cp.Parent then cp=Instance.new('Highlight')cp.Name='AnimalHospitalESP'cp.
DepthMode=Enum.HighlightDepthMode.AlwaysOnTop cp.FillTransparency=0.72 cp.
OutlineTransparency=0.05 cp.Adornee=cn cp.Parent=cn k.ESP[cn]=cp end cp.
FillColor=co cp.OutlineColor=co end function k.UpdateESP()if not k.Config.
AnomalyESP then k.ClearESP()return end if k.LastESPUpdate and os.clock()-k.
LastESPUpdate<0.25 then return end k.LastESPUpdate=os.clock()local cn={}local co
=c:FindFirstChild('NPCs')if co then for cp,cq in ipairs(co:GetChildren())do if
cq:IsA('Model')and(X(cq)or r.isAnomalyModel(cq))then local cr if r.
isAnomalyModel(cq)then cr=Color3.fromRGB(255,60,60)elseif d:HasTag(cq,
'EmergencyEventCounter')then cr=Color3.fromRGB(255,170,30)else cr=Color3.
fromRGB(60,255,130)end cn[cq]=true k.SetESP(cq,cr)end end end for cp,cq in
ipairs(bZ(true))do local cr=cq:IsA('Model')and cq or r.nearestModelAncestor(cq)
or cq if cr and cr:IsDescendantOf(c)then cn[cr]=true k.SetESP(cr,Color3.fromRGB(
255,60,60))end end for cp,cq in pairs(k.ESP)do if not cn[cp]or not cp:
IsDescendantOf(c)then pcall(function()cq:Destroy()end)k.ESP[cp]=nil end end end
function k.ConfigurePromptWatchers()for cn,co in ipairs(c:GetDescendants())do if
co:IsA('ProximityPrompt')then k.PromptCache[co]=true if k.Config.
InstantProximityPrompts then E(co)end end end s(c.DescendantAdded:Connect(
function(cn)if cn:IsA('ProximityPrompt')then k.PromptCache[cn]=true if k.Config.
InstantProximityPrompts then task.defer(E,cn)end end end))s(c.DescendantRemoving
:Connect(function(cn)if k.PromptCache[cn]then k.PromptCache[cn]=nil end end))end
function k.CreateGui()local cn=(function()local function cn()local co={}co.
ironiteion=Instance.new('ScreenGui')co.PatchHub.Name='PatchHub.'co.PatchHub.
ZIndexBehavior=Enum.ZIndexBehavior.Sibling co.mainFrame=Instance.new(
'CanvasGroup')co.mainFrame.Name='MainFrame'co.mainFrame.AnchorPoint=Vector2.new(
0.5,0.5)co.mainFrame.BackgroundColor3=Color3.fromRGB(19,20,25)co.mainFrame.
ClipsDescendants=true co.mainFrame.Position=UDim2.fromScale(0.5,0.5)co.mainFrame
.Size=UDim2.fromOffset(695,489)co.uICorner=Instance.new('UICorner')co.uICorner.
Name='UICorner'co.uICorner.CornerRadius=UDim.new(0,11)co.uICorner.Parent=co.
mainFrame co.header=Instance.new('Frame')co.header.Name='Header'co.header.
AnchorPoint=Vector2.new(0.5,0)co.header.BackgroundTransparency=1 co.header.
Position=UDim2.fromScale(0.5,0)co.header.Size=UDim2.fromOffset(695,37)co.liner=
Instance.new('Frame')co.liner.Name='Liner'co.liner.AnchorPoint=Vector2.new(0,1)
co.liner.BackgroundColor3=Color3.fromRGB(31,31,45)co.liner.BorderColor3=Color3.
new()co.liner.BorderSizePixel=0 co.liner.Position=UDim2.fromScale(0,1)co.liner.
Size=UDim2.new(1,1,0,2)co.liner.Parent=co.header co.libaryIcon=Instance.new(
'ImageLabel')co.libaryIcon.Name='LibaryIcon'co.libaryIcon.AnchorPoint=Vector2.
new(0,0.5)co.libaryIcon.BackgroundTransparency=1 co.libaryIcon.Image=
'rbxassetid://108488788823423'co.libaryIcon.Position=UDim2.new(0,12,0.5,0)co.
libaryIcon.ScaleType=Enum.ScaleType.Fit co.libaryIcon.Size=UDim2.fromOffset(20,
20)co.libaryName=Instance.new('TextLabel')co.libaryName.Name='Libary_Name'co.
libaryName.AnchorPoint=Vector2.new(0,0.5)co.libaryName.AutomaticSize=Enum.
AutomaticSize.XY co.libaryName.BackgroundTransparency=1 co.libaryName.FontFace=
Font.new('rbxassetid://12187365364',Enum.FontWeight.Medium,Enum.FontStyle.Normal
)co.libaryName.Position=UDim2.new(0,32,0.5,0)co.libaryName.RichText=true co.
libaryName.Size=UDim2.fromOffset(1,1)co.libaryName.Text='Patch Hub'co.libaryName
.TextColor3=Color3.new(1,1,1)co.libaryName.TextSize=14 co.libaryName.Parent=co.
libaryIcon co.libaryIcon.Parent=co.header co.lastUpdated=Instance.new(
'TextLabel')co.lastUpdated.Name='Last_Updated'co.lastUpdated.AnchorPoint=Vector2
.new(1,0.5)co.lastUpdated.AutomaticSize=Enum.AutomaticSize.XY co.lastUpdated.
BackgroundTransparency=1 co.lastUpdated.FontFace=Font.new(
'rbxassetid://12187365364')co.lastUpdated.Position=UDim2.new(1,-12,0.5,0)co.
lastUpdated.RichText=true co.lastUpdated.Size=UDim2.fromOffset(1,1)co.
lastUpdated.Text='UI Library'co.lastUpdated.TextColor3=Color3.new(1,1,1)co.
lastUpdated.TextSize=12 co.icon=Instance.new('ImageLabel')co.icon.Name='Icon'co.
icon.AnchorPoint=Vector2.new(0,0.5)co.icon.BackgroundTransparency=1 co.icon.
Image='rbxassetid://84304363968016'co.icon.Position=UDim2.new(0,-22,0.5,0)co.
icon.Size=UDim2.fromOffset(15,15)co.icon.Parent=co.lastUpdated co.lastUpdated.
Parent=co.header co.header.Parent=co.mainFrame co.sidebar=Instance.new('Frame')
co.sidebar.Name='Sidebar'co.sidebar.AnchorPoint=Vector2.new(0,1)co.sidebar.
BackgroundTransparency=1 co.sidebar.Position=UDim2.fromScale(0,1)co.sidebar.Size
=UDim2.fromOffset(75,453)co.liner1=Instance.new('Frame')co.liner1.Name='Liner'co
.liner1.AnchorPoint=Vector2.new(1,0.5)co.liner1.BackgroundColor3=Color3.fromRGB(
31,31,45)co.liner1.BorderColor3=Color3.new()co.liner1.BorderSizePixel=0 co.
liner1.Position=UDim2.fromScale(1,0.5)co.liner1.Size=UDim2.new(0,2,1,0)co.liner1
.Parent=co.sidebar co.holder=Instance.new('Frame')co.holder.Name='Holder'co.
holder.AnchorPoint=Vector2.new(0.5,0.5)co.holder.BackgroundTransparency=1 co.
holder.Position=UDim2.fromScale(0.5,0.5)co.holder.Size=UDim2.fromOffset(75,453)
co.tab=Instance.new('Frame')co.tab.Name='Tab'co.tab.BackgroundColor3=Color3.
fromRGB(247,247,247)co.tab.BackgroundTransparency=0.9 co.tab.ClipsDescendants=
true co.tab.Size=UDim2.fromOffset(55,60)co.uICorner1=Instance.new('UICorner')co.
uICorner1.Name='UICorner'co.uICorner1.CornerRadius=UDim.new(0,5)co.uICorner1.
Parent=co.tab co.frame=Instance.new('Frame')co.frame.Name='Frame'co.frame.
AnchorPoint=Vector2.new(0.5,1)co.frame.BackgroundColor3=Color3.fromRGB(254,254,
254)co.frame.Position=UDim2.new(0.5,0,1,3)co.frame.Size=UDim2.fromOffset(25,6)co
.uICorner2=Instance.new('UICorner')co.uICorner2.Name='UICorner'co.uICorner2.
CornerRadius=UDim.new(0,12)co.uICorner2.Parent=co.frame co.uIGradient=Instance.
new('UIGradient')co.uIGradient.Name='UIGradient'co.uIGradient.Color=
ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient.Parent=
co.frame co.frame.Parent=co.tab co.icon1=Instance.new('ImageLabel')co.icon1.Name
='Icon'co.icon1.AnchorPoint=Vector2.new(0.5,0.5)co.icon1.BackgroundTransparency=
1 co.icon1.Image='rbxassetid://80869096876893'co.icon1.Position=UDim2.new(0.5,0,
0.5,-8)co.icon1.Size=UDim2.fromOffset(24,22)co.textLabel=Instance.new(
'TextLabel')co.textLabel.Name='TextLabel'co.textLabel.AnchorPoint=Vector2.new(
0.5,0.5)co.textLabel.AutomaticSize=Enum.AutomaticSize.XY co.textLabel.
BackgroundTransparency=1 co.textLabel.FontFace=Font.new(
'rbxassetid://12187365364',Enum.FontWeight.Bold,Enum.FontStyle.Normal)co.
textLabel.Position=UDim2.new(0.5,0,0.5,20)co.textLabel.Size=UDim2.new(1,1,1,1)co
.textLabel.Text='Main'co.textLabel.TextColor3=Color3.new(1,1,1)co.textLabel.
TextSize=12 co.textLabel.Parent=co.icon1 co.icon1.Parent=co.tab co.uIGradient1=
Instance.new('UIGradient')co.uIGradient1.Name='UIGradient'co.uIGradient1.Color=
ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient1.Parent=
co.tab co.tab.Parent=co.holder co.uIListLayout=Instance.new('UIListLayout')co.
uIListLayout.Name='UIListLayout'co.uIListLayout.Padding=UDim.new(0,5)co.
uIListLayout.SortOrder=Enum.SortOrder.LayoutOrder co.uIListLayout.Parent=co.
holder co.uIPadding=Instance.new('UIPadding')co.uIPadding.Name='UIPadding'co.
uIPadding.PaddingLeft=UDim.new(0,9)co.uIPadding.PaddingTop=UDim.new(0,10)co.
uIPadding.Parent=co.holder co.divider=Instance.new('Frame')co.divider.Name=
'Divider'co.divider.BackgroundTransparency=1 co.divider.ClipsDescendants=true co
.divider.Position=UDim2.fromScale(0,0.988713)co.divider.Size=UDim2.fromOffset(55
,5)co.uICorner3=Instance.new('UICorner')co.uICorner3.Name='UICorner'co.uICorner3
.CornerRadius=UDim.new(0,5)co.uICorner3.Parent=co.divider co.divider.Parent=co.
holder co.tab1=Instance.new('Frame')co.tab1.Name='Tab'co.tab1.
BackgroundTransparency=1 co.tab1.ClipsDescendants=true co.tab1.Size=UDim2.
fromOffset(55,60)co.uICorner4=Instance.new('UICorner')co.uICorner4.Name=
'UICorner'co.uICorner4.CornerRadius=UDim.new(0,5)co.uICorner4.Parent=co.tab1 co.
icon2=Instance.new('ImageLabel')co.icon2.Name='Icon'co.icon2.AnchorPoint=Vector2
.new(0.5,0.5)co.icon2.BackgroundTransparency=1 co.icon2.Image=
'rbxassetid://88848642017283'co.icon2.ImageColor3=Color3.fromRGB(69,71,90)co.
icon2.Position=UDim2.new(0.5,0,0.5,-8)co.icon2.Size=UDim2.fromOffset(24,22)co.
textLabel1=Instance.new('TextLabel')co.textLabel1.Name='TextLabel'co.textLabel1.
AnchorPoint=Vector2.new(0.5,0.5)co.textLabel1.AutomaticSize=Enum.AutomaticSize.
XY co.textLabel1.BackgroundTransparency=1 co.textLabel1.FontFace=Font.new(
'rbxassetid://12187365364',Enum.FontWeight.Bold,Enum.FontStyle.Normal)co.
textLabel1.Position=UDim2.new(0.5,0,0.5,20)co.textLabel1.Size=UDim2.new(1,1,1,1)
co.textLabel1.Text='Visuals'co.textLabel1.TextColor3=Color3.fromRGB(69,71,90)co.
textLabel1.TextSize=12 co.textLabel1.Parent=co.icon2 co.icon2.Parent=co.tab1 co.
tab1.Parent=co.holder co.divider1=Instance.new('Frame')co.divider1.Name=
'Divider'co.divider1.BackgroundTransparency=1 co.divider1.ClipsDescendants=true
co.divider1.Position=UDim2.fromScale(0,0.988713)co.divider1.Size=UDim2.
fromOffset(55,5)co.uICorner5=Instance.new('UICorner')co.uICorner5.Name=
'UICorner'co.uICorner5.CornerRadius=UDim.new(0,5)co.uICorner5.Parent=co.divider1
co.frame1=Instance.new('Frame')co.frame1.Name='Frame'co.frame1.AnchorPoint=
Vector2.new(0.5,1)co.frame1.BackgroundColor3=Color3.fromRGB(31,31,45)co.frame1.
Position=UDim2.new(0.5,0,1,3)co.frame1.Size=UDim2.fromOffset(25,6)co.uICorner6=
Instance.new('UICorner')co.uICorner6.Name='UICorner'co.uICorner6.CornerRadius=
UDim.new(0,12)co.uICorner6.Parent=co.frame1 co.frame1.Parent=co.divider1 co.
divider1.Parent=co.holder co.tab2=Instance.new('Frame')co.tab2.Name='Tab'co.tab2
.BackgroundTransparency=1 co.tab2.ClipsDescendants=true co.tab2.Size=UDim2.
fromOffset(55,60)co.uICorner7=Instance.new('UICorner')co.uICorner7.Name=
'UICorner'co.uICorner7.CornerRadius=UDim.new(0,5)co.uICorner7.Parent=co.tab2 co.
icon3=Instance.new('ImageLabel')co.icon3.Name='Icon'co.icon3.AnchorPoint=Vector2
.new(0.5,0.5)co.icon3.BackgroundTransparency=1 co.icon3.Image=
'rbxassetid://83371760923777'co.icon3.ImageColor3=Color3.fromRGB(69,71,90)co.
icon3.Position=UDim2.new(0.5,0,0.5,-8)co.icon3.Size=UDim2.fromOffset(24,22)co.
textLabel2=Instance.new('TextLabel')co.textLabel2.Name='TextLabel'co.textLabel2.
AnchorPoint=Vector2.new(0.5,0.5)co.textLabel2.AutomaticSize=Enum.AutomaticSize.
XY co.textLabel2.BackgroundTransparency=1 co.textLabel2.FontFace=Font.new(
'rbxassetid://12187365364',Enum.FontWeight.Bold,Enum.FontStyle.Normal)co.
textLabel2.Position=UDim2.new(0.5,0,0.5,20)co.textLabel2.Size=UDim2.new(1,1,1,1)
co.textLabel2.Text='Rage'co.textLabel2.TextColor3=Color3.fromRGB(69,71,90)co.
textLabel2.TextSize=12 co.textLabel2.Parent=co.icon3 co.icon3.Parent=co.tab2 co.
tab2.Parent=co.holder co.divider2=Instance.new('Frame')co.divider2.Name=
'Divider'co.divider2.BackgroundTransparency=1 co.divider2.ClipsDescendants=true
co.divider2.Position=UDim2.fromScale(0,0.988713)co.divider2.Size=UDim2.
fromOffset(55,5)co.uICorner8=Instance.new('UICorner')co.uICorner8.Name=
'UICorner'co.uICorner8.CornerRadius=UDim.new(0,5)co.uICorner8.Parent=co.divider2
co.frame2=Instance.new('Frame')co.frame2.Name='Frame'co.frame2.AnchorPoint=
Vector2.new(0.5,1)co.frame2.BackgroundColor3=Color3.fromRGB(31,31,45)co.frame2.
Position=UDim2.new(0.5,0,1,3)co.frame2.Size=UDim2.fromOffset(25,6)co.uICorner9=
Instance.new('UICorner')co.uICorner9.Name='UICorner'co.uICorner9.CornerRadius=
UDim.new(0,12)co.uICorner9.Parent=co.frame2 co.frame2.Parent=co.divider2 co.
divider2.Parent=co.holder co.tab3=Instance.new('Frame')co.tab3.Name='Tab'co.tab3
.BackgroundTransparency=1 co.tab3.ClipsDescendants=true co.tab3.Size=UDim2.
fromOffset(55,60)co.uICorner10=Instance.new('UICorner')co.uICorner10.Name=
'UICorner'co.uICorner10.CornerRadius=UDim.new(0,5)co.uICorner10.Parent=co.tab3
co.icon4=Instance.new('ImageLabel')co.icon4.Name='Icon'co.icon4.AnchorPoint=
Vector2.new(0.5,0.5)co.icon4.BackgroundTransparency=1 co.icon4.Image=
'rbxassetid://107815780127396'co.icon4.ImageColor3=Color3.fromRGB(69,71,90)co.
icon4.Position=UDim2.new(0.5,0,0.5,-8)co.icon4.Size=UDim2.fromOffset(24,22)co.
textLabel3=Instance.new('TextLabel')co.textLabel3.Name='TextLabel'co.textLabel3.
AnchorPoint=Vector2.new(0.5,0.5)co.textLabel3.AutomaticSize=Enum.AutomaticSize.
XY co.textLabel3.BackgroundTransparency=1 co.textLabel3.FontFace=Font.new(
'rbxassetid://12187365364',Enum.FontWeight.Bold,Enum.FontStyle.Normal)co.
textLabel3.Position=UDim2.new(0.5,0,0.5,20)co.textLabel3.Size=UDim2.new(1,1,1,1)
co.textLabel3.Text='World'co.textLabel3.TextColor3=Color3.fromRGB(69,71,90)co.
textLabel3.TextSize=12 co.textLabel3.Parent=co.icon4 co.icon4.Parent=co.tab3 co.
tab3.Parent=co.holder co.divider3=Instance.new('Frame')co.divider3.Name=
'Divider'co.divider3.BackgroundTransparency=1 co.divider3.ClipsDescendants=true
co.divider3.Position=UDim2.fromScale(0,0.988713)co.divider3.Size=UDim2.
fromOffset(55,5)co.uICorner11=Instance.new('UICorner')co.uICorner11.Name=
'UICorner'co.uICorner11.CornerRadius=UDim.new(0,5)co.uICorner11.Parent=co.
divider3 co.frame3=Instance.new('Frame')co.frame3.Name='Frame'co.frame3.
AnchorPoint=Vector2.new(0.5,1)co.frame3.BackgroundColor3=Color3.fromRGB(31,31,45
)co.frame3.Position=UDim2.new(0.5,0,1,3)co.frame3.Size=UDim2.fromOffset(25,6)co.
uICorner12=Instance.new('UICorner')co.uICorner12.Name='UICorner'co.uICorner12.
CornerRadius=UDim.new(0,12)co.uICorner12.Parent=co.frame3 co.frame3.Parent=co.
divider3 co.divider3.Parent=co.holder co.tab4=Instance.new('Frame')co.tab4.Name=
'Tab'co.tab4.BackgroundTransparency=1 co.tab4.ClipsDescendants=true co.tab4.Size
=UDim2.fromOffset(55,60)co.uICorner13=Instance.new('UICorner')co.uICorner13.Name
='UICorner'co.uICorner13.CornerRadius=UDim.new(0,5)co.uICorner13.Parent=co.tab4
co.icon5=Instance.new('ImageLabel')co.icon5.Name='Icon'co.icon5.AnchorPoint=
Vector2.new(0.5,0.5)co.icon5.BackgroundTransparency=1 co.icon5.Image=
'rbxassetid://93827853548653'co.icon5.ImageColor3=Color3.fromRGB(69,71,90)co.
icon5.Position=UDim2.new(0.5,0,0.5,-8)co.icon5.Size=UDim2.fromOffset(24,22)co.
textLabel4=Instance.new('TextLabel')co.textLabel4.Name='TextLabel'co.textLabel4.
AnchorPoint=Vector2.new(0.5,0.5)co.textLabel4.AutomaticSize=Enum.AutomaticSize.
XY co.textLabel4.BackgroundTransparency=1 co.textLabel4.FontFace=Font.new(
'rbxassetid://12187365364',Enum.FontWeight.Bold,Enum.FontStyle.Normal)co.
textLabel4.Position=UDim2.new(0.5,0,0.5,20)co.textLabel4.Size=UDim2.new(1,1,1,1)
co.textLabel4.Text='Exploits'co.textLabel4.TextColor3=Color3.fromRGB(69,71,90)co
.textLabel4.TextSize=12 co.textLabel4.Parent=co.icon5 co.icon5.Parent=co.tab4 co
.tab4.Parent=co.holder co.divider4=Instance.new('Frame')co.divider4.Name=
'Divider'co.divider4.BackgroundTransparency=1 co.divider4.ClipsDescendants=true
co.divider4.Position=UDim2.fromScale(0,0.988713)co.divider4.Size=UDim2.
fromOffset(55,5)co.uICorner14=Instance.new('UICorner')co.uICorner14.Name=
'UICorner'co.uICorner14.CornerRadius=UDim.new(0,5)co.uICorner14.Parent=co.
divider4 co.frame4=Instance.new('Frame')co.frame4.Name='Frame'co.frame4.
AnchorPoint=Vector2.new(0.5,1)co.frame4.BackgroundColor3=Color3.fromRGB(31,31,45
)co.frame4.Position=UDim2.new(0.5,0,1,3)co.frame4.Size=UDim2.fromOffset(25,6)co.
uICorner15=Instance.new('UICorner')co.uICorner15.Name='UICorner'co.uICorner15.
CornerRadius=UDim.new(0,12)co.uICorner15.Parent=co.frame4 co.frame4.Parent=co.
divider4 co.divider4.Parent=co.holder co.tab5=Instance.new('Frame')co.tab5.Name=
'Tab'co.tab5.BackgroundTransparency=1 co.tab5.ClipsDescendants=true co.tab5.Size
=UDim2.fromOffset(55,60)co.uICorner16=Instance.new('UICorner')co.uICorner16.Name
='UICorner'co.uICorner16.CornerRadius=UDim.new(0,5)co.uICorner16.Parent=co.tab5
co.icon6=Instance.new('ImageLabel')co.icon6.Name='Icon'co.icon6.AnchorPoint=
Vector2.new(0.5,0.5)co.icon6.BackgroundTransparency=1 co.icon6.Image=
'rbxassetid://128822529527725'co.icon6.ImageColor3=Color3.fromRGB(69,71,90)co.
icon6.Position=UDim2.new(0.5,0,0.5,-8)co.icon6.Size=UDim2.fromOffset(24,22)co.
textLabel5=Instance.new('TextLabel')co.textLabel5.Name='TextLabel'co.textLabel5.
AnchorPoint=Vector2.new(0.5,0.5)co.textLabel5.AutomaticSize=Enum.AutomaticSize.
XY co.textLabel5.BackgroundTransparency=1 co.textLabel5.FontFace=Font.new(
'rbxassetid://12187365364',Enum.FontWeight.Bold,Enum.FontStyle.Normal)co.
textLabel5.Position=UDim2.new(0.5,0,0.5,20)co.textLabel5.Size=UDim2.new(1,1,1,1)
co.textLabel5.Text='Settings'co.textLabel5.TextColor3=Color3.fromRGB(69,71,90)co
.textLabel5.TextSize=12 co.textLabel5.Parent=co.icon6 co.icon6.Parent=co.tab5 co
.tab5.Parent=co.holder co.holder.Parent=co.sidebar co.sidebar.Parent=co.
mainFrame co.subHeader=Instance.new('Frame')co.subHeader.Name='Sub-Header'co.
subHeader.AnchorPoint=Vector2.new(0.5,0.5)co.subHeader.BackgroundTransparency=1
co.subHeader.Position=UDim2.fromScale(0.554676,0.127812)co.subHeader.Size=UDim2.
fromOffset(621,51)co.subTab=Instance.new('Frame')co.subTab.Name='SubTab'co.
subTab.AutomaticSize=Enum.AutomaticSize.X co.subTab.BackgroundTransparency=1 co.
subTab.Position=UDim2.fromScale(0,0.0392157)co.subTab.Size=UDim2.fromOffset(80,
49)co.tabName=Instance.new('TextLabel')co.tabName.Name='TabName'co.tabName.
AnchorPoint=Vector2.new(0.5,0.5)co.tabName.AutomaticSize=Enum.AutomaticSize.XY
co.tabName.BackgroundColor3=Color3.fromRGB(254,254,254)co.tabName.
BackgroundTransparency=0.8 co.tabName.FontFace=Font.new(
'rbxassetid://12187365364',Enum.FontWeight.Medium,Enum.FontStyle.Normal)co.
tabName.Position=UDim2.new(0.5,0,0.5,-3)co.tabName.Size=UDim2.fromOffset(1,1)co.
tabName.Text='ActiveSubTab1'co.tabName.TextColor3=Color3.fromRGB(254,254,254)co.
tabName.TextSize=13 co.uIPadding1=Instance.new('UIPadding')co.uIPadding1.Name=
'UIPadding'co.uIPadding1.PaddingBottom=UDim.new(0,10)co.uIPadding1.PaddingLeft=
UDim.new(0,8)co.uIPadding1.PaddingRight=UDim.new(0,8)co.uIPadding1.PaddingTop=
UDim.new(0,10)co.uIPadding1.Parent=co.tabName co.uICorner17=Instance.new(
'UICorner')co.uICorner17.Name='UICorner'co.uICorner17.CornerRadius=UDim.new(0,4)
co.uICorner17.Parent=co.tabName co.uIGradient2=Instance.new('UIGradient')co.
uIGradient2.Name='UIGradient'co.uIGradient2.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),ColorSequenceKeypoint.
new(1,Color3.fromRGB(147,147,147))})co.uIGradient2.Parent=co.tabName co.tabName.
Parent=co.subTab co.holder1=Instance.new('Frame')co.holder1.Name='Holder'co.
holder1.AnchorPoint=Vector2.new(0.5,1)co.holder1.BackgroundColor3=Color3.
fromRGB(254,254,254)co.holder1.Position=UDim2.new(0.5,0,1,2)co.holder1.Size=
UDim2.fromOffset(34,6)co.uICorner18=Instance.new('UICorner')co.uICorner18.Name=
'UICorner'co.uICorner18.CornerRadius=UDim.new(0,12)co.uICorner18.Parent=co.
holder1 co.uIGradient3=Instance.new('UIGradient')co.uIGradient3.Name=
'UIGradient'co.uIGradient3.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,
Color3.fromRGB(254,254,254)),ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,
147))})co.uIGradient3.Parent=co.holder1 co.holder1.Parent=co.subTab co.subTab.
Parent=co.subHeader co.uIListLayout1=Instance.new('UIListLayout')co.
uIListLayout1.Name='UIListLayout'co.uIListLayout1.FillDirection=Enum.
FillDirection.Horizontal co.uIListLayout1.Padding=UDim.new(0,8)co.uIListLayout1.
SortOrder=Enum.SortOrder.LayoutOrder co.uIListLayout1.Parent=co.subHeader co.
uIPadding2=Instance.new('UIPadding')co.uIPadding2.Name='UIPadding'co.uIPadding2.
PaddingLeft=UDim.new(0,25)co.uIPadding2.PaddingTop=UDim.new(0,4)co.uIPadding2.
Parent=co.subHeader co.subTab1=Instance.new('Frame')co.subTab1.Name='SubTab'co.
subTab1.AutomaticSize=Enum.AutomaticSize.X co.subTab1.BackgroundTransparency=1
co.subTab1.Position=UDim2.fromScale(0,0.0392157)co.subTab1.Size=UDim2.
fromOffset(80,49)co.tabName1=Instance.new('TextLabel')co.tabName1.Name='TabName'
co.tabName1.AnchorPoint=Vector2.new(0.5,0.5)co.tabName1.AutomaticSize=Enum.
AutomaticSize.XY co.tabName1.BackgroundTransparency=1 co.tabName1.FontFace=Font.
new('rbxassetid://12187365364')co.tabName1.Position=UDim2.new(0.5,0,0.5,-3)co.
tabName1.Size=UDim2.fromOffset(1,1)co.tabName1.Text='SubTab2'co.tabName1.
TextColor3=Color3.fromRGB(69,71,90)co.tabName1.TextSize=13 co.tabName1.
TextTransparency=0.15 co.uICorner19=Instance.new('UICorner')co.uICorner19.Name=
'UICorner'co.uICorner19.CornerRadius=UDim.new(0,4)co.uICorner19.Parent=co.
tabName1 co.uIPadding3=Instance.new('UIPadding')co.uIPadding3.Name='UIPadding'co
.uIPadding3.PaddingBottom=UDim.new(0,10)co.uIPadding3.PaddingLeft=UDim.new(0,8)
co.uIPadding3.PaddingRight=UDim.new(0,8)co.uIPadding3.PaddingTop=UDim.new(0,10)
co.uIPadding3.Parent=co.tabName1 co.tabName1.Parent=co.subTab1 co.subTab1.Parent
=co.subHeader co.subTab2=Instance.new('Frame')co.subTab2.Name='SubTab'co.subTab2
.AutomaticSize=Enum.AutomaticSize.X co.subTab2.BackgroundTransparency=1 co.
subTab2.Position=UDim2.fromScale(0,0.0392157)co.subTab2.Size=UDim2.fromOffset(80
,49)co.tabName2=Instance.new('TextLabel')co.tabName2.Name='TabName'co.tabName2.
AnchorPoint=Vector2.new(0.5,0.5)co.tabName2.AutomaticSize=Enum.AutomaticSize.XY
co.tabName2.BackgroundTransparency=1 co.tabName2.FontFace=Font.new(
'rbxassetid://12187365364')co.tabName2.Position=UDim2.new(0.5,0,0.5,-3)co.
tabName2.Size=UDim2.fromOffset(1,1)co.tabName2.Text='SubTab2'co.tabName2.
TextColor3=Color3.fromRGB(69,71,90)co.tabName2.TextSize=13 co.tabName2.
TextTransparency=0.15 co.uICorner20=Instance.new('UICorner')co.uICorner20.Name=
'UICorner'co.uICorner20.CornerRadius=UDim.new(0,4)co.uICorner20.Parent=co.
tabName2 co.uIPadding4=Instance.new('UIPadding')co.uIPadding4.Name='UIPadding'co
.uIPadding4.PaddingBottom=UDim.new(0,10)co.uIPadding4.PaddingLeft=UDim.new(0,8)
co.uIPadding4.PaddingRight=UDim.new(0,8)co.uIPadding4.PaddingTop=UDim.new(0,10)
co.uIPadding4.Parent=co.tabName2 co.tabName2.Parent=co.subTab2 co.subTab2.Parent
=co.subHeader co.subTab3=Instance.new('Frame')co.subTab3.Name='SubTab'co.subTab3
.AutomaticSize=Enum.AutomaticSize.X co.subTab3.BackgroundTransparency=1 co.
subTab3.Position=UDim2.fromScale(0,0.0392157)co.subTab3.Size=UDim2.fromOffset(80
,49)co.tabName3=Instance.new('TextLabel')co.tabName3.Name='TabName'co.tabName3.
AnchorPoint=Vector2.new(0.5,0.5)co.tabName3.AutomaticSize=Enum.AutomaticSize.XY
co.tabName3.BackgroundTransparency=1 co.tabName3.FontFace=Font.new(
'rbxassetid://12187365364')co.tabName3.Position=UDim2.new(0.5,0,0.5,-3)co.
tabName3.Size=UDim2.fromOffset(1,1)co.tabName3.Text='SubTab2'co.tabName3.
TextColor3=Color3.fromRGB(69,71,90)co.tabName3.TextSize=13 co.tabName3.
TextTransparency=0.15 co.uICorner21=Instance.new('UICorner')co.uICorner21.Name=
'UICorner'co.uICorner21.CornerRadius=UDim.new(0,4)co.uICorner21.Parent=co.
tabName3 co.uIPadding5=Instance.new('UIPadding')co.uIPadding5.Name='UIPadding'co
.uIPadding5.PaddingBottom=UDim.new(0,10)co.uIPadding5.PaddingLeft=UDim.new(0,8)
co.uIPadding5.PaddingRight=UDim.new(0,8)co.uIPadding5.PaddingTop=UDim.new(0,10)
co.uIPadding5.Parent=co.tabName3 co.tabName3.Parent=co.subTab3 co.subTab3.Parent
=co.subHeader co.subTab4=Instance.new('Frame')co.subTab4.Name='SubTab'co.subTab4
.AutomaticSize=Enum.AutomaticSize.X co.subTab4.BackgroundTransparency=1 co.
subTab4.Position=UDim2.fromScale(0,0.0392157)co.subTab4.Size=UDim2.fromOffset(80
,49)co.tabName4=Instance.new('TextLabel')co.tabName4.Name='TabName'co.tabName4.
AnchorPoint=Vector2.new(0.5,0.5)co.tabName4.AutomaticSize=Enum.AutomaticSize.XY
co.tabName4.BackgroundTransparency=1 co.tabName4.FontFace=Font.new(
'rbxassetid://12187365364')co.tabName4.Position=UDim2.new(0.5,0,0.5,-3)co.
tabName4.Size=UDim2.fromOffset(1,1)co.tabName4.Text='SubTab2'co.tabName4.
TextColor3=Color3.fromRGB(69,71,90)co.tabName4.TextSize=13 co.tabName4.
TextTransparency=0.15 co.uICorner22=Instance.new('UICorner')co.uICorner22.Name=
'UICorner'co.uICorner22.CornerRadius=UDim.new(0,4)co.uICorner22.Parent=co.
tabName4 co.uIPadding6=Instance.new('UIPadding')co.uIPadding6.Name='UIPadding'co
.uIPadding6.PaddingBottom=UDim.new(0,10)co.uIPadding6.PaddingLeft=UDim.new(0,8)
co.uIPadding6.PaddingRight=UDim.new(0,8)co.uIPadding6.PaddingTop=UDim.new(0,10)
co.uIPadding6.Parent=co.tabName4 co.tabName4.Parent=co.subTab4 co.subTab4.Parent
=co.subHeader co.subTab5=Instance.new('Frame')co.subTab5.Name='SubTab'co.subTab5
.AutomaticSize=Enum.AutomaticSize.X co.subTab5.BackgroundTransparency=1 co.
subTab5.Position=UDim2.fromScale(0,0.0392157)co.subTab5.Size=UDim2.fromOffset(80
,49)co.tabName5=Instance.new('TextLabel')co.tabName5.Name='TabName'co.tabName5.
AnchorPoint=Vector2.new(0.5,0.5)co.tabName5.AutomaticSize=Enum.AutomaticSize.XY
co.tabName5.BackgroundTransparency=1 co.tabName5.FontFace=Font.new(
'rbxassetid://12187365364')co.tabName5.Position=UDim2.new(0.5,0,0.5,-3)co.
tabName5.Size=UDim2.fromOffset(1,1)co.tabName5.Text='SubTab2'co.tabName5.
TextColor3=Color3.fromRGB(69,71,90)co.tabName5.TextSize=13 co.tabName5.
TextTransparency=0.15 co.uICorner23=Instance.new('UICorner')co.uICorner23.Name=
'UICorner'co.uICorner23.CornerRadius=UDim.new(0,4)co.uICorner23.Parent=co.
tabName5 co.uIPadding7=Instance.new('UIPadding')co.uIPadding7.Name='UIPadding'co
.uIPadding7.PaddingBottom=UDim.new(0,10)co.uIPadding7.PaddingLeft=UDim.new(0,8)
co.uIPadding7.PaddingRight=UDim.new(0,8)co.uIPadding7.PaddingTop=UDim.new(0,10)
co.uIPadding7.Parent=co.tabName5 co.tabName5.Parent=co.subTab5 co.subTab5.Parent
=co.subHeader co.subHeader.Parent=co.mainFrame co.page=Instance.new('Frame')co.
page.Name='Page'co.page.AnchorPoint=Vector2.new(1,1)co.page.BackgroundColor3=
Color3.fromRGB(16,17,21)co.page.ClipsDescendants=true co.page.Position=UDim2.
fromScale(1,1)co.page.Size=UDim2.fromOffset(620,401)co.uICorner24=Instance.new(
'UICorner')co.uICorner24.Name='UICorner'co.uICorner24.CornerRadius=UDim.new(0,11
)co.uICorner24.Parent=co.page co.container=Instance.new('ScrollingFrame')co.
container.Name='Container'co.container.Active=true co.container.AnchorPoint=
Vector2.new(0.5,0.5)co.container.BackgroundTransparency=1 co.container.Position=
UDim2.fromScale(0.5,0.5)co.container.ScrollBarImageColor3=Color3.new()co.
container.ScrollBarThickness=1 co.container.Size=UDim2.fromOffset(620,401)co.
sectionLeft=Instance.new('Frame')co.sectionLeft.Name='Section_Left'co.
sectionLeft.AutomaticSize=Enum.AutomaticSize.Y co.sectionLeft.BackgroundColor3=
Color3.fromRGB(17,18,22)co.sectionLeft.ClipsDescendants=true co.sectionLeft.Size
=UDim2.fromOffset(281,60)co.header1=Instance.new('Frame')co.header1.Name=
'Header'co.header1.AnchorPoint=Vector2.new(0.5,0)co.header1.BackgroundColor3=
Color3.fromRGB(19,20,25)co.header1.Position=UDim2.fromScale(0.501786,0)co.
header1.Size=UDim2.fromOffset(281,30)co.holder2=Instance.new('Frame')co.holder2.
Name='Holder'co.holder2.AnchorPoint=Vector2.new(0.5,0)co.holder2.AutomaticSize=
Enum.AutomaticSize.XY co.holder2.BackgroundTransparency=1 co.holder2.Position=
UDim2.fromScale(0.5,1)co.holder2.Size=UDim2.fromOffset(1,1)co.uIListLayout2=
Instance.new('UIListLayout')co.uIListLayout2.Name='UIListLayout'co.uIListLayout2
.Padding=UDim.new(0,4)co.uIListLayout2.SortOrder=Enum.SortOrder.LayoutOrder co.
uIListLayout2.Parent=co.holder2 co.uIPadding8=Instance.new('UIPadding')co.
uIPadding8.Name='UIPadding'co.uIPadding8.PaddingBottom=UDim.new(0,45)co.
uIPadding8.PaddingTop=UDim.new(0,5)co.uIPadding8.Parent=co.holder2 co.
toggleComponent=Instance.new('Frame')co.toggleComponent.Name='Toggle_Component'
co.toggleComponent.AnchorPoint=Vector2.new(0.5,0)co.toggleComponent.
BackgroundTransparency=1 co.toggleComponent.Position=UDim2.fromScale(0.5,0)co.
toggleComponent.Size=UDim2.fromOffset(312,30)co.toggleName=Instance.new(
'TextLabel')co.toggleName.Name='Toggle_Name'co.toggleName.AnchorPoint=Vector2.
new(0,0.5)co.toggleName.AutomaticSize=Enum.AutomaticSize.XY co.toggleName.
BackgroundTransparency=1 co.toggleName.FontFace=Font.new(
'rbxassetid://12187365364')co.toggleName.Position=UDim2.new(0,48,0.5,0)co.
toggleName.Size=UDim2.fromOffset(1,1)co.toggleName.Text='Example Toggle'co.
toggleName.TextColor3=Color3.fromRGB(69,71,90)co.toggleName.TextSize=12 co.
toggleName.Parent=co.toggleComponent co.toggle=Instance.new('Frame')co.toggle.
Name='Toggle'co.toggle.AnchorPoint=Vector2.new(0,0.5)co.toggle.BackgroundColor3=
Color3.fromRGB(24,25,32)co.toggle.Position=UDim2.new(0,25,0.5,0)co.toggle.Size=
UDim2.fromOffset(14,14)co.uIStroke=Instance.new('UIStroke')co.uIStroke.Name=
'UIStroke'co.uIStroke.Color=Color3.fromRGB(28,30,38)co.uIStroke.Parent=co.toggle
co.uICorner25=Instance.new('UICorner')co.uICorner25.Name='UICorner'co.uICorner25
.CornerRadius=UDim.new(0,3)co.uICorner25.Parent=co.toggle co.toggle.Parent=co.
toggleComponent co.toggleComponent.Parent=co.holder2 co.toggleComponent1=
Instance.new('Frame')co.toggleComponent1.Name='Toggle_Component'co.
toggleComponent1.AnchorPoint=Vector2.new(0.5,0)co.toggleComponent1.
BackgroundTransparency=1 co.toggleComponent1.Position=UDim2.fromScale(0.5,0)co.
toggleComponent1.Size=UDim2.fromOffset(312,30)co.toggleName1=Instance.new(
'TextLabel')co.toggleName1.Name='Toggle_Name'co.toggleName1.AnchorPoint=Vector2.
new(0,0.5)co.toggleName1.AutomaticSize=Enum.AutomaticSize.XY co.toggleName1.
BackgroundTransparency=1 co.toggleName1.FontFace=Font.new(
'rbxassetid://12187365364')co.toggleName1.Position=UDim2.new(0,48,0.5,0)co.
toggleName1.Size=UDim2.fromOffset(1,1)co.toggleName1.Text='Example Toggle'co.
toggleName1.TextColor3=Color3.new(1,1,1)co.toggleName1.TextSize=12 co.
toggleName1.Parent=co.toggleComponent1 co.toggle1=Instance.new('Frame')co.
toggle1.Name='Toggle'co.toggle1.AnchorPoint=Vector2.new(0,0.5)co.toggle1.
BackgroundColor3=Color3.fromRGB(231,231,231)co.toggle1.Position=UDim2.new(0,25,
0.5,0)co.toggle1.Size=UDim2.fromOffset(14,14)co.checkIcon=Instance.new(
'ImageLabel')co.checkIcon.Name='Check_Icon'co.checkIcon.AnchorPoint=Vector2.new(
0.5,0.5)co.checkIcon.BackgroundTransparency=1 co.checkIcon.Image=
'rbxassetid://83899464799881'co.checkIcon.Position=UDim2.fromScale(0.5,0.5)co.
checkIcon.Size=UDim2.fromOffset(8,7)co.checkIcon.Parent=co.toggle1 co.uICorner26
=Instance.new('UICorner')co.uICorner26.Name='UICorner'co.uICorner26.CornerRadius
=UDim.new(0,3)co.uICorner26.Parent=co.toggle1 co.uIGradient4=Instance.new(
'UIGradient')co.uIGradient4.Name='UIGradient'co.uIGradient4.Color=ColorSequence.
new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient4.Parent=
co.toggle1 co.toggle1.Parent=co.toggleComponent1 co.colorFrame=Instance.new(
'Frame')co.colorFrame.Name='ColorFrame'co.colorFrame.AnchorPoint=Vector2.new(1,
0.5)co.colorFrame.BackgroundColor3=Color3.new(1,1,1)co.colorFrame.Position=UDim2
.fromScale(0.915,0.5)co.colorFrame.Size=UDim2.fromOffset(15,15)co.uICorner27=
Instance.new('UICorner')co.uICorner27.Name='UICorner'co.uICorner27.CornerRadius=
UDim.new(1,0)co.uICorner27.Parent=co.colorFrame co.colorFrame.Parent=co.
toggleComponent1 co.toggleComponent1.Parent=co.holder2 co.sliderComponent=
Instance.new('Frame')co.sliderComponent.Name='Slider_Component'co.
sliderComponent.Active=true co.sliderComponent.AnchorPoint=Vector2.new(0.5,0)co.
sliderComponent.BackgroundTransparency=1 co.sliderComponent.Position=UDim2.
fromScale(0.5,0.762195)co.sliderComponent.Size=UDim2.fromOffset(312,40)co.value=
Instance.new('TextLabel')co.value.Name='Value'co.value.AnchorPoint=Vector2.new(1
,0.5)co.value.AutomaticSize=Enum.AutomaticSize.XY co.value.
BackgroundTransparency=1 co.value.FontFace=Font.new('rbxassetid://12187365364')
co.value.Position=UDim2.new(1,-22,0.5,-8)co.value.Size=UDim2.fromOffset(1,1)co.
value.Text='100'co.value.TextColor3=Color3.new(1,1,1)co.value.TextSize=14 co.
value.Parent=co.sliderComponent co.sliderText=Instance.new('TextLabel')co.
sliderText.Name='Slider_Text'co.sliderText.AnchorPoint=Vector2.new(0,0.5)co.
sliderText.AutomaticSize=Enum.AutomaticSize.XY co.sliderText.
BackgroundTransparency=1 co.sliderText.FontFace=Font.new(
'rbxassetid://12187365364')co.sliderText.Position=UDim2.new(0,23,0.5,-8)co.
sliderText.Size=UDim2.fromOffset(1,1)co.sliderText.Text='Example Slider'co.
sliderText.TextColor3=Color3.fromRGB(69,71,90)co.sliderText.TextSize=14 co.
sliderText.Parent=co.sliderComponent co.progressBG=Instance.new('Frame')co.
progressBG.Name='Progress_BG'co.progressBG.AnchorPoint=Vector2.new(0,0.5)co.
progressBG.BackgroundColor3=Color3.fromRGB(24,25,32)co.progressBG.Position=UDim2
.new(0.0128205,19,0.53125,13)co.progressBG.Size=UDim2.fromOffset(266,4)co.
progress=Instance.new('Frame')co.progress.Name='Progress'co.progress.AnchorPoint
=Vector2.new(0,0.5)co.progress.BackgroundColor3=Color3.fromRGB(232,232,232)co.
progress.Position=UDim2.fromScale(0,0.5)co.progress.Size=UDim2.fromOffset(171,7)
co.pointer=Instance.new('Frame')co.pointer.Name='Pointer'co.pointer.AnchorPoint=
Vector2.new(1,0.5)co.pointer.BackgroundColor3=Color3.new(1,1,1)co.pointer.
Position=UDim2.fromScale(1,0.5)co.pointer.Size=UDim2.fromOffset(6,6)co.
uICorner28=Instance.new('UICorner')co.uICorner28.Name='UICorner'co.uICorner28.
Parent=co.pointer co.design=Instance.new('Frame')co.design.Name='Design'co.
design.AnchorPoint=Vector2.new(0.5,0.5)co.design.BackgroundColor3=Color3.new(1,1
,1)co.design.BackgroundTransparency=0.5 co.design.Position=UDim2.fromScale(0.5,
0.5)co.design.Size=UDim2.fromOffset(14,14)co.uICorner29=Instance.new('UICorner')
co.uICorner29.Name='UICorner'co.uICorner29.Parent=co.design co.design.Parent=co.
pointer co.pointer.Parent=co.progress co.uICorner30=Instance.new('UICorner')co.
uICorner30.Name='UICorner'co.uICorner30.Parent=co.progress co.uIGradient5=
Instance.new('UIGradient')co.uIGradient5.Name='UIGradient'co.uIGradient5.Color=
ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient5.Parent=
co.progress co.progress.Parent=co.progressBG co.uIStroke1=Instance.new(
'UIStroke')co.uIStroke1.Name='UIStroke'co.uIStroke1.Color=Color3.fromRGB(28,30,
38)co.uIStroke1.Parent=co.progressBG co.uICorner31=Instance.new('UICorner')co.
uICorner31.Name='UICorner'co.uICorner31.Parent=co.progressBG co.progressBG.
Parent=co.sliderComponent co.sliderComponent.Parent=co.holder2 co.
keybindComponent=Instance.new('Frame')co.keybindComponent.Name=
'Keybind_Component'co.keybindComponent.AnchorPoint=Vector2.new(0.5,0)co.
keybindComponent.BackgroundTransparency=1 co.keybindComponent.Position=UDim2.
fromScale(0.5,0.71885)co.keybindComponent.Size=UDim2.fromOffset(312,50)co.
toggleName2=Instance.new('TextLabel')co.toggleName2.Name='Toggle_Name'co.
toggleName2.AnchorPoint=Vector2.new(0,0.5)co.toggleName2.AutomaticSize=Enum.
AutomaticSize.XY co.toggleName2.BackgroundTransparency=1 co.toggleName2.FontFace
=Font.new('rbxassetid://12187365364')co.toggleName2.Position=UDim2.new(0,25,0.5,
0)co.toggleName2.Size=UDim2.fromOffset(1,1)co.toggleName2.Text='Example Keybind'
co.toggleName2.TextColor3=Color3.new(1,1,1)co.toggleName2.TextSize=12 co.
toggleName2.Parent=co.keybindComponent co.holder3=Instance.new('Frame')co.
holder3.Name='Holder'co.holder3.AnchorPoint=Vector2.new(1,0.5)co.holder3.
AutomaticSize=Enum.AutomaticSize.XY co.holder3.BackgroundColor3=Color3.fromRGB(
24,25,32)co.holder3.ClipsDescendants=true co.holder3.Position=UDim2.new(1,-23,
0.5,0)co.holder3.Size=UDim2.fromOffset(16,16)co.value1=Instance.new('TextLabel')
co.value1.Name='Value'co.value1.AnchorPoint=Vector2.new(0,0.5)co.value1.
AutomaticSize=Enum.AutomaticSize.XY co.value1.BackgroundTransparency=1 co.value1
.FontFace=Font.new('rbxassetid://12187365364',Enum.FontWeight.SemiBold,Enum.
FontStyle.Normal)co.value1.Position=UDim2.new(0,19,0.5,0)co.value1.Size=UDim2.
fromOffset(1,1)co.value1.Text='NONE'co.value1.TextColor3=Color3.new(1,1,1)co.
value1.TextSize=10 co.uIPadding9=Instance.new('UIPadding')co.uIPadding9.Name=
'UIPadding'co.uIPadding9.PaddingBottom=UDim.new(0,4)co.uIPadding9.PaddingLeft=
UDim.new(0,4)co.uIPadding9.PaddingRight=UDim.new(0,10)co.uIPadding9.PaddingTop=
UDim.new(0,6)co.uIPadding9.Parent=co.value1 co.line=Instance.new('Frame')co.line
.Name='Line'co.line.AnchorPoint=Vector2.new(1,0.5)co.line.BackgroundColor3=
Color3.fromRGB(254,254,254)co.line.Position=UDim2.new(1,13,0.5,0)co.line.Size=
UDim2.fromOffset(6,13)co.uICorner32=Instance.new('UICorner')co.uICorner32.Name=
'UICorner'co.uICorner32.CornerRadius=UDim.new(0,30)co.uICorner32.Parent=co.line
co.line1=Instance.new('Frame')co.line1.Name='Line'co.line1.AnchorPoint=Vector2.
new(1,0.5)co.line1.BackgroundColor3=Color3.fromRGB(254,254,254)co.line1.Position
=UDim2.new(1,13,0.5,0)co.line1.Size=UDim2.fromOffset(6,13)co.uICorner33=Instance
.new('UICorner')co.uICorner33.Name='UICorner'co.uICorner33.CornerRadius=UDim.
new(0,30)co.uICorner33.Parent=co.line1 co.line1.Parent=co.line co.line.Parent=co
.value1 co.value1.Parent=co.holder3 co.iconHolder=Instance.new('Frame')co.
iconHolder.Name='Icon_Holder'co.iconHolder.BackgroundTransparency=1 co.
iconHolder.Position=UDim2.fromScale(0.04,-0.327869)co.iconHolder.Size=UDim2.
fromOffset(22,22)co.imageLabel=Instance.new('ImageLabel')co.imageLabel.Name=
'ImageLabel'co.imageLabel.AnchorPoint=Vector2.new(0.5,0.5)co.imageLabel.
BackgroundTransparency=1 co.imageLabel.Image='rbxassetid://127406982390736'co.
imageLabel.ImageColor3=Color3.fromRGB(254,254,254)co.imageLabel.Position=UDim2.
fromScale(0.5,0.5)co.imageLabel.ScaleType=Enum.ScaleType.Fit co.imageLabel.Size=
UDim2.fromOffset(15,15)co.uIGradient6=Instance.new('UIGradient')co.uIGradient6.
Name='UIGradient'co.uIGradient6.Color=ColorSequence.new({ColorSequenceKeypoint.
new(0,Color3.fromRGB(254,254,254)),ColorSequenceKeypoint.new(1,Color3.fromRGB(
147,147,147))})co.uIGradient6.Parent=co.imageLabel co.imageLabel.Parent=co.
iconHolder co.iconHolder.Parent=co.holder3 co.uIStroke2=Instance.new('UIStroke')
co.uIStroke2.Name='UIStroke'co.uIStroke2.Color=Color3.fromRGB(28,30,38)co.
uIStroke2.Parent=co.holder3 co.uIListLayout3=Instance.new('UIListLayout')co.
uIListLayout3.Name='UIListLayout'co.uIListLayout3.FillDirection=Enum.
FillDirection.Horizontal co.uIListLayout3.Parent=co.holder3 co.uICorner34=
Instance.new('UICorner')co.uICorner34.Name='UICorner'co.uICorner34.CornerRadius=
UDim.new(0,3)co.uICorner34.Parent=co.holder3 co.holder3.Parent=co.
keybindComponent co.keybindComponent.Parent=co.holder2 co.toggleComponent2=
Instance.new('Frame')co.toggleComponent2.Name='Toggle_Component'co.
toggleComponent2.AnchorPoint=Vector2.new(0.5,0)co.toggleComponent2.
BackgroundTransparency=1 co.toggleComponent2.Position=UDim2.fromScale(0.5,0)co.
toggleComponent2.Size=UDim2.fromOffset(312,30)co.toggleName3=Instance.new(
'TextLabel')co.toggleName3.Name='Toggle_Name'co.toggleName3.AnchorPoint=Vector2.
new(0,0.5)co.toggleName3.AutomaticSize=Enum.AutomaticSize.XY co.toggleName3.
BackgroundTransparency=1 co.toggleName3.FontFace=Font.new(
'rbxassetid://12187365364')co.toggleName3.Position=UDim2.new(0,48,0.5,0)co.
toggleName3.Size=UDim2.fromOffset(1,1)co.toggleName3.Text='Example Toggle'co.
toggleName3.TextColor3=Color3.new(1,1,1)co.toggleName3.TextSize=12 co.
toggleName3.Parent=co.toggleComponent2 co.toggle2=Instance.new('Frame')co.
toggle2.Name='Toggle'co.toggle2.AnchorPoint=Vector2.new(0,0.5)co.toggle2.
BackgroundColor3=Color3.fromRGB(231,231,231)co.toggle2.Position=UDim2.new(0,25,
0.5,0)co.toggle2.Size=UDim2.fromOffset(14,14)co.checkIcon1=Instance.new(
'ImageLabel')co.checkIcon1.Name='Check_Icon'co.checkIcon1.AnchorPoint=Vector2.
new(0.5,0.5)co.checkIcon1.BackgroundTransparency=1 co.checkIcon1.Image=
'rbxassetid://83899464799881'co.checkIcon1.Position=UDim2.fromScale(0.5,0.5)co.
checkIcon1.Size=UDim2.fromOffset(8,7)co.checkIcon1.Parent=co.toggle2 co.
uICorner35=Instance.new('UICorner')co.uICorner35.Name='UICorner'co.uICorner35.
CornerRadius=UDim.new(0,3)co.uICorner35.Parent=co.toggle2 co.uIGradient7=
Instance.new('UIGradient')co.uIGradient7.Name='UIGradient'co.uIGradient7.Color=
ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient7.Parent=
co.toggle2 co.toggle2.Parent=co.toggleComponent2 co.toggleComponent2.Parent=co.
holder2 co.dropdownComponent=Instance.new('Frame')co.dropdownComponent.Name=
'Dropdown_Component'co.dropdownComponent.AnchorPoint=Vector2.new(0.5,0)co.
dropdownComponent.BackgroundTransparency=1 co.dropdownComponent.Position=UDim2.
fromScale(0.5,0.762332)co.dropdownComponent.Size=UDim2.fromOffset(312,55)co.
dropdownName=Instance.new('TextLabel')co.dropdownName.Name='Dropdown_Name'co.
dropdownName.AutomaticSize=Enum.AutomaticSize.XY co.dropdownName.
BackgroundTransparency=1 co.dropdownName.FontFace=Font.new(
'rbxassetid://12187365364')co.dropdownName.Position=UDim2.fromOffset(25,12)co.
dropdownName.Size=UDim2.fromOffset(1,1)co.dropdownName.Text='Example Dropdown'co
.dropdownName.TextColor3=Color3.fromRGB(204,204,209)co.dropdownName.TextSize=12
co.dropdownName.Parent=co.dropdownComponent co.holder4=Instance.new('Frame')co.
holder4.Name='Holder'co.holder4.AnchorPoint=Vector2.new(0.5,1)co.holder4.
BackgroundColor3=Color3.fromRGB(24,25,32)co.holder4.ClipsDescendants=true co.
holder4.Position=UDim2.fromScale(0.503205,1)co.holder4.Size=UDim2.fromOffset(264
,22)co.uIStroke3=Instance.new('UIStroke')co.uIStroke3.Name='UIStroke'co.
uIStroke3.Color=Color3.fromRGB(28,30,38)co.uIStroke3.Parent=co.holder4 co.
uICorner36=Instance.new('UICorner')co.uICorner36.Name='UICorner'co.uICorner36.
CornerRadius=UDim.new(0,2)co.uICorner36.Parent=co.holder4 co.options=Instance.
new('TextLabel')co.options.Name='Options'co.options.AnchorPoint=Vector2.new(0,
0.5)co.options.AutomaticSize=Enum.AutomaticSize.XY co.options.
BackgroundTransparency=1 co.options.FontFace=Font.new('rbxassetid://12187365364'
,Enum.FontWeight.Medium,Enum.FontStyle.Normal)co.options.Position=UDim2.
fromScale(0.025,0.5)co.options.Size=UDim2.fromOffset(1,1)co.options.Text=
'Option 1, Option 2 , Option 3'co.options.TextColor3=Color3.fromRGB(254,254,254)
co.options.TextSize=13 co.uIGradient8=Instance.new('UIGradient')co.uIGradient8.
Name='UIGradient'co.uIGradient8.Color=ColorSequence.new({ColorSequenceKeypoint.
new(0,Color3.fromRGB(254,254,254)),ColorSequenceKeypoint.new(1,Color3.fromRGB(
147,147,147))})co.uIGradient8.Parent=co.options co.options.Parent=co.holder4 co.
line2=Instance.new('Frame')co.line2.Name='Line'co.line2.AnchorPoint=Vector2.new(
1,0.5)co.line2.BackgroundColor3=Color3.fromRGB(254,254,254)co.line2.Position=
UDim2.new(1,4,0.5,0)co.line2.Size=UDim2.fromOffset(6,13)co.uICorner37=Instance.
new('UICorner')co.uICorner37.Name='UICorner'co.uICorner37.CornerRadius=UDim.new(
0,30)co.uICorner37.Parent=co.line2 co.uIGradient9=Instance.new('UIGradient')co.
uIGradient9.Name='UIGradient'co.uIGradient9.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),ColorSequenceKeypoint.
new(1,Color3.fromRGB(147,147,147))})co.uIGradient9.Parent=co.line2 co.line2.
Parent=co.holder4 co.line3=Instance.new('Frame')co.line3.Name='Line'co.line3.
AnchorPoint=Vector2.new(0,0.5)co.line3.BackgroundColor3=Color3.fromRGB(254,254,
254)co.line3.Position=UDim2.new(0,-4,0.5,0)co.line3.Size=UDim2.fromOffset(6,13)
co.uICorner38=Instance.new('UICorner')co.uICorner38.Name='UICorner'co.uICorner38
.CornerRadius=UDim.new(0,30)co.uICorner38.Parent=co.line3 co.uIGradient10=
Instance.new('UIGradient')co.uIGradient10.Name='UIGradient'co.uIGradient10.Color
=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient10.Parent
=co.line3 co.line3.Parent=co.holder4 co.holder4.Parent=co.dropdownComponent co.
dropdownComponent.Parent=co.holder2 co.buttonComponent=Instance.new('Frame')co.
buttonComponent.Name='Button_Component'co.buttonComponent.AnchorPoint=Vector2.
new(0.5,0)co.buttonComponent.BackgroundTransparency=1 co.buttonComponent.
Position=UDim2.fromScale(0.5,0.848214)co.buttonComponent.Size=UDim2.fromOffset(
312,40)co.button=Instance.new('Frame')co.button.Name='Button'co.button.
AnchorPoint=Vector2.new(0.5,0.5)co.button.BackgroundColor3=Color3.fromRGB(24,25,
32)co.button.Position=UDim2.fromScale(0.5,0.5)co.button.Size=UDim2.fromOffset(
251,30)co.uICorner39=Instance.new('UICorner')co.uICorner39.Name='UICorner'co.
uICorner39.CornerRadius=UDim.new(0,3)co.uICorner39.Parent=co.button co.
buttonText=Instance.new('TextLabel')co.buttonText.Name='Button_Text'co.
buttonText.AnchorPoint=Vector2.new(0.5,0.5)co.buttonText.AutomaticSize=Enum.
AutomaticSize.XY co.buttonText.BackgroundTransparency=1 co.buttonText.FontFace=
Font.new('rbxassetid://12187365364',Enum.FontWeight.Medium,Enum.FontStyle.Normal
)co.buttonText.Position=UDim2.fromScale(0.5,0.5)co.buttonText.Size=UDim2.
fromOffset(1,1)co.buttonText.Text='Example Button'co.buttonText.TextColor3=
Color3.fromRGB(69,71,90)co.buttonText.TextSize=13 co.buttonText.Parent=co.button
co.uIStroke4=Instance.new('UIStroke')co.uIStroke4.Name='UIStroke'co.uIStroke4.
Color=Color3.fromRGB(28,30,38)co.uIStroke4.Parent=co.button co.button.Parent=co.
buttonComponent co.buttonComponent.Parent=co.holder2 co.buttonComponent1=
Instance.new('Frame')co.buttonComponent1.Name='Button_Component'co.
buttonComponent1.AnchorPoint=Vector2.new(0.5,0)co.buttonComponent1.
BackgroundTransparency=1 co.buttonComponent1.Position=UDim2.fromScale(0.5,
0.848214)co.buttonComponent1.Size=UDim2.fromOffset(312,43)co.button1=Instance.
new('Frame')co.button1.Name='Button'co.button1.AnchorPoint=Vector2.new(0.5,0.5)
co.button1.BackgroundColor3=Color3.fromRGB(230,255,2)co.button1.
BackgroundTransparency=0.95 co.button1.Position=UDim2.fromScale(0.5,0.5)co.
button1.Size=UDim2.fromOffset(251,30)co.uICorner40=Instance.new('UICorner')co.
uICorner40.Name='UICorner'co.uICorner40.CornerRadius=UDim.new(0,3)co.uICorner40.
Parent=co.button1 co.buttonText1=Instance.new('TextLabel')co.buttonText1.Name=
'Button_Text'co.buttonText1.AnchorPoint=Vector2.new(0.5,0.5)co.buttonText1.
AutomaticSize=Enum.AutomaticSize.XY co.buttonText1.BackgroundTransparency=1 co.
buttonText1.FontFace=Font.new('rbxassetid://12187365364',Enum.FontWeight.Medium,
Enum.FontStyle.Normal)co.buttonText1.Position=UDim2.fromScale(0.5,0.5)co.
buttonText1.Size=UDim2.fromOffset(1,1)co.buttonText1.Text='Custom Color Button'
co.buttonText1.TextColor3=Color3.fromRGB(230,255,2)co.buttonText1.TextSize=13 co
.buttonText1.Parent=co.button1 co.uIStroke5=Instance.new('UIStroke')co.uIStroke5
.Name='UIStroke'co.uIStroke5.Color=Color3.fromRGB(230,255,2)co.uIStroke5.
Transparency=0.5 co.uIStroke5.Parent=co.button1 co.button1.Parent=co.
buttonComponent1 co.buttonComponent1.Parent=co.holder2 co.holder2.Parent=co.
header1 co.uICorner41=Instance.new('UICorner')co.uICorner41.Name='UICorner'co.
uICorner41.CornerRadius=UDim.new(0,6)co.uICorner41.Parent=co.header1 co.liner2=
Instance.new('Frame')co.liner2.Name='Liner'co.liner2.AnchorPoint=Vector2.new(0.5
,1)co.liner2.BackgroundColor3=Color3.fromRGB(26,26,37)co.liner2.BorderColor3=
Color3.new()co.liner2.BorderSizePixel=0 co.liner2.Position=UDim2.fromScale(0.5,1
)co.liner2.Size=UDim2.new(1,1,0,1)co.liner2.Parent=co.header1 co.headerHolder=
Instance.new('Frame')co.headerHolder.Name='Header_Holder'co.headerHolder.
AnchorPoint=Vector2.new(0.5,0.5)co.headerHolder.BackgroundTransparency=1 co.
headerHolder.ClipsDescendants=true co.headerHolder.Position=UDim2.fromScale(0.5,
0.5)co.headerHolder.Size=UDim2.fromOffset(281,30)co.sectionName=Instance.new(
'TextLabel')co.sectionName.Name='Section_Name'co.sectionName.AnchorPoint=Vector2
.new(0,0.5)co.sectionName.AutomaticSize=Enum.AutomaticSize.XY co.sectionName.
BackgroundTransparency=1 co.sectionName.FontFace=Font.new(
'rbxassetid://12187365364')co.sectionName.Position=UDim2.new(0,35,0.5,0)co.
sectionName.Size=UDim2.fromOffset(1,1)co.sectionName.Text='Exploits Tab'co.
sectionName.TextColor3=Color3.new(1,1,1)co.sectionName.TextSize=12 co.
sectionName.Parent=co.headerHolder co.imageLabel1=Instance.new('ImageLabel')co.
imageLabel1.Name='ImageLabel'co.imageLabel1.AnchorPoint=Vector2.new(0,0.5)co.
imageLabel1.BackgroundTransparency=1 co.imageLabel1.Image=
'rbxassetid://83273732891006'co.imageLabel1.Position=UDim2.new(0,12,0.5,0)co.
imageLabel1.Size=UDim2.fromOffset(15,15)co.imageLabel1.Parent=co.headerHolder co
.toggle3=Instance.new('Frame')co.toggle3.Name='Toggle'co.toggle3.AnchorPoint=
Vector2.new(1,0.5)co.toggle3.BackgroundColor3=Color3.fromRGB(231,231,231)co.
toggle3.Position=UDim2.new(1,-12,0.5,0)co.toggle3.Size=UDim2.fromOffset(16,16)co
.checkIcon2=Instance.new('ImageLabel')co.checkIcon2.Name='Check_Icon'co.
checkIcon2.AnchorPoint=Vector2.new(0.5,0.5)co.checkIcon2.BackgroundTransparency=
1 co.checkIcon2.Image='rbxassetid://83899464799881'co.checkIcon2.Position=UDim2.
fromScale(0.5,0.5)co.checkIcon2.Size=UDim2.fromOffset(8,7)co.checkIcon2.Parent=
co.toggle3 co.uICorner42=Instance.new('UICorner')co.uICorner42.Name='UICorner'co
.uICorner42.CornerRadius=UDim.new(0,3)co.uICorner42.Parent=co.toggle3 co.
uIGradient11=Instance.new('UIGradient')co.uIGradient11.Name='UIGradient'co.
uIGradient11.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.
fromRGB(254,254,254)),ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})
co.uIGradient11.Parent=co.toggle3 co.toggle3.Parent=co.headerHolder co.line4=
Instance.new('Frame')co.line4.Name='Line'co.line4.AnchorPoint=Vector2.new(0,0.5)
co.line4.BackgroundColor3=Color3.fromRGB(254,254,254)co.line4.Position=UDim2.
new(0,-3,0.5,0)co.line4.Size=UDim2.fromOffset(6,20)co.uICorner43=Instance.new(
'UICorner')co.uICorner43.Name='UICorner'co.uICorner43.CornerRadius=UDim.new(0,30
)co.uICorner43.Parent=co.line4 co.uIGradient12=Instance.new('UIGradient')co.
uIGradient12.Name='UIGradient'co.uIGradient12.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),ColorSequenceKeypoint.
new(1,Color3.fromRGB(147,147,147))})co.uIGradient12.Parent=co.line4 co.line4.
Parent=co.headerHolder co.headerHolder.Parent=co.header1 co.header1.Parent=co.
sectionLeft co.uICorner44=Instance.new('UICorner')co.uICorner44.Name='UICorner'
co.uICorner44.CornerRadius=UDim.new(0,6)co.uICorner44.Parent=co.sectionLeft co.
sectionLeft.Parent=co.container co.uIListLayout4=Instance.new('UIListLayout')co.
uIListLayout4.Name='UIListLayout'co.uIListLayout4.FillDirection=Enum.
FillDirection.Horizontal co.uIListLayout4.Padding=UDim.new(0,20)co.uIListLayout4
.SortOrder=Enum.SortOrder.LayoutOrder co.uIListLayout4.Parent=co.container co.
uIPadding10=Instance.new('UIPadding')co.uIPadding10.Name='UIPadding'co.
uIPadding10.PaddingLeft=UDim.new(0,12)co.uIPadding10.PaddingTop=UDim.new(0,12)co
.uIPadding10.Parent=co.container co.sectionRight=Instance.new('Frame')co.
sectionRight.Name='Section_Right'co.sectionRight.AutomaticSize=Enum.
AutomaticSize.Y co.sectionRight.BackgroundColor3=Color3.fromRGB(17,18,22)co.
sectionRight.ClipsDescendants=true co.sectionRight.Size=UDim2.fromOffset(281,60)
co.header2=Instance.new('Frame')co.header2.Name='Header'co.header2.AnchorPoint=
Vector2.new(0.5,0)co.header2.BackgroundColor3=Color3.fromRGB(19,20,25)co.header2
.Position=UDim2.fromScale(0.501786,0)co.header2.Size=UDim2.fromOffset(281,30)co.
holder5=Instance.new('Frame')co.holder5.Name='Holder'co.holder5.AnchorPoint=
Vector2.new(0.5,0)co.holder5.AutomaticSize=Enum.AutomaticSize.XY co.holder5.
BackgroundTransparency=1 co.holder5.Position=UDim2.fromScale(0.5,1)co.holder5.
Size=UDim2.fromOffset(1,1)co.uIListLayout5=Instance.new('UIListLayout')co.
uIListLayout5.Name='UIListLayout'co.uIListLayout5.Padding=UDim.new(0,4)co.
uIListLayout5.SortOrder=Enum.SortOrder.LayoutOrder co.uIListLayout5.Parent=co.
holder5 co.uIPadding11=Instance.new('UIPadding')co.uIPadding11.Name='UIPadding'
co.uIPadding11.PaddingBottom=UDim.new(0,45)co.uIPadding11.PaddingTop=UDim.new(0,
5)co.uIPadding11.Parent=co.holder5 co.toggleComponent3=Instance.new('Frame')co.
toggleComponent3.Name='Toggle_Component'co.toggleComponent3.AnchorPoint=Vector2.
new(0.5,0)co.toggleComponent3.BackgroundTransparency=1 co.toggleComponent3.
Position=UDim2.fromScale(0.5,0)co.toggleComponent3.Size=UDim2.fromOffset(312,30)
co.toggleName4=Instance.new('TextLabel')co.toggleName4.Name='Toggle_Name'co.
toggleName4.AnchorPoint=Vector2.new(0,0.5)co.toggleName4.AutomaticSize=Enum.
AutomaticSize.XY co.toggleName4.BackgroundTransparency=1 co.toggleName4.FontFace
=Font.new('rbxassetid://12187365364')co.toggleName4.Position=UDim2.new(0,48,0.5,
0)co.toggleName4.Size=UDim2.fromOffset(1,1)co.toggleName4.Text='Example Toggle'
co.toggleName4.TextColor3=Color3.fromRGB(69,71,90)co.toggleName4.TextSize=12 co.
toggleName4.Parent=co.toggleComponent3 co.toggle4=Instance.new('Frame')co.
toggle4.Name='Toggle'co.toggle4.AnchorPoint=Vector2.new(0,0.5)co.toggle4.
BackgroundColor3=Color3.fromRGB(24,25,32)co.toggle4.Position=UDim2.new(0,25,0.5,
0)co.toggle4.Size=UDim2.fromOffset(14,14)co.uIStroke6=Instance.new('UIStroke')co
.uIStroke6.Name='UIStroke'co.uIStroke6.Color=Color3.fromRGB(28,30,38)co.
uIStroke6.Parent=co.toggle4 co.uICorner45=Instance.new('UICorner')co.uICorner45.
Name='UICorner'co.uICorner45.CornerRadius=UDim.new(0,3)co.uICorner45.Parent=co.
toggle4 co.toggle4.Parent=co.toggleComponent3 co.toggleComponent3.Parent=co.
holder5 co.toggleComponent4=Instance.new('Frame')co.toggleComponent4.Name=
'Toggle_Component'co.toggleComponent4.AnchorPoint=Vector2.new(0.5,0)co.
toggleComponent4.BackgroundTransparency=1 co.toggleComponent4.Position=UDim2.
fromScale(0.5,0)co.toggleComponent4.Size=UDim2.fromOffset(312,30)co.toggleName5=
Instance.new('TextLabel')co.toggleName5.Name='Toggle_Name'co.toggleName5.
AnchorPoint=Vector2.new(0,0.5)co.toggleName5.AutomaticSize=Enum.AutomaticSize.XY
co.toggleName5.BackgroundTransparency=1 co.toggleName5.FontFace=Font.new(
'rbxassetid://12187365364')co.toggleName5.Position=UDim2.new(0,48,0.5,0)co.
toggleName5.Size=UDim2.fromOffset(1,1)co.toggleName5.Text='Example Toggle'co.
toggleName5.TextColor3=Color3.new(1,1,1)co.toggleName5.TextSize=12 co.
toggleName5.Parent=co.toggleComponent4 co.toggle5=Instance.new('Frame')co.
toggle5.Name='Toggle'co.toggle5.AnchorPoint=Vector2.new(0,0.5)co.toggle5.
BackgroundColor3=Color3.fromRGB(231,231,231)co.toggle5.Position=UDim2.new(0,25,
0.5,0)co.toggle5.Size=UDim2.fromOffset(14,14)co.checkIcon3=Instance.new(
'ImageLabel')co.checkIcon3.Name='Check_Icon'co.checkIcon3.AnchorPoint=Vector2.
new(0.5,0.5)co.checkIcon3.BackgroundTransparency=1 co.checkIcon3.Image=
'rbxassetid://83899464799881'co.checkIcon3.Position=UDim2.fromScale(0.5,0.5)co.
checkIcon3.Size=UDim2.fromOffset(8,7)co.checkIcon3.Parent=co.toggle5 co.
uICorner46=Instance.new('UICorner')co.uICorner46.Name='UICorner'co.uICorner46.
CornerRadius=UDim.new(0,3)co.uICorner46.Parent=co.toggle5 co.uIGradient13=
Instance.new('UIGradient')co.uIGradient13.Name='UIGradient'co.uIGradient13.Color
=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient13.Parent
=co.toggle5 co.toggle5.Parent=co.toggleComponent4 co.colorFrame1=Instance.new(
'Frame')co.colorFrame1.Name='ColorFrame'co.colorFrame1.AnchorPoint=Vector2.new(1
,0.5)co.colorFrame1.BackgroundColor3=Color3.new(1,1,1)co.colorFrame1.Position=
UDim2.new(1,-23,0.5,0)co.colorFrame1.Size=UDim2.fromOffset(24,13)co.uICorner47=
Instance.new('UICorner')co.uICorner47.Name='UICorner'co.uICorner47.CornerRadius=
UDim.new(0,4)co.uICorner47.Parent=co.colorFrame1 co.shadow=Instance.new('Frame')
co.shadow.Name='Shadow'co.shadow.AnchorPoint=Vector2.new(0.5,0.5)co.shadow.
BackgroundColor3=Color3.new(1,1,1)co.shadow.Position=UDim2.fromScale(0.5,0.5)co.
shadow.Size=UDim2.fromOffset(24,13)co.uICorner48=Instance.new('UICorner')co.
uICorner48.Name='UICorner'co.uICorner48.CornerRadius=UDim.new(0,4)co.uICorner48.
Parent=co.shadow co.uIGradient14=Instance.new('UIGradient')co.uIGradient14.Name=
'UIGradient'co.uIGradient14.Color=ColorSequence.new({ColorSequenceKeypoint.new(0
,Color3.new()),ColorSequenceKeypoint.new(1,Color3.new())})co.uIGradient14.
Rotation=90 co.uIGradient14.Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.450125,0.75),
NumberSequenceKeypoint.new(0.695761,1),NumberSequenceKeypoint.new(0.987531,
0.99375),NumberSequenceKeypoint.new(1,1)})co.uIGradient14.Parent=co.shadow co.
shadow.Parent=co.colorFrame1 co.colorFrame1.Parent=co.toggleComponent4 co.
toggleComponent4.Parent=co.holder5 co.toggleComponent5=Instance.new('Frame')co.
toggleComponent5.Name='Toggle_Component'co.toggleComponent5.AnchorPoint=Vector2.
new(0.5,0)co.toggleComponent5.BackgroundTransparency=1 co.toggleComponent5.
Position=UDim2.fromScale(0.5,0)co.toggleComponent5.Size=UDim2.fromOffset(312,30)
co.toggleName6=Instance.new('TextLabel')co.toggleName6.Name='Toggle_Name'co.
toggleName6.AnchorPoint=Vector2.new(0,0.5)co.toggleName6.AutomaticSize=Enum.
AutomaticSize.XY co.toggleName6.BackgroundTransparency=1 co.toggleName6.FontFace
=Font.new('rbxassetid://12187365364')co.toggleName6.Position=UDim2.new(0,48,0.5,
0)co.toggleName6.Size=UDim2.fromOffset(1,1)co.toggleName6.Text='Example Toggle'
co.toggleName6.TextColor3=Color3.new(1,1,1)co.toggleName6.TextSize=12 co.
toggleName6.Parent=co.toggleComponent5 co.toggle6=Instance.new('Frame')co.
toggle6.Name='Toggle'co.toggle6.AnchorPoint=Vector2.new(0,0.5)co.toggle6.
BackgroundColor3=Color3.fromRGB(231,231,231)co.toggle6.Position=UDim2.new(0,25,
0.5,0)co.toggle6.Size=UDim2.fromOffset(14,14)co.checkIcon4=Instance.new(
'ImageLabel')co.checkIcon4.Name='Check_Icon'co.checkIcon4.AnchorPoint=Vector2.
new(0.5,0.5)co.checkIcon4.BackgroundTransparency=1 co.checkIcon4.Image=
'rbxassetid://83899464799881'co.checkIcon4.Position=UDim2.fromScale(0.5,0.5)co.
checkIcon4.Size=UDim2.fromOffset(8,7)co.checkIcon4.Parent=co.toggle6 co.
uICorner49=Instance.new('UICorner')co.uICorner49.Name='UICorner'co.uICorner49.
CornerRadius=UDim.new(0,3)co.uICorner49.Parent=co.toggle6 co.uIGradient15=
Instance.new('UIGradient')co.uIGradient15.Name='UIGradient'co.uIGradient15.Color
=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient15.Parent
=co.toggle6 co.toggle6.Parent=co.toggleComponent5 co.toggleComponent5.Parent=co.
holder5 co.sliderComponent1=Instance.new('Frame')co.sliderComponent1.Name=
'Slider_Component'co.sliderComponent1.Active=true co.sliderComponent1.
AnchorPoint=Vector2.new(0.5,0)co.sliderComponent1.BackgroundTransparency=1 co.
sliderComponent1.Position=UDim2.fromScale(0.5,0.762195)co.sliderComponent1.Size=
UDim2.fromOffset(312,40)co.value2=Instance.new('TextLabel')co.value2.Name=
'Value'co.value2.AnchorPoint=Vector2.new(1,0.5)co.value2.AutomaticSize=Enum.
AutomaticSize.XY co.value2.BackgroundTransparency=1 co.value2.FontFace=Font.new(
'rbxassetid://12187365364')co.value2.Position=UDim2.new(1,-22,0.5,-8)co.value2.
Size=UDim2.fromOffset(1,1)co.value2.Text='100'co.value2.TextColor3=Color3.new(1,
1,1)co.value2.TextSize=14 co.value2.Parent=co.sliderComponent1 co.sliderText1=
Instance.new('TextLabel')co.sliderText1.Name='Slider_Text'co.sliderText1.
AnchorPoint=Vector2.new(0,0.5)co.sliderText1.AutomaticSize=Enum.AutomaticSize.XY
co.sliderText1.BackgroundTransparency=1 co.sliderText1.FontFace=Font.new(
'rbxassetid://12187365364')co.sliderText1.Position=UDim2.new(0,23,0.5,-8)co.
sliderText1.Size=UDim2.fromOffset(1,1)co.sliderText1.Text='Example Slider'co.
sliderText1.TextColor3=Color3.fromRGB(69,71,90)co.sliderText1.TextSize=14 co.
sliderText1.Parent=co.sliderComponent1 co.progressBG1=Instance.new('Frame')co.
progressBG1.Name='Progress_BG'co.progressBG1.AnchorPoint=Vector2.new(0,0.5)co.
progressBG1.BackgroundColor3=Color3.fromRGB(24,25,32)co.progressBG1.Position=
UDim2.new(0.0128205,19,0.53125,13)co.progressBG1.Size=UDim2.fromOffset(266,4)co.
progress1=Instance.new('Frame')co.progress1.Name='Progress'co.progress1.
AnchorPoint=Vector2.new(0,0.5)co.progress1.BackgroundColor3=Color3.fromRGB(232,
232,232)co.progress1.Position=UDim2.fromScale(0,0.5)co.progress1.Size=UDim2.
fromOffset(171,7)co.uICorner50=Instance.new('UICorner')co.uICorner50.Name=
'UICorner'co.uICorner50.Parent=co.progress1 co.uIGradient16=Instance.new(
'UIGradient')co.uIGradient16.Name='UIGradient'co.uIGradient16.Color=
ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient16.Parent
=co.progress1 co.pointer1=Instance.new('Frame')co.pointer1.Name='Pointer'co.
pointer1.AnchorPoint=Vector2.new(1,0.5)co.pointer1.BackgroundColor3=Color3.new(1
,1,1)co.pointer1.Position=UDim2.fromScale(1,0.5)co.pointer1.Size=UDim2.
fromOffset(6,6)co.uICorner51=Instance.new('UICorner')co.uICorner51.Name=
'UICorner'co.uICorner51.Parent=co.pointer1 co.design1=Instance.new('Frame')co.
design1.Name='Design'co.design1.AnchorPoint=Vector2.new(0.5,0.5)co.design1.
BackgroundColor3=Color3.new(1,1,1)co.design1.BackgroundTransparency=0.5 co.
design1.Position=UDim2.fromScale(0.5,0.5)co.design1.Size=UDim2.fromOffset(14,14)
co.uICorner52=Instance.new('UICorner')co.uICorner52.Name='UICorner'co.uICorner52
.Parent=co.design1 co.design1.Parent=co.pointer1 co.pointer1.Parent=co.progress1
co.progress1.Parent=co.progressBG1 co.uIStroke7=Instance.new('UIStroke')co.
uIStroke7.Name='UIStroke'co.uIStroke7.Color=Color3.fromRGB(28,30,38)co.uIStroke7
.Parent=co.progressBG1 co.uICorner53=Instance.new('UICorner')co.uICorner53.Name=
'UICorner'co.uICorner53.Parent=co.progressBG1 co.progressBG1.Parent=co.
sliderComponent1 co.sliderComponent1.Parent=co.holder5 co.keybindComponent1=
Instance.new('Frame')co.keybindComponent1.Name='Keybind_Component'co.
keybindComponent1.AnchorPoint=Vector2.new(0.5,0)co.keybindComponent1.
BackgroundTransparency=1 co.keybindComponent1.Position=UDim2.fromScale(0.5,
0.71885)co.keybindComponent1.Size=UDim2.fromOffset(312,50)co.toggleName7=
Instance.new('TextLabel')co.toggleName7.Name='Toggle_Name'co.toggleName7.
AnchorPoint=Vector2.new(0,0.5)co.toggleName7.AutomaticSize=Enum.AutomaticSize.XY
co.toggleName7.BackgroundTransparency=1 co.toggleName7.FontFace=Font.new(
'rbxassetid://12187365364')co.toggleName7.Position=UDim2.new(0,25,0.5,0)co.
toggleName7.Size=UDim2.fromOffset(1,1)co.toggleName7.Text='Example Keybind'co.
toggleName7.TextColor3=Color3.new(1,1,1)co.toggleName7.TextSize=12 co.
toggleName7.Parent=co.keybindComponent1 co.holder6=Instance.new('Frame')co.
holder6.Name='Holder'co.holder6.AnchorPoint=Vector2.new(1,0.5)co.holder6.
AutomaticSize=Enum.AutomaticSize.XY co.holder6.BackgroundColor3=Color3.fromRGB(
24,25,32)co.holder6.ClipsDescendants=true co.holder6.Position=UDim2.new(1,-23,
0.5,0)co.holder6.Size=UDim2.fromOffset(16,16)co.value3=Instance.new('TextLabel')
co.value3.Name='Value'co.value3.AnchorPoint=Vector2.new(0,0.5)co.value3.
AutomaticSize=Enum.AutomaticSize.XY co.value3.BackgroundTransparency=1 co.value3
.FontFace=Font.new('rbxassetid://12187365364',Enum.FontWeight.SemiBold,Enum.
FontStyle.Normal)co.value3.Position=UDim2.new(0,19,0.5,0)co.value3.Size=UDim2.
fromOffset(1,1)co.value3.Text='NONE'co.value3.TextColor3=Color3.new(1,1,1)co.
value3.TextSize=10 co.uIPadding12=Instance.new('UIPadding')co.uIPadding12.Name=
'UIPadding'co.uIPadding12.PaddingBottom=UDim.new(0,4)co.uIPadding12.PaddingLeft=
UDim.new(0,4)co.uIPadding12.PaddingRight=UDim.new(0,10)co.uIPadding12.PaddingTop
=UDim.new(0,6)co.uIPadding12.Parent=co.value3 co.line5=Instance.new('Frame')co.
line5.Name='Line'co.line5.AnchorPoint=Vector2.new(1,0.5)co.line5.
BackgroundColor3=Color3.fromRGB(254,254,254)co.line5.Position=UDim2.new(1,13,0.5
,0)co.line5.Size=UDim2.fromOffset(6,13)co.uICorner54=Instance.new('UICorner')co.
uICorner54.Name='UICorner'co.uICorner54.CornerRadius=UDim.new(0,30)co.uICorner54
.Parent=co.line5 co.line6=Instance.new('Frame')co.line6.Name='Line'co.line6.
AnchorPoint=Vector2.new(1,0.5)co.line6.BackgroundColor3=Color3.fromRGB(254,254,
254)co.line6.Position=UDim2.new(1,13,0.5,0)co.line6.Size=UDim2.fromOffset(6,13)
co.uICorner55=Instance.new('UICorner')co.uICorner55.Name='UICorner'co.uICorner55
.CornerRadius=UDim.new(0,30)co.uICorner55.Parent=co.line6 co.line6.Parent=co.
line5 co.line5.Parent=co.value3 co.value3.Parent=co.holder6 co.iconHolder1=
Instance.new('Frame')co.iconHolder1.Name='Icon_Holder'co.iconHolder1.
BackgroundTransparency=1 co.iconHolder1.Position=UDim2.fromScale(0.04,-0.327869)
co.iconHolder1.Size=UDim2.fromOffset(22,22)co.imageLabel2=Instance.new(
'ImageLabel')co.imageLabel2.Name='ImageLabel'co.imageLabel2.AnchorPoint=Vector2.
new(0.5,0.5)co.imageLabel2.BackgroundTransparency=1 co.imageLabel2.Image=
'rbxassetid://127406982390736'co.imageLabel2.ImageColor3=Color3.fromRGB(254,254,
254)co.imageLabel2.Position=UDim2.fromScale(0.5,0.5)co.imageLabel2.ScaleType=
Enum.ScaleType.Fit co.imageLabel2.Size=UDim2.fromOffset(15,15)co.uIGradient17=
Instance.new('UIGradient')co.uIGradient17.Name='UIGradient'co.uIGradient17.Color
=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient17.Parent
=co.imageLabel2 co.imageLabel2.Parent=co.iconHolder1 co.iconHolder1.Parent=co.
holder6 co.uIStroke8=Instance.new('UIStroke')co.uIStroke8.Name='UIStroke'co.
uIStroke8.Color=Color3.fromRGB(28,30,38)co.uIStroke8.Parent=co.holder6 co.
uIListLayout6=Instance.new('UIListLayout')co.uIListLayout6.Name='UIListLayout'co
.uIListLayout6.FillDirection=Enum.FillDirection.Horizontal co.uIListLayout6.
Parent=co.holder6 co.uICorner56=Instance.new('UICorner')co.uICorner56.Name=
'UICorner'co.uICorner56.CornerRadius=UDim.new(0,3)co.uICorner56.Parent=co.
holder6 co.holder6.Parent=co.keybindComponent1 co.keybindComponent1.Parent=co.
holder5 co.dropdownComponent1=Instance.new('Frame')co.dropdownComponent1.Name=
'Dropdown_Component'co.dropdownComponent1.AnchorPoint=Vector2.new(0.5,0)co.
dropdownComponent1.BackgroundTransparency=1 co.dropdownComponent1.Position=UDim2
.fromScale(0.5,0.762332)co.dropdownComponent1.Size=UDim2.fromOffset(312,55)co.
dropdownName1=Instance.new('TextLabel')co.dropdownName1.Name='Dropdown_Name'co.
dropdownName1.AutomaticSize=Enum.AutomaticSize.XY co.dropdownName1.
BackgroundTransparency=1 co.dropdownName1.FontFace=Font.new(
'rbxassetid://12187365364')co.dropdownName1.Position=UDim2.fromOffset(25,12)co.
dropdownName1.Size=UDim2.fromOffset(1,1)co.dropdownName1.Text='Example Dropdown'
co.dropdownName1.TextColor3=Color3.fromRGB(204,204,209)co.dropdownName1.TextSize
=12 co.dropdownName1.Parent=co.dropdownComponent1 co.holder7=Instance.new(
'Frame')co.holder7.Name='Holder'co.holder7.AnchorPoint=Vector2.new(0.5,1)co.
holder7.BackgroundColor3=Color3.fromRGB(24,25,32)co.holder7.ClipsDescendants=
true co.holder7.Position=UDim2.fromScale(0.503205,1)co.holder7.Size=UDim2.
fromOffset(264,22)co.uIStroke9=Instance.new('UIStroke')co.uIStroke9.Name=
'UIStroke'co.uIStroke9.Color=Color3.fromRGB(28,30,38)co.uIStroke9.Parent=co.
holder7 co.uICorner57=Instance.new('UICorner')co.uICorner57.Name='UICorner'co.
uICorner57.CornerRadius=UDim.new(0,2)co.uICorner57.Parent=co.holder7 co.line7=
Instance.new('Frame')co.line7.Name='Line'co.line7.AnchorPoint=Vector2.new(1,0.5)
co.line7.BackgroundColor3=Color3.fromRGB(254,254,254)co.line7.Position=UDim2.
new(1,4,0.5,0)co.line7.Size=UDim2.fromOffset(6,13)co.uICorner58=Instance.new(
'UICorner')co.uICorner58.Name='UICorner'co.uICorner58.CornerRadius=UDim.new(0,30
)co.uICorner58.Parent=co.line7 co.uIGradient18=Instance.new('UIGradient')co.
uIGradient18.Name='UIGradient'co.uIGradient18.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),ColorSequenceKeypoint.
new(1,Color3.fromRGB(147,147,147))})co.uIGradient18.Parent=co.line7 co.line7.
Parent=co.holder7 co.line8=Instance.new('Frame')co.line8.Name='Line'co.line8.
AnchorPoint=Vector2.new(0,0.5)co.line8.BackgroundColor3=Color3.fromRGB(254,254,
254)co.line8.Position=UDim2.new(0,-4,0.5,0)co.line8.Size=UDim2.fromOffset(6,13)
co.uICorner59=Instance.new('UICorner')co.uICorner59.Name='UICorner'co.uICorner59
.CornerRadius=UDim.new(0,30)co.uICorner59.Parent=co.line8 co.uIGradient19=
Instance.new('UIGradient')co.uIGradient19.Name='UIGradient'co.uIGradient19.Color
=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(254,254,254)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})co.uIGradient19.Parent
=co.line8 co.line8.Parent=co.holder7 co.options1=Instance.new('TextLabel')co.
options1.Name='Options'co.options1.AnchorPoint=Vector2.new(0,0.5)co.options1.
AutomaticSize=Enum.AutomaticSize.XY co.options1.BackgroundTransparency=1 co.
options1.FontFace=Font.new('rbxassetid://12187365364',Enum.FontWeight.Medium,
Enum.FontStyle.Normal)co.options1.Position=UDim2.fromScale(0.025,0.5)co.options1
.Size=UDim2.fromOffset(1,1)co.options1.Text='Option 1, Option 2 , Option 3'co.
options1.TextColor3=Color3.fromRGB(254,254,254)co.options1.TextSize=13 co.
uIGradient20=Instance.new('UIGradient')co.uIGradient20.Name='UIGradient'co.
uIGradient20.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.
fromRGB(254,254,254)),ColorSequenceKeypoint.new(1,Color3.fromRGB(147,147,147))})
co.uIGradient20.Parent=co.options1 co.options1.Parent=co.holder7 co.holder7.
Parent=co.dropdownComponent1 co.dropdownComponent1.Parent=co.holder5 co.
buttonComponent2=Instance.new('Frame')co.buttonComponent2.Name=
'Button_Component'co.buttonComponent2.AnchorPoint=Vector2.new(0.5,0)co.
buttonComponent2.BackgroundTransparency=1 co.buttonComponent2.Position=UDim2.
fromScale(0.5,0.848214)co.buttonComponent2.Size=UDim2.fromOffset(312,40)co.
button2=Instance.new('Frame')co.button2.Name='Button'co.button2.AnchorPoint=
Vector2.new(0.5,0.5)co.button2.BackgroundColor3=Color3.fromRGB(24,25,32)co.
button2.Position=UDim2.fromScale(0.5,0.5)co.button2.Size=UDim2.fromOffset(251,30
)co.uICorner60=Instance.new('UICorner')co.uICorner60.Name='UICorner'co.
uICorner60.CornerRadius=UDim.new(0,3)co.uICorner60.Parent=co.button2 co.
buttonText2=Instance.new('TextLabel')co.buttonText2.Name='Button_Text'co.
buttonText2.AnchorPoint=Vector2.new(0.5,0.5)co.buttonText2.AutomaticSize=Enum.
AutomaticSize.XY co.buttonText2.BackgroundTransparency=1 co.buttonText2.FontFace
=Font.new('rbxassetid://12187365364',Enum.FontWeight.Medium,Enum.FontStyle.
Normal)co.buttonText2.Position=UDim2.fromScale(0.5,0.5)co.buttonText2.Size=UDim2
.fromOffset(1,1)co.buttonText2.Text='Example Button'co.buttonText2.TextColor3=
Color3.fromRGB(69,71,90)co.buttonText2.TextSize=13 co.buttonText2.Parent=co.
button2 co.uIStroke10=Instance.new('UIStroke')co.uIStroke10.Name='UIStroke'co.
uIStroke10.Color=Color3.fromRGB(28,30,38)co.uIStroke10.Parent=co.button2 co.
button2.Parent=co.buttonComponent2 co.buttonComponent2.Parent=co.holder5 co.
buttonComponent3=Instance.new('Frame')co.buttonComponent3.Name=
'Button_Component'co.buttonComponent3.AnchorPoint=Vector2.new(0.5,0)co.
buttonComponent3.BackgroundTransparency=1 co.buttonComponent3.Position=UDim2.
fromScale(0.5,0.848214)co.buttonComponent3.Size=UDim2.fromOffset(312,43)co.
button3=Instance.new('Frame')co.button3.Name='Button'co.button3.AnchorPoint=
Vector2.new(0.5,0.5)co.button3.BackgroundColor3=Color3.fromRGB(230,255,2)co.
button3.BackgroundTransparency=0.95 co.button3.Position=UDim2.fromScale(0.5,0.5)
co.button3.Size=UDim2.fromOffset(251,30)co.uICorner61=Instance.new('UICorner')co
.uICorner61.Name='UICorner'co.uICorner61.CornerRadius=UDim.new(0,3)co.uICorner61
.Parent=co.button3 co.buttonText3=Instance.new('TextLabel')co.buttonText3.Name=
'Button_Text'co.buttonText3.AnchorPoint=Vector2.new(0.5,0.5)co.buttonText3.
AutomaticSize=Enum.AutomaticSize.XY co.buttonText3.BackgroundTransparency=1 co.
buttonText3.FontFace=Font.new('rbxassetid://12187365364',Enum.FontWeight.Medium,
Enum.FontStyle.Normal)co.buttonText3.Position=UDim2.fromScale(0.5,0.5)co.
buttonText3.Size=UDim2.fromOffset(1,1)co.buttonText3.Text='Custom Color Button'
co.buttonText3.TextColor3=Color3.fromRGB(230,255,2)co.buttonText3.TextSize=13 co
.buttonText3.Parent=co.button3 co.uIStroke11=Instance.new('UIStroke')co.
uIStroke11.Name='UIStroke'co.uIStroke11.Color=Color3.fromRGB(230,255,2)co.
uIStroke11.Transparency=0.5 co.uIStroke11.Parent=co.button3 co.button3.Parent=co
.buttonComponent3 co.buttonComponent3.Parent=co.holder5 co.holder5.Parent=co.
header2 co.uICorner62=Instance.new('UICorner')co.uICorner62.Name='UICorner'co.
uICorner62.CornerRadius=UDim.new(0,6)co.uICorner62.Parent=co.header2 co.liner3=
Instance.new('Frame')co.liner3.Name='Liner'co.liner3.AnchorPoint=Vector2.new(0.5
,1)co.liner3.BackgroundColor3=Color3.fromRGB(26,26,37)co.liner3.BorderColor3=
Color3.new()co.liner3.BorderSizePixel=0 co.liner3.Position=UDim2.fromScale(0.5,1
)co.liner3.Size=UDim2.new(1,1,0,1)co.liner3.Parent=co.header2 co.headerHolder1=
Instance.new('Frame')co.headerHolder1.Name='Header_Holder'co.headerHolder1.
AnchorPoint=Vector2.new(0.5,0.5)co.headerHolder1.BackgroundTransparency=1 co.
headerHolder1.ClipsDescendants=true co.headerHolder1.Position=UDim2.fromScale(
0.5,0.5)co.headerHolder1.Size=UDim2.fromOffset(281,30)co.sectionName1=Instance.
new('TextLabel')co.sectionName1.Name='Section_Name'co.sectionName1.AnchorPoint=
Vector2.new(0,0.5)co.sectionName1.AutomaticSize=Enum.AutomaticSize.XY co.
sectionName1.BackgroundTransparency=1 co.sectionName1.FontFace=Font.new(
'rbxassetid://12187365364')co.sectionName1.Position=UDim2.new(0,35,0.5,0)co.
sectionName1.Size=UDim2.fromOffset(1,1)co.sectionName1.Text='Rage Exploits'co.
sectionName1.TextColor3=Color3.new(1,1,1)co.sectionName1.TextSize=12 co.
sectionName1.Parent=co.headerHolder1 co.line9=Instance.new('Frame')co.line9.Name
='Line'co.line9.AnchorPoint=Vector2.new(0,0.5)co.line9.BackgroundColor3=Color3.
fromRGB(199,199,199)co.line9.Position=UDim2.new(0,-3,0.5,0)co.line9.Size=UDim2.
fromOffset(6,20)co.uICorner63=Instance.new('UICorner')co.uICorner63.Name=
'UICorner'co.uICorner63.CornerRadius=UDim.new(0,30)co.uICorner63.Parent=co.line9
co.line9.Parent=co.headerHolder1 co.imageLabel3=Instance.new('ImageLabel')co.
imageLabel3.Name='ImageLabel'co.imageLabel3.AnchorPoint=Vector2.new(0,0.5)co.
imageLabel3.BackgroundTransparency=1 co.imageLabel3.Image=
'rbxassetid://115620161683984'co.imageLabel3.Position=UDim2.new(0,12,0.5,0)co.
imageLabel3.ScaleType=Enum.ScaleType.Fit co.imageLabel3.Size=UDim2.fromOffset(15
,15)co.imageLabel3.Parent=co.headerHolder1 co.toggle7=Instance.new('Frame')co.
toggle7.Name='Toggle'co.toggle7.AnchorPoint=Vector2.new(1,0.5)co.toggle7.
BackgroundColor3=Color3.fromRGB(24,25,32)co.toggle7.Position=UDim2.new(1,-12,0.5
,0)co.toggle7.Size=UDim2.fromOffset(16,16)co.uIStroke12=Instance.new('UIStroke')
co.uIStroke12.Name='UIStroke'co.uIStroke12.Color=Color3.fromRGB(28,30,38)co.
uIStroke12.Parent=co.toggle7 co.uICorner64=Instance.new('UICorner')co.uICorner64
.Name='UICorner'co.uICorner64.CornerRadius=UDim.new(0,3)co.uICorner64.Parent=co.
toggle7 co.toggle7.Parent=co.headerHolder1 co.headerHolder1.Parent=co.header2 co
.header2.Parent=co.sectionRight co.uICorner65=Instance.new('UICorner')co.
uICorner65.Name='UICorner'co.uICorner65.CornerRadius=UDim.new(0,6)co.uICorner65.
Parent=co.sectionRight co.sectionRight.Parent=co.container co.container.Parent=
co.page co.page.Parent=co.mainFrame co.mainFrame.Parent=co.ironiteion return co
end local co=game:GetService('Players')local cp=game:GetService(
'UserInputService')local cq=game:GetService('RunService')local cr=game:
GetService('HttpService')local cs=game:GetService('TweenService')local ct={}
local cu={}cu.__index=cu local cv={}cv.__index=cv local cw={}cw.__index=cw local
cx={}cx.__index=cx local cy={}cy.__index=cy local cz=Color3.fromRGB(231,231,231)
local cA=Color3.fromRGB(204,204,209)local cB=Color3.fromRGB(116,119,140)local cC
=Color3.fromRGB(24,25,32)local function cD(cE,cF,cG)local cH=Instance.new(cE)for
cI,cJ in pairs(cG or{})do cH[cI]=cJ end cH.Parent=cF return cH end local 
function cE(cF,cG,cH)local cI=cG:Connect(cH)table.insert(cF._connections,cI)
return cI end local function cF(cG)for cH,cI in ipairs(cG._connections)do cI:
Disconnect()end table.clear(cG._connections)end local function cG(cH,cI)local cJ
=cH._tweens and cH._tweens[cI]if not cJ then return end cH._tweens[cI]=nil cJ.
Connection:Disconnect()cJ.DestroyConnection:Disconnect()cJ.Tween:Cancel()end
local function cH(cI)if not cI._tweens then return end local cJ={}for cK in
pairs(cI._tweens)do table.insert(cJ,cK)end for cK,cL in ipairs(cJ)do cG(cI,cL)
end end local function cI(cJ,cK,cL,cM,cN)local cO=cJ.Window or cJ local cP=cJ.
_tweens and cJ._tweens[cK]if cP then local cQ=table.clone(cP.Goals)for cR,cS in
pairs(cL)do cQ[cR]=cS end cL=cQ end cG(cJ,cK)if cO._destroyed or cJ._destroyed
then return end if cO.Animations==false then for cQ,cR in pairs(cL)do cK[cQ]=cR
end if cN then cN()end return end cJ._tweens=cJ._tweens or{}local cQ=cs:Create(
cK,TweenInfo.new((cM or 0.16)/cO.AnimationSpeed,Enum.EasingStyle.Quint,Enum.
EasingDirection.Out),cL)local cR={Tween=cQ,Goals=cL}cJ._tweens[cK]=cR cR.
Connection=cQ.Completed:Connect(function(cS)if cJ._tweens[cK]~=cR then return
end cJ._tweens[cK]=nil cR.Connection:Disconnect()cR.DestroyConnection:
Disconnect()if cS==Enum.PlaybackState.Completed and not cO._destroyed and not cJ
._destroyed and cN then cN()end end)cR.DestroyConnection=cK.Destroying:Connect(
function()cG(cJ,cK)end)cQ:Play()end local function cJ(cK,...)if type(cK)~=
'function'then return end local cL=table.pack(...)task.spawn(function()local cM,
cN=pcall(cK,table.unpack(cL,1,cL.n))if not cM then warn('[Patch Hub callback] '
..tostring(cN))end end)end local function cK(cL)return typeof(cL)=='table'and
table.clone(cL)or cL end local function cL(cM,cN)if typeof(cM)~='table'or
typeof(cN)~='table'then return cM==cN end if#cM~=#cN then return false end for
cO,cP in ipairs(cM)do if cN[cO]~=cP then return false end end return true end
local function cM(cN)return type(cN)=='number'and cN==cN and math.abs(cN)<math.
huge end local function cN(cO,cP,cQ,cR)return cD('TextLabel',cO,{
BackgroundTransparency=1,Text=cP,TextColor3=cA,Font=Enum.Font.Gotham,TextSize=12
,TextXAlignment=Enum.TextXAlignment.Left,Position=cQ or UDim2.fromOffset(12,0),
Size=cR or UDim2.new(1,-24,1,0),TextTruncate=Enum.TextTruncate.AtEnd})end local 
function cO(cP)return cD('TextButton',cP,{Name='Input',Text='',
BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=cP.ZIndex+2,
AutoButtonColor=false})end local function cP(cQ,cR)cD('UICorner',cQ,{
CornerRadius=UDim.new(0,cR or 4)})end local function cQ(cR,cS)return cD(
'UIListLayout',cR,{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,cS or
4)})end local function cR(cS)for cT,cU in ipairs(cS:GetChildren())do if cU:IsA(
'GuiObject')then cU:Destroy()end end end local function cS(cT,cU)cT.
AutomaticSize=Enum.AutomaticSize.None cT.Size=UDim2.new(1,-cU,0,20)cT.
TextTruncate=Enum.TextTruncate.AtEnd cT.TextXAlignment=Enum.TextXAlignment.Left
end local function cT(cU)return cU.UserInputType==Enum.UserInputType.
MouseButton1 or cU.UserInputType==Enum.UserInputType.Touch end local function cU
(cV,cW,cX,cY)cX=cX or cW cW.AutoButtonColor=false local cZ=cD('Frame',cX,{Name=
'InteractionGlow',BorderSizePixel=0,BackgroundColor3=cz,BackgroundTransparency=1
,Size=UDim2.fromScale(1,1),Active=false,ZIndex=cX.ZIndex+1})cP(cZ,4)local c_,c0=
false,false local function c1()local c2=not cY or cY()cI(cV,cZ,{
BackgroundTransparency=c2 and(c0 and 0.86 or c_ and 0.96 or 1)or 1},0.12)end cE(
cV,cW.MouseEnter,function()c_=true c1()end)cE(cV,cW.MouseLeave,function()c_=
false c0=false c1()end)cE(cV,cW.SelectionGained,function()c_=true c1()end)cE(cV,
cW.SelectionLost,function()c_=false c0=false c1()end)cE(cV,cW.InputBegan,
function(c2)if cT(c2)then c0=true c1()end end)cE(cV,cW.InputEnded,function(c2)if
cT(c2)then c0=false c1()end end)cE(cV,cW.Activated,function()if cY and not cY()
then return end c0=false cI(cV,cZ,{BackgroundTransparency=0.88},0.06,c1)end)end
local function cV(cW,cX)local cY=cD('UIStroke',cX,{Color=cB,Transparency=0.8,
Thickness=1})cE(cW,cX.Focused,function()cI(cW,cY,{Color=cz,Transparency=0.15},
0.18)end)cE(cW,cX.FocusLost,function()cI(cW,cY,{Color=cB,Transparency=0.8},0.18)
end)end local function cW(cX,cY,cZ,c_)local c0=cX.Window or cX cE(cX,cY.
InputBegan,function(c1)if not cT(c1)or c0._destroyed or c0._drag or(c_ and not
c_())then return end c0._drag={Input=c1,Update=cZ}cZ(c1.Position,true)end)end
function cu:_cancelCapture()if self._capture then local cX=self._capture self.
_capture=nil if not cX._destroyed then cX:_render()end end end function cu:
_closePopup(cX)if self._popup then local cY=self._popup self._popup=nil if cY.
Owner then cY.Owner._refresh=nil end if cY.Owner and cY.Owner._popupChanged then
cY.Owner:_popupChanged(false)end cF(cY)cH(cY)if cX or self._destroyed then cY.
Frame:Destroy()else cY.Frame.Active=false cY.Frame.Interactable=false cI(self,cY
.Panel,{GroupTransparency=1},0.12)cI(self,cY.Scale,{Scale=0.96},0.12)cI(self,cY.
Frame,{BackgroundTransparency=1},0.13,function()cY.Frame:Destroy()end)end end
self._drag=nil end function cu:_openPopup(cX,cY,cZ)self:_closePopup(true)self:
_cancelCapture()local c_=cD('TextButton',self.Frame,{Name='Popup',Text='',
AutoButtonColor=false,Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(),
BackgroundTransparency=1,ZIndex=50})local c0=cD('CanvasGroup',c_,{Active=true,
GroupTransparency=1,BackgroundColor3=Color3.fromRGB(19,20,25),AnchorPoint=
Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(290
,cZ),ZIndex=51})cP(c0,7)cD('UIStroke',c0,{Color=Color3.fromRGB(50,52,66)})cN(c0,
cY,UDim2.fromOffset(12,7),UDim2.new(1,-45,0,25))local c1=cD('TextButton',c0,{
Text='X',Font=Enum.Font.Gotham,TextSize=12,TextColor3=cA,BackgroundTransparency=
1,Position=UDim2.new(1,-32,0,4),Size=UDim2.fromOffset(28,28)})local c2={
_connections={},Frame=c_,Panel=c0,Owner=cX,Window=self}c2.Scale=cD('UIScale',c0,
{Scale=0.96})self._popup=c2 cE(c2,c_.Activated,function()self:_closePopup()end)
cE(c2,c1.Activated,function()self:_closePopup()end)cU(c2,c1)cI(c2,c_,{
BackgroundTransparency=0.35},0.2)cI(c2,c0,{GroupTransparency=0},0.2)cI(c2,c2.
Scale,{Scale=1},0.24)return c2 end function ct:CreateWindow(cX)cX=cX or{}assert(
cq:IsClient(),'Patch Hub must be required from a LocalScript on the client')
local cY=co.LocalPlayer assert(cY,'Patch Hub requires a LocalPlayer')local cZ=
cn()local c_=setmetatable({_connections={},Tabs={},Controls={},Flags={},
_keybinds={},_templates={},_nextId=0,_destroyed=false,_visible=true,Animations=
cX.Animations~=false,AnimationSpeed=math.clamp(tonumber(cX.AnimationSpeed)or 1,
0.25,4),ToggleKey=cX.ToggleKey or Enum.KeyCode.RightShift,Accent=cX.Accent or cz
,Gui=cZ.ironiteion,Frame=cZ.mainFrame,_design=cZ},cu)c_.Gui.Name=cX.Name or
'Patch Hub'c_.Gui.ResetOnSpawn=false c_.Gui.IgnoreGuiInset=true c_.Gui.
ScreenInsets=Enum.ScreenInsets.None c_.Gui.DisplayOrder=cX.DisplayOrder or 50 c_
.Gui.Parent=cX.Parent or cY:WaitForChild('PlayerGui')c_.PositionRoot=cD('Frame',
c_.Gui,{Name='WindowPosition',BackgroundTransparency=1,Size=UDim2.fromOffset(0,0
),Position=UDim2.fromScale(0.5,0.5),Active=false})c_.Frame.Parent=c_.
PositionRoot c_.Frame.Position=UDim2.fromOffset(0,0)c_.Frame.BorderSizePixel=0
cZ.libaryName.RichText=false cZ.libaryName.Text=cX.Title or'Patch Hub'cZ.
libaryName.AutomaticSize=Enum.AutomaticSize.None cZ.libaryName.Size=UDim2.
fromOffset(320,24)cZ.libaryName.TextXAlignment=Enum.TextXAlignment.Left cZ.
libaryName.TextTruncate=Enum.TextTruncate.AtEnd cZ.lastUpdated.RichText=false cZ
.lastUpdated.Text=cX.Subtitle or'UI Library'cZ.lastUpdated.AutomaticSize=Enum.
AutomaticSize.None cZ.lastUpdated.Size=UDim2.fromOffset(210,24)cZ.lastUpdated.
TextXAlignment=Enum.TextXAlignment.Right cZ.lastUpdated.TextTruncate=Enum.
TextTruncate.AtEnd cZ.lastUpdated.Position=UDim2.new(1,-48,0.5,0)cZ.icon.Visible
=false local c0={Tab=cZ.tab,SubTab=cZ.subTab,Section=cZ.sectionLeft,Toggle=cZ.
toggleComponent1,Slider=cZ.sliderComponent,Keybind=cZ.keybindComponent,Dropdown=
cZ.dropdownComponent,Button=cZ.buttonComponent}for c1,c2 in pairs(c0)do c_.
_templates[c1]=c2:Clone()end cR(c_._templates.Section.Header.Holder)cR(cZ.holder
)cR(cZ.subHeader)cZ.page:Destroy()cZ.holder:Destroy()c_.Sidebar=cD(
'ScrollingFrame',cZ.sidebar,{Name='Tabs',BackgroundTransparency=1,
BorderSizePixel=0,Size=UDim2.new(1,-2,1,0),CanvasSize=UDim2.new(),
AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=2})cQ(c_.Sidebar,10)
cD('UIPadding',c_.Sidebar,{PaddingTop=UDim.new(0,10),PaddingLeft=UDim.new(0,9),
PaddingBottom=UDim.new(0,10)})cZ.subHeader:Destroy()c_.SubHeader=cD(
'ScrollingFrame',c_.Frame,{Name='Sub-Header',BackgroundTransparency=1,
BorderSizePixel=0,Position=UDim2.fromOffset(75,37),Size=UDim2.fromOffset(620,51)
,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.X,
ScrollBarThickness=2,ScrollingDirection=Enum.ScrollingDirection.X})local c1=cQ(
c_.SubHeader,10)c1.FillDirection=Enum.FillDirection.Horizontal c1.
VerticalAlignment=Enum.VerticalAlignment.Center cD('UIPadding',c_.SubHeader,{
PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12)})c_.Content=cD('Frame',c_
.Frame,{Name='Pages',BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(16,17,21)
,ClipsDescendants=true,Position=UDim2.fromOffset(75,88),Size=UDim2.fromOffset(
620,401)})c_.Scale=cD('UIScale',c_.Frame,{Scale=1})c_._zoom=cD('NumberValue',c_.
Gui,{Name='OpenAnimation',Value=1})c_._baseScale=1 cE(c_,c_._zoom:
GetPropertyChangedSignal('Value'),function()c_.Scale.Scale=c_._baseScale*c_.
_zoom.Value end)c_.Bounds=cD('Frame',c_.Gui,{Name='ViewportBounds',
BackgroundTransparency=1,Size=UDim2.fromScale(1,1),Active=false,ZIndex=0})local 
function c2()local c3=c_.Bounds.AbsoluteSize if c3.X<1 or c3.Y<1 then return end
c_._baseScale=math.min(1,math.max(0.05,(c3.X-16)/695),math.max(0.05,(c3.Y-16)/
489))c_.Scale.Scale=c_._baseScale*c_._zoom.Value local c4=c_.PositionRoot.
Position local c5,c6=c4.X.Scale*c3.X+c4.X.Offset,c4.Y.Scale*c3.Y+c4.Y.Offset
local c7,c8=695*c_._baseScale/2,489*c_._baseScale/2 local c9=math.clamp(c5,c7,
math.max(c7,c3.X-c7))local da=math.clamp(c6,c8,math.max(c8,c3.Y-c8))if c9~=c5 or
da~=c6 then c_.PositionRoot.Position=UDim2.new(c4.X.Scale,c9-c4.X.Scale*c3.X,c4.
Y.Scale,da-c4.Y.Scale*c3.Y)end c_._drag=nil end cE(c_,c_.Bounds:
GetPropertyChangedSignal('AbsoluteSize'),c2)c2()local c3=cD('TextButton',cZ.
header,{Name='Hide',Text='X',Font=Enum.Font.Gotham,TextSize=12,TextColor3=cB,
BackgroundTransparency=1,Position=UDim2.new(1,-36,0,3),Size=UDim2.fromOffset(30,
30),ZIndex=5})cE(c_,c3.Activated,function()c_:SetVisible(false)end)cU(c_,c3)c_.
Restore=cD('TextButton',c_.Gui,{Name='Restore',Text=cX.Title or'Patch Hub',Font=
Enum.Font.Gotham,TextSize=13,TextColor3=cz,BackgroundColor3=cC,Position=UDim2.
fromOffset(12,60),Size=UDim2.fromOffset(110,32),Visible=false})cP(c_.Restore,6)
cE(c_,c_.Restore.Activated,function()c_:SetVisible(true)end)cU(c_,c_.Restore)
local c4,c5,c6 c_.DragHandle=cD('TextButton',cZ.header,{Name='DragHandle',Text=
'',AutoButtonColor=false,BackgroundTransparency=1,Size=UDim2.new(1,-40,1,0),
ZIndex=4})cW(c_,c_.DragHandle,function(c7,c8)if c8 then c4=c7 c5=c_.PositionRoot
.Position c6=false return end local c9,da=c7.X-c4.X,c7.Y-c4.Y if not c6 and c9*
c9+da*da<16 then return end c6=true local db=c_.Bounds.AbsoluteSize local dc,dd=
695*c_._baseScale/2,489*c_._baseScale/2 local de=c5.X.Scale*db.X+c5.X.Offset+c9
local df=c5.Y.Scale*db.Y+c5.Y.Offset+da de=math.clamp(de,dc,math.max(dc,db.X-dc)
)df=math.clamp(df,dd,math.max(dd,db.Y-dd))c_.PositionRoot.Position=UDim2.new(c5.
X.Scale,de-c5.X.Scale*db.X,c5.Y.Scale,df-c5.Y.Scale*db.Y)end,function()return c_
._visible and not c_._popup end)cE(c_,cp.InputChanged,function(c7)local c8=c_.
_drag if c8 and(c7==c8.Input or(c8.Input.UserInputType==Enum.UserInputType.
MouseButton1 and c7.UserInputType==Enum.UserInputType.MouseMovement))then c8.
Update(c7.Position,false)end end)cE(c_,cp.InputEnded,function(c7)local c8=c_.
_drag if c8 and(c7==c8.Input or(c7.UserInputType==Enum.UserInputType.
MouseButton1 and c8.Input.UserInputType==c7.UserInputType))then c_._drag=nil end
end)cE(c_,cp.WindowFocusReleased,function()c_._drag=nil c_:_cancelCapture()end)
cE(c_,cp.InputBegan,function(c7,c8)if c_._capture then if c7.UserInputType~=Enum
.UserInputType.Keyboard then return end local c9=c_._capture c_._capture=nil if
c7.KeyCode==Enum.KeyCode.Escape then c9:_render()elseif c7.KeyCode==Enum.KeyCode
.Backspace or c7.KeyCode==Enum.KeyCode.Delete then c9:Set(nil)else c9:Set(c7.
KeyCode)end return end if c8 or cp:GetFocusedTextBox()then return end if c7.
KeyCode==c_.ToggleKey then c_:Toggle()return end if c_._popup and c7.KeyCode==
Enum.KeyCode.Escape then c_:_closePopup()return end for c9 in pairs(c_._keybinds
)do if c9._value==c7.KeyCode and c9:_interactive()then cJ(c9._callback,c7.
KeyCode)end end end)cE(c_,c_.Gui.Destroying,function()c_:Destroy()end)c_.Frame.
GroupTransparency=1 c_._zoom.Value=0.96 cI(c_,c_.Frame,{GroupTransparency=0},
0.26)cI(c_,c_._zoom,{Value=1},0.3)return c_ end function cu:SetVisible(cX)if
self._destroyed then return end self:_closePopup(true)self:_cancelCapture()self.
_visible=cX==true self.Restore.Visible=not self._visible if self._visible then
self.Frame.Visible=true end cI(self,self._zoom,{Value=self._visible and 1 or
0.96},0.22)cI(self,self.Frame,{GroupTransparency=self._visible and 0 or 1},0.2,
function()if not self._visible then self.Frame.Visible=false end end)end
function cu:Toggle()self:SetVisible(not self._visible)end function cu:Destroy()
if self._destroyed then return end self._destroyed=true self:_closePopup()self:
_cancelCapture()local cX={}for cY,cZ in pairs(self.Controls)do table.insert(cX,
cZ)end for cY,cZ in ipairs(cX)do cZ:Destroy()end cF(self)cH(self)for cY,cZ in
pairs(self._templates)do cZ:Destroy()end self.Gui:Destroy()table.clear(self.Tabs
)table.clear(self._keybinds)self._design=nil end function cu:CreateTab(cX)
assert(not self._destroyed,'Window is destroyed')if type(cX)=='string'then cX={
Name=cX}end cX=cX or{}local cY=self._templates.Tab:Clone()cY.LayoutOrder=#self.
Tabs+1 cY.Name=cX.Name or'Tab'cY.Icon.TextLabel.Text=cY.Name cY.Icon.TextLabel.
AutomaticSize=Enum.AutomaticSize.None cY.Icon.TextLabel.Size=UDim2.fromOffset(53
,18)cY.Icon.TextLabel.TextTruncate=Enum.TextTruncate.AtEnd if cX.Icon then cY.
Icon.Image=tostring(cX.Icon):match('^%d+$')and'rbxassetid://'..cX.Icon or cX.
Icon end cY.Parent=self.Sidebar local cZ=setmetatable({Window=self,Frame=cY,
Pages={},Name=cY.Name},cv)table.insert(self.Tabs,cZ)local c_=cO(cY)cU(self,c_,cY
)cE(self,c_.Activated,function()if self._visible then cZ:Select()end end)if not
self.ActiveTab then cZ:Select()else cY.BackgroundTransparency=1 cY.Frame.
BackgroundTransparency=1 end return cZ end function cv:Select()local cX=self.
Window cX:_closePopup()cX:_cancelCapture()cX.ActiveTab=self for cY,cZ in ipairs(
cX.Tabs)do local c_=cZ==self cI(cX,cZ.Frame,{BackgroundTransparency=c_ and 0.9
or 1},0.18)cZ.Frame.Frame.Visible=true cI(cX,cZ.Frame.Frame,{
BackgroundTransparency=c_ and 0 or 1,Size=UDim2.fromOffset(c_ and 25 or 8,6)},
0.2)cI(cX,cZ.Frame.Icon,{ImageColor3=c_ and cz or cB},0.18)cI(cX,cZ.Frame.Icon.
TextLabel,{TextColor3=c_ and cz or cB},0.18)for c0,c1 in ipairs(cZ.Pages)do c1.
Button.Visible=c_ c1.Frame.Visible=c_ and c1==cZ.ActivePage end end if self.
ActivePage then self.ActivePage:Select()end cX.SubHeader.CanvasPosition=Vector2.
new()end function cv:CreateSubTab(cX)if type(cX)=='string'then cX={Name=cX}end
cX=cX or{}local cY=self.Window local cZ=cY._templates.SubTab:Clone()cZ.Name=cX.
Name or'Page'cZ.AutomaticSize=Enum.AutomaticSize.None cZ.Size=UDim2.fromOffset(
cX.Width or 105,30)cZ.TabName.Text=cZ.Name cZ.TabName.AutomaticSize=Enum.
AutomaticSize.None cZ.TabName.Size=UDim2.fromScale(1,1)cZ.TabName.Position=UDim2
.new()cZ.TabName.AnchorPoint=Vector2.new()cZ.TabName.TextTruncate=Enum.
TextTruncate.AtEnd cZ.TabName.UIPadding.PaddingTop=UDim.new(0,3)cZ.TabName.
UIPadding.PaddingBottom=UDim.new(0,3)cZ.LayoutOrder=#self.Pages+1 cZ.Visible=cY.
ActiveTab==self cZ.Parent=cY.SubHeader local c_=cD('CanvasGroup',cY.Content,{
Name=cZ.Name..'Transition',BackgroundTransparency=1,Size=UDim2.fromScale(1,1),
GroupTransparency=0})local c0=cD('ScrollingFrame',c_,{Name=cZ.Name,
BackgroundTransparency=1,BorderSizePixel=0,Size=UDim2.fromScale(1,1),CanvasSize=
UDim2.new(),ScrollBarThickness=3,ScrollBarImageColor3=cB,Visible=false,
ScrollingDirection=Enum.ScrollingDirection.Y})local c1=setmetatable({Window=cY,
Tab=self,Button=cZ,Frame=c0,Layer=c_,Sections={}},cw)c1.Left=cD('Frame',c0,{Name
='Left',BackgroundTransparency=1,Position=UDim2.fromOffset(12,12),Size=UDim2.
new(0.5,-22,0,0)})c1.Right=cD('Frame',c0,{Name='Right',BackgroundTransparency=1,
Position=UDim2.new(0.5,0,0,12),Size=UDim2.new(0.5,-22,0,0)})local c2,c3=cQ(c1.
Left,12),cQ(c1.Right,12)local function c4()local function c5(c6)local c7,c8=0,0
for c9,da in ipairs(c6:GetChildren())do if da:IsA('GuiObject')and da.Visible
then c7=c7+da.Size.Y.Offset c8=c8+1 end end return c7+math.max(0,c8-1)*12 end
local c6,c7=c5(c1.Left),c5(c1.Right)c1.Left.Size=UDim2.new(0.5,-22,0,c6)c1.Right
.Size=UDim2.new(0.5,-22,0,c7)c0.CanvasSize=UDim2.fromOffset(0,math.max(c6,c7)+24
)end cE(cY,c2:GetPropertyChangedSignal('AbsoluteContentSize'),c4)cE(cY,c3:
GetPropertyChangedSignal('AbsoluteContentSize'),c4)table.insert(self.Pages,c1)
local c5=cO(cZ)cU(cY,c5,cZ)cE(cY,c5.Activated,function()if cY._visible then c1:
Select()end end)if not self.ActivePage then self.ActivePage=c1 end if cY.
ActiveTab==self then self.ActivePage:Select()end return c1 end function cv:
CreateSection(cX)if not self.ActivePage then self:CreateSubTab('General')end
return self.ActivePage:CreateSection(cX)end function cw:Select()local cX=self.
Window if cX.ActiveTab~=self.Tab then self.Tab:Select()end cX:_closePopup()cX:
_cancelCapture()self.Tab.ActivePage=self for cY,cZ in ipairs(self.Tab.Pages)do
local c_=cZ==self cZ.Frame.Visible=c_ cI(cX,cZ.Button.TabName,{
BackgroundTransparency=c_ and 0.9 or 1,TextColor3=c_ and cz or cB},0.18)cZ.
Button.Holder.Visible=true cI(cX,cZ.Button.Holder,{BackgroundTransparency=c_ and
0 or 1,Size=UDim2.fromOffset(c_ and 34 or 10,6)},0.2)end cG(cX,self.Layer)cG(cX,
self.Frame)self.Layer.GroupTransparency=cX.Animations and 0.5 or 0 self.Frame.
Position=UDim2.fromOffset(cX.Animations and 10 or 0,0)cI(cX,self.Layer,{
GroupTransparency=0},0.2)cI(cX,self.Frame,{Position=UDim2.fromOffset(0,0)},0.24)
end function cw:CreateSection(cX)if type(cX)=='string'then cX={Name=cX}end cX=cX
or{}local cY=self.Window local cZ=cY._templates.Section:Clone()cZ.Name=cX.Name
or'Section'cZ.AutomaticSize=Enum.AutomaticSize.None cZ.Size=UDim2.new(1,0,0,45)
cZ.BorderSizePixel=0 cZ.Header.Size=UDim2.new(1,0,0,30)cZ.Header.Position=UDim2.
fromScale(0.5,0)local c_=cZ.Header.Header_Holder c_.Size=UDim2.new(1,0,0,30)c_.
Section_Name.Text=cZ.Name cS(c_.Section_Name,70)if cX.Icon then c_.ImageLabel.
Image=tostring(cX.Icon):match('^%d+$')and'rbxassetid://'..cX.Icon or cX.Icon end
local c0=cZ.Header.Holder c0.AutomaticSize=Enum.AutomaticSize.None c0.
AnchorPoint=Vector2.new()c0.Position=UDim2.fromOffset(0,30)c0.Size=UDim2.new(1,0
,0,0)c0.Parent=cZ c0.UIPadding.PaddingBottom=UDim.new(0,8)local c1=setmetatable(
{Window=cY,Page=self,Frame=cZ,Body=c0,Enabled=cX.Enabled~=false,Controls={},
_callback=cX.Callback},cx)cZ.LayoutOrder=#self.Sections+1 cZ.Parent=cX.Side==
'Right'and self.Right or self.Left table.insert(self.Sections,c1)local function 
c2()local c3,c4=13,0 for c5,c6 in ipairs(c0:GetChildren())do if c6:IsA(
'GuiObject')and c6.Visible then c3=c3+c6.Size.Y.Offset c4=c4+1 end end c3=c3+
math.max(0,c4-1)*4 c0.Size=UDim2.new(1,0,0,c3)cZ.Size=UDim2.new(1,0,0,30+c3)end
cE(cY,c0.UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'),c2)local
c3=cO(c_.Toggle)cU(cY,c3,c_.Toggle)cE(cY,c3.Activated,function()if cY._visible
then c1:SetEnabled(not c1.Enabled)end end)c1:SetEnabled(c1.Enabled,true)c2()
return c1 end function cx:SetEnabled(cX,cY)self.Enabled=cX==true local cZ=self.
Frame.Header.Header_Holder.Toggle cI(self.Window,cZ,{BackgroundColor3=self.
Enabled and self.Window.Accent or cC},0.18)cZ.Check_Icon.Visible=true cI(self.
Window,cZ.Check_Icon,{ImageTransparency=self.Enabled and 0 or 1,Size=UDim2.
fromOffset(self.Enabled and 8 or 3,self.Enabled and 7 or 3)},0.16)cI(self.Window
,self.Frame,{BackgroundColor3=self.Enabled and Color3.fromRGB(17,18,22)or Color3
.fromRGB(21,22,28)},0.2)for c_,c0 in ipairs(self.Controls)do if not c0.
_destroyed then c0:_enabledVisual()end end if not self.Enabled then self.Window:
_closePopup()self.Window:_cancelCapture()end if not cY then cJ(self._callback,
self.Enabled)end end function cy:_interactive()return not self._destroyed and
not self.Window._destroyed and self.Enabled and self.Section.Enabled and self.
Frame.Visible and self.Window.Gui.Enabled and self.Window._visible and self.
Section.Page.Frame.Visible and not self.Window._popup end function cy:
_enabledVisual()if self._label then cI(self,self._label,{TextColor3=self.Enabled
and self.Section.Enabled and cA or cB},0.16)end end function cy:Get()return cK(
self._value)end function cy:_commit(cX,cY)local cZ=self._value local c_=cL(cZ,cX
)self._value=cK(cX)self.Window.Flags[self.Id]=cK(cX)self:_render()if not c_ and
not cY then if self.Kind=='Keybind'then cJ(self._changed,self:Get())else cJ(self
._callback,self:Get())end end return self end function cy:Set(cX,cY)assert(not
self._destroyed,'Control is destroyed')return self:_commit(self:_normalize(cX),
cY)end function cy:SetEnabled(cX)self.Enabled=cX==true self:_enabledVisual()if
not self.Enabled then if self.Window._popup and self.Window._popup.Owner==self
then self.Window:_closePopup()end if self.Window._capture==self then self.Window
:_cancelCapture()end self.Window._drag=nil end return self end function cy:
SetVisible(cX)self.Frame.Visible=cX==true if not self.Frame.Visible then if self
.Window._popup and self.Window._popup.Owner==self then self.Window:_closePopup()
end if self.Window._capture==self then self.Window:_cancelCapture()end self.
Window._drag=nil end return self end function cy:SetText(cX)self.Name=tostring(
cX)if self._label then local cY=self._label.Text~=self.Name self._label.Text=
self.Name if cY then self._label.TextTransparency=self.Window.Animations and 0.4
or 0 cI(self,self._label,{TextTransparency=0,TextColor3=self.Enabled and self.
Section.Enabled and cA or cB},0.18)end end return self end function cy:Destroy()
if self._destroyed then return end if self.Window._popup and self.Window._popup.
Owner==self then self.Window:_closePopup()end if self.Window._capture==self then
self.Window:_cancelCapture()end self.Window._drag=nil self._destroyed=true cF(
self)cH(self)self.Window.Controls[self.Id]=nil self.Window.Flags[self.Id]=nil
self.Window._keybinds[self]=nil self.Frame:Destroy()end function cx:_control(cX,
cY)cY=cY or{}local cZ=self.Window assert(not cZ._destroyed,'Window is destroyed'
)cZ._nextId=cZ._nextId+1 local c_=cY.Id or('control_'..cZ._nextId)assert(type(c_
)=='string'and not cZ.Controls[c_],'Control Id must be a unique string: '..
tostring(c_))local c0=cZ._templates[cX]local c1=c0 and c0:Clone()or cD('Frame',
nil,{BackgroundTransparency=1,Size=UDim2.fromOffset(281,36)})c1.Name=cY.Name or
cX c1.AnchorPoint=Vector2.new()c1.Position=UDim2.new()c1.Size=UDim2.new(1,0,0,c1
.Size.Y.Offset)c1.LayoutOrder=#self.Controls+1 c1.Parent=self.Body local c2=
setmetatable({Window=cZ,Section=self,Frame=c1,Id=c_,Kind=cX,Name=c1.Name,Enabled
=cY.Enabled~=false,_connections={},_callback=cY.Callback,_changed=cY.Changed,
_destroyed=false},cy)cZ.Controls[c_]=c2 table.insert(self.Controls,c2)return c2
end function cx:AddToggle(cX)cX=cX or{}local cY=self:_control('Toggle',cX)local
cZ,c_=cY.Frame,self.Window cZ.ColorFrame:Destroy()cZ.Toggle.Position=UDim2.new(0
,12,0.5,0)cZ.Toggle_Name.Position=UDim2.new(0,35,0.5,0)cS(cZ.Toggle_Name,cX.
Color and 80 or 47)cY._label=cZ.Toggle_Name cY:SetText(cY.Name)function cY:
_normalize(c0)assert(type(c0)=='boolean','Toggle expects a boolean')return c0
end function cY:_render()cI(self,cZ.Toggle,{BackgroundColor3=self._value and c_.
Accent or cC},0.16)cZ.Toggle.Check_Icon.Visible=true cI(self,cZ.Toggle.
Check_Icon,{ImageTransparency=self._value and 0 or 1,Size=UDim2.fromOffset(self.
_value and 8 or 3,self._value and 7 or 3)},0.18)self:_enabledVisual()end local
c0=cO(cZ)if cX.Color then c0.Size=UDim2.new(1,-48,1,0)end cU(cY,c0,c0,function()
return cY:_interactive()end)cE(cY,c0.Activated,function()if cY:_interactive()
then cY:Set(not cY:Get())end end)cY:Set(cX.Default==true,true)if cX.Color then
local c1=cD('TextButton',cZ,{Name='Color',Text='',BackgroundColor3=cX.Color,
AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-12,0.5,0),Size=UDim2.
fromOffset(24,14),ZIndex=4})cP(c1,3)cU(cY,c1,c1,function()return cY:
_interactive()end)cY._color=cX.Color function cY:GetColor()return self._color
end function cY:SetColor(c2,c3)assert(typeof(c2)=='Color3',
'Color must be a Color3')local c4=self._color~=c2 self._color=c2 cI(self,c1,{
BackgroundColor3=c2},0.12)if c4 and not c3 then cJ(cX.ColorCallback,c2)end end
cE(cY,c1.Activated,function()if cY:_interactive()then c_:_colorPopup(cY,cY.
_color,function(c2)cY:SetColor(c2)end)end end)end return cY end function cx:
AddSlider(cX)cX=cX or{}local cY,cZ,c_=cX.Min or 0,cX.Max or 100,cX.Step or 1
assert(cM(cY)and cM(cZ)and cM(c_)and cZ>cY and c_>0,
'Slider requires finite Min < Max and Step > 0')local c0=self:_control('Slider',
cX)local c1=c0.Frame c1.Slider_Text.Position=UDim2.new(0,12,0.5,-8)cS(c1.
Slider_Text,90)c1.Value.Position=UDim2.new(1,-12,0.5,-8)c0._label=c1.Slider_Text
c0:SetText(c0.Name)local c2=c1.Progress_BG c2.Position=UDim2.new(0,12,1,-7)c2.
Size=UDim2.new(1,-24,0,4)local c3=cX.Decimals if c3==nil then c3=0 while c3<6
and math.abs(c_*10^c3-math.floor(c_*10^c3+0.5))>0.000001 do c3=c3+1 end end
assert(cM(c3)and c3>=0 and c3<=6 and c3%1==0,
'Decimals must be an integer from 0 to 6')function c0:_normalize(c4)assert(cM(c4
),'Slider expects a finite number')c4=math.clamp(c4,cY,cZ)if c4==cZ then return
cZ end return math.clamp(cY+math.floor((c4-cY)/c_+0.5)*c_,cY,cZ)end function c0:
_render()cI(self,c2.Progress,{Size=UDim2.new((self._value-cY)/(cZ-cY),0,0,7),
BackgroundColor3=self.Window.Accent},self.Window._drag and 0.06 or 0.2)c1.Value.
Text=string.format('%.'..c3..'f',self._value)..(cX.Suffix or'')self:
_enabledVisual()end local c4=cO(c2)c4.Size=UDim2.new(1,0,0,22)c4.Position=UDim2.
fromOffset(0,-9)cU(c0,c4,c4,function()return c0:_interactive()end)cE(c0,c4.
MouseEnter,function()if c0:_interactive()then cI(c0,c2.Progress.Pointer,{Size=
UDim2.fromOffset(9,9)},0.12)end end)cE(c0,c4.MouseLeave,function()cI(c0,c2.
Progress.Pointer,{Size=UDim2.fromOffset(6,6)},0.12)end)cW(c0,c4,function(c5)if
not c0:_interactive()then return end local c6=math.clamp((c5.X-c2.
AbsolutePosition.X)/math.max(1,c2.AbsoluteSize.X),0,1)c0:Set(cY+(cZ-cY)*c6)end,
function()return c0:_interactive()end)cE(c0,c4.InputBegan,function(c5)if not c0:
_interactive()then return end if c5.KeyCode==Enum.KeyCode.Left then c0:Set(c0:
Get()-c_)elseif c5.KeyCode==Enum.KeyCode.Right then c0:Set(c0:Get()+c_)end end)
c0:Set(cX.Default or cY,true)return c0 end function cx:AddButton(cX)cX=cX or{}
local cY=self:_control('Button',cX)local cZ=cY.Frame.Button cZ.Size=UDim2.new(1,
-24,0,30)cY._label=cZ.Button_Text cY:SetText(cY.Name)cZ.Button_Text.
AutomaticSize=Enum.AutomaticSize.None cZ.Button_Text.Size=UDim2.new(1,-12,1,0)cZ
.Button_Text.TextTruncate=Enum.TextTruncate.AtEnd if cX.Color then cZ.UIStroke.
Color=cX.Color cZ.BackgroundColor3=cX.Color cZ.BackgroundTransparency=0.95 end
function cY:_enabledVisual()cI(self,self._label,{TextColor3=self.Enabled and
self.Section.Enabled and(cX.Color or cA)or cB},0.16)end function cY:_render()
self:_enabledVisual()end function cY:Press()if self:_interactive()then cJ(self.
_callback)end end local c_=cO(cZ)cU(cY,c_,cZ,function()return cY:_interactive()
end)cE(cY,c_.Activated,function()cY:Press()end)cE(cY,c_.MouseEnter,function()if
cY:_interactive()then if cX.Color then cI(cY,cZ,{BackgroundTransparency=0.85},
0.16)else cI(cY,cZ,{BackgroundColor3=Color3.fromRGB(33,35,45)},0.16)end end end)
cE(cY,c_.MouseLeave,function()if cX.Color then cI(cY,cZ,{BackgroundTransparency=
0.95},0.16)else cI(cY,cZ,{BackgroundColor3=cC},0.16)end end)cY:_render()return
cY end function cx:AddKeybind(cX)cX=cX or{}local cY=self:_control('Keybind',cX)
local cZ=cY.Frame cZ.Holder:Destroy()cZ.Toggle_Name.Position=UDim2.new(0,12,0.5,
0)cS(cZ.Toggle_Name,120)cY._label=cZ.Toggle_Name cY:SetText(cY.Name)local c_=cD(
'TextButton',cZ,{Text='NONE',BackgroundColor3=cC,TextColor3=cz,Font=Enum.Font.
GothamMedium,TextSize=10,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-12
,0.5,0),Size=UDim2.fromOffset(98,24)})cP(c_)cU(cY,c_,c_,function()return cY:
_interactive()end)function cY:_normalize(c0)if c0==nil or c0=='NONE'or c0==Enum.
KeyCode.Unknown then return nil end if type(c0)=='string'then local c1,c2=pcall(
function()return Enum.KeyCode[c0]end)assert(c1 and c2,'Unknown key name: '..c0)
c0=c2 end assert(typeof(c0)=='EnumItem'and c0.EnumType==Enum.KeyCode,
'Keybind expects an Enum.KeyCode or nil')if c0==Enum.KeyCode.Unknown then return
nil end return c0 end function cY:_render()c_.Text=self._value and self._value.
Name or'NONE'cI(self,c_,{BackgroundColor3=cC,TextColor3=cz},0.18)self:
_enabledVisual()end cE(cY,c_.Activated,function()if not cY:_interactive()then
return end cY.Window:_cancelCapture()cY.Window._capture=cY c_.Text=
'Press a key...'cI(cY,c_,{BackgroundColor3=Color3.fromRGB(49,51,64),TextColor3=
cY.Window.Accent},0.18)end)self.Window._keybinds[cY]=true cY:Set(cX.Default,true
)return cY end function cx:AddDropdown(cX)cX=cX or{}local cY=self:_control(
'Dropdown',cX)local cZ=cY.Frame cZ.Dropdown_Name.Position=UDim2.fromOffset(12,2)
cS(cZ.Dropdown_Name,24)cY._label=cZ.Dropdown_Name cY:SetText(cY.Name)cZ.Holder.
Size=UDim2.new(1,-24,0,25)cZ.Holder.Position=UDim2.new(0.5,0,1,-3)cS(cZ.Holder.
Options,28)cZ.Holder.Options.Position=UDim2.new(0,8,0.5,0)local c_=cN(cZ.Holder,
'v',UDim2.new(1,-18,0,0),UDim2.fromOffset(15,25))c_.TextXAlignment=Enum.
TextXAlignment.Center function cY:_popupChanged(c0)cI(self,c_,{Rotation=c0 and
180 or 0},0.18)end cY.Multi=cX.Multi==true cY.Options={}local function c0(c1)
assert(type(c1)=='table','Dropdown Options must be an array of strings')local c2
,c3={},{}for c4,c5 in ipairs(c1)do assert(type(c5)=='string',
'Dropdown options must be strings')if not c3[c5]then table.insert(c2,c5)c3[c5]=
true end end return c2 end function cY:_normalize(c1)if self.Multi then assert(
type(c1)=='table','Multi dropdown expects an array')local c2,c3={},{}for c4,c5
in ipairs(c1)do assert(table.find(self.Options,c5),'Unknown dropdown option: '..
tostring(c5))c2[c5]=true end for c4,c5 in ipairs(self.Options)do if c2[c5]then
table.insert(c3,c5)end end return c3 end assert(c1==nil or table.find(self.
Options,c1),'Unknown dropdown option: '..tostring(c1))return c1 end function cY:
_render()cZ.Holder.Options.Text=self.Multi and(#self._value>0 and table.concat(
self._value,', ')or'Select...')or(self._value or'Select...')self:_enabledVisual(
)if self._refresh then self._refresh()end end function cY:SetOptions(c1,c2)local
c3=c0(c1)self.Window:_closePopup()self.Options=c3 local c4=self:Get()if self.
Multi then local c5={}for c6,c7 in ipairs(c4 or{})do if table.find(c3,c7)then
table.insert(c5,c7)end end self:Set(c5,c2)else self:Set(table.find(c3,c4)and c4
or nil,c2)end return self end cY.Options=c0(cX.Options or{})cY:Set(cX.Default or
(cY.Multi and{}or nil),true)local c1=cO(cZ.Holder)cU(cY,c1,cZ.Holder,function()
return cY:_interactive()end)cE(cY,c1.Activated,function()if not cY:_interactive(
)then return end local c2=cY.Window:_openPopup(cY,cY.Name,310)cY:_popupChanged(
true)local c3=cD('TextBox',c2.Panel,{PlaceholderText='Search options...',Text=''
,ClearTextOnFocus=false,BackgroundColor3=cC,TextColor3=cA,PlaceholderColor3=cB,
Font=Enum.Font.Gotham,TextSize=12,Position=UDim2.fromOffset(12,40),Size=UDim2.
new(1,-24,0,28)})cP(c3)cV(c2,c3)local c4=cD('ScrollingFrame',c2.Panel,{
BackgroundTransparency=1,BorderSizePixel=0,Position=UDim2.fromOffset(12,76),Size
=UDim2.new(1,-24,1,-88),CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.
AutomaticSize.Y,ScrollBarThickness=3})cQ(c4,4)local c5={}for c6,c7 in ipairs(cY.
Options)do local c8=cD('TextButton',c4,{Text=c7,Font=Enum.Font.Gotham,TextSize=
12,TextColor3=cA,BackgroundColor3=cC,Size=UDim2.new(1,-5,0,28),LayoutOrder=c6,
TextTruncate=Enum.TextTruncate.AtEnd})cP(c8)cU(c2,c8)table.insert(c5,{Button=c8,
Value=c7})cE(c2,c8.Activated,function()if cY.Multi then local c9=cY:Get()local
da=table.find(c9,c7)if da then table.remove(c9,da)else table.insert(c9,c7)end cY
:Set(c9)else cY:Set(c7)cY.Window:_closePopup()end end)end local c6=cN(c4,
'No matching options',UDim2.new(),UDim2.new(1,-5,0,28))c6.LayoutOrder=#c5+1
local function c7()if cY.Window._popup~=c2 then return end local c8=0 for c9,da
in ipairs(c5)do local db=cY.Multi and table.find(cY._value,da.Value)~=nil or cY.
_value==da.Value cI(c2,da.Button,{BackgroundColor3=db and Color3.fromRGB(49,51,
64)or cC},0.16)da.Button.Text=(db and'[x] 'or'[ ] ')..da.Value da.Button.Visible
=string.find(string.lower(da.Value),string.lower(c3.Text),1,true)~=nil if da.
Button.Visible then c8=c8+1 end end c6.Visible=c8==0 end cY._refresh=c7 cE(c2,c3
:GetPropertyChangedSignal('Text'),c7)cE(c2,c2.Frame.Destroying,function()cY.
_refresh=nil end)c7()end)return cY end function cu:_colorPopup(cX,cY,cZ)local c_
=self:_openPopup(cX,cX.Name,292)local c0,c1,c2=cY:ToHSV()local c3=cD(
'TextButton',c_.Panel,{Text='',AutoButtonColor=false,BackgroundColor3=Color3.
fromHSV(c0,1,1),Position=UDim2.fromOffset(12,40),Size=UDim2.fromOffset(232,168)}
)local c4=cD('Frame',c3,{BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,
Size=UDim2.fromScale(1,1)})cD('UIGradient',c4,{Transparency=NumberSequence.new(0
,1)})local c5=cD('Frame',c3,{BackgroundColor3=Color3.new(),BorderSizePixel=0,
Size=UDim2.fromScale(1,1)})cD('UIGradient',c5,{Rotation=90,Transparency=
NumberSequence.new(1,0)})local c6=cD('Frame',c3,{Size=UDim2.fromOffset(8,8),
AnchorPoint=Vector2.new(0.5,0.5),BackgroundTransparency=1,ZIndex=3})cP(c6,8)cD(
'UIStroke',c6,{Color=cz,Thickness=2})local c7=cD('TextButton',c_.Panel,{Text='',
AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),Position=UDim2.
fromOffset(254,40),Size=UDim2.fromOffset(22,168)})local c8={}for c9=0,6 do table
.insert(c8,ColorSequenceKeypoint.new(c9/6,Color3.fromHSV(c9/6,1,1)))end cD(
'UIGradient',c7,{Rotation=90,Color=ColorSequence.new(c8)})local c9=cD('Frame',c7
,{BorderSizePixel=0,BackgroundColor3=cz,Size=UDim2.new(1,4,0,3),AnchorPoint=
Vector2.new(0,0.5),ZIndex=3})local da=cD('Frame',c_.Panel,{Position=UDim2.
fromOffset(12,220),Size=UDim2.fromOffset(34,28)})cP(da)local db=cD('TextBox',c_.
Panel,{Text='',ClearTextOnFocus=false,Font=Enum.Font.Code,TextSize=14,TextColor3
=cA,BackgroundColor3=cC,Position=UDim2.fromOffset(54,220),Size=UDim2.fromOffset(
222,28)})cP(db)cV(c_,db)cN(c_.Panel,'Drag to pick a color, or enter #RRGGBB',
UDim2.fromOffset(12,256),UDim2.fromOffset(266,24))local function dc(dd)local de=
Color3.fromHSV(c0,c1,c2)cI(c_,c3,{BackgroundColor3=Color3.fromHSV(c0,1,1)},0.07)
cI(c_,c6,{Position=UDim2.fromScale(c1,1-c2)},0.07)cI(c_,c9,{Position=UDim2.new(0
,-2,c0,0)},0.07)cI(c_,da,{BackgroundColor3=de},0.1)db.Text='#'..de:ToHex()if dd
then cZ(de)end end cW(c_,c3,function(dd)c1=math.clamp((dd.X-c3.AbsolutePosition.
X)/math.max(1,c3.AbsoluteSize.X),0,1)c2=1-math.clamp((dd.Y-c3.AbsolutePosition.Y
)/math.max(1,c3.AbsoluteSize.Y),0,1)dc(true)end)cW(c_,c7,function(dd)c0=math.
clamp((dd.Y-c7.AbsolutePosition.Y)/math.max(1,c7.AbsoluteSize.Y),0,1)dc(true)end
)cE(c_,db.FocusLost,function()local dd=db.Text:gsub('^#','')if dd:match(
'^%x%x%x%x%x%x$')then c0,c1,c2=Color3.fromHex(dd):ToHSV()dc(true)else dc(false)
end end)dc(false)end function cx:AddColorPicker(cX)cX=cX or{}local cY=self:
_control('ColorPicker',cX)cY._label=cN(cY.Frame,cY.Name,UDim2.fromOffset(12,0),
UDim2.new(1,-62,1,0))local cZ=cD('TextButton',cY.Frame,{Text='',AnchorPoint=
Vector2.new(1,0.5),Position=UDim2.new(1,-12,0.5,0),Size=UDim2.fromOffset(30,18)}
)cP(cZ,3)cU(cY,cZ,cZ,function()return cY:_interactive()end)function cY:
_normalize(c_)assert(typeof(c_)=='Color3','ColorPicker expects a Color3')return
c_ end function cY:_render()cI(self,cZ,{BackgroundColor3=self._value},0.14)self:
_enabledVisual()end cE(cY,cZ.Activated,function()if cY:_interactive()then self.
Window:_colorPopup(cY,cY:Get(),function(c_)cY:Set(c_)end)end end)cY:Set(cX.
Default or cz,true)return cY end function cx:AddTextBox(cX)cX=cX or{}local cY=
self:_control('TextBox',cX)cY.Frame.Size=UDim2.new(1,0,0,58)cY._label=cN(cY.
Frame,cY.Name,UDim2.fromOffset(12,0),UDim2.new(1,-24,0,22))local cZ=cD('TextBox'
,cY.Frame,{Text='',PlaceholderText=cX.Placeholder or'Enter text...',
ClearTextOnFocus=false,Font=Enum.Font.Gotham,TextSize=12,TextColor3=cA,
PlaceholderColor3=cB,BackgroundColor3=cC,Position=UDim2.fromOffset(12,25),Size=
UDim2.new(1,-24,0,27)})cP(cZ)cV(cY,cZ)function cY:_normalize(c_)assert(type(c_)
=='string','TextBox expects a string')if cX.MaxLength then c_=string.sub(c_,1,cX
.MaxLength)end if cX.Numeric then assert(cM(tonumber(c_)),
'TextBox requires a finite number')end return c_ end function cY:_render()cZ.
Text=self._value self:_enabledVisual()end function cY:_enabledVisual()cy.
_enabledVisual(self)cZ.TextEditable=self.Enabled and self.Section.Enabled end
cE(cY,cZ.FocusLost,function()if not cY:_interactive()then cY:_render()return end
local c_=pcall(function()cY:Set(cZ.Text)end)if not c_ then cY:_render()end end)
cY:Set(cX.Default or(cX.Numeric and'0'or''),true)return cY end function cx:
AddLabel(cX)if type(cX)=='string'then cX={Name=cX}end local cY=self:_control(
'Label',cX or{})cY._label=cN(cY.Frame,cY.Name)function cY:_render()self:
_enabledVisual()end cY:_render()return cY end function cu:ExportConfig()local cX
={Version=1,Controls={}}for cY,cZ in pairs(self.Controls)do if cZ._normalize
then local c_=cZ:Get()if cZ.Kind=='ColorPicker'then c_=c_:ToHex()elseif cZ.Kind
=='Keybind'then c_=c_ and c_.Name or'NONE'end cX.Controls[cY]={Kind=cZ.Kind,
Value=c_,Color=cZ._color and cZ._color:ToHex()or nil}end end return cr:
JSONEncode(cX)end function cu:ImportConfig(cX,cY)local cZ,c_=pcall(function()
return cr:JSONDecode(cX)end)if not cZ or type(c_)~='table'or c_.Version~=1 or
type(c_.Controls)~='table'then return false,
'Invalid Patch Hub config (expected Version 1)'end local c0={}local c1,c2=pcall(
function()for c1,c2 in pairs(c_.Controls)do local c3=self.Controls[c1]if c3 and
c3._normalize then assert(type(c2)=='table'and c2.Kind==c3.Kind,
'Config type mismatch: '..c1)local c4=c2.Value if c3.Kind=='ColorPicker'then
assert(type(c4)=='string'and c4:match('^%x%x%x%x%x%x$'),'Invalid config color: '
..c1)c4=Color3.fromHex(c4)end local c5 if c2.Color and c3.SetColor then assert(
type(c2.Color)=='string'and c2.Color:match('^%x%x%x%x%x%x$'),
'Invalid toggle color: '..c1)c5=Color3.fromHex(c2.Color)end table.insert(c0,{
Control=c3,Value=c3:_normalize(c4),Color=c5})end end end)if not c1 then return
false,tostring(c2)end self:_closePopup()self:_cancelCapture()local c3={}for c4,
c5 in ipairs(c0)do local c6=c5.Control local c7,c8=c6:Get(),c6._color c6:Set(c5.
Value,true)if c5.Color then c6:SetColor(c5.Color,true)end table.insert(c3,{
Control=c6,Old=c7,OldColor=c8})end if not cY then for c4,c5 in ipairs(c3)do
local c6=c5.Control if not cL(c5.Old,c6._value)then if c6.Kind=='Keybind'then
cJ(c6._changed,c6:Get())else cJ(c6._callback,c6:Get())end end if c6.SetColor and
c5.OldColor~=c6._color then local c7=c6._color c6._color=c5.OldColor c6:
SetColor(c7)end end end return true end ct.Window=cu ct.Version='1.1.0'return ct
end)()local co=cn:CreateWindow({Name='PatchHub_AnimalHospital',Title='Patch Hub'
,Subtitle='Animal Hospital',ToggleKey=Enum.KeyCode.RightShift})k.Gui=co k.
UIControls={}local function cp(cq,cr,cs)local ct=cq:AddLabel(cr)ct.Frame.Size=
UDim2.new(1,0,0,cs or 56)ct._label.TextWrapped=true ct._label.TextTruncate=Enum.
TextTruncate.None return ct end local function cq(cr,cs,ct)local cu=cr:
AddToggle({Id=cs,Name=ct,Default=k.Config[cs]==true,Callback=function(cu)k.
Config[cs]=cu if cs=='InstantProximityPrompts'and cu then V()elseif cs==
'AnomalyESP'and not cu then k.ClearESP()end end})k.UIControls[cs]=cu return cu
end local cr=co:CreateTab({Name='Main',Icon='rbxassetid://80869096876893'})local
cs=cr:CreateSubTab('Automation')local ct=cs:CreateSection({Name='Farm'})local cu
=cs:CreateSection({Name='Patch Hub',Side='Right'})cq(ct,'Autofarm','Auto Farm')
cq(ct,'AutoCheckPatients','Auto Check-In Patients')cq(ct,'AutoTalkIdleVisitors',
'Auto Talk Idle Visitors')cq(ct,'AutoBarney','Auto Barney')cq(ct,
'PauseAutofarmWhileMoving','Pause While Moving')cp(cu,
[[Animal Hospital
Configure treatment, anomalies, and prompt behavior in the sidebar.]]
,78)cp(cu,'The master Auto Farm switch controls the automation loop.',62)cp(cu,
'Right Shift hides or shows Patch Hub.',46)local cv=co:CreateTab({Name=
'Treatment',Icon='rbxassetid://83371760923777'})local cw=cv:CreateSubTab('Care')
local cx=cw:CreateSection({Name='Patients'})local cy=cw:CreateSection({Name=
'Procedures',Side='Right'})cq(cx,'AutoTreatment','Auto Treatment')cq(cx,
'PrioritizeCriticalPatients','Prioritize Critical Patients')cq(cx,
'AutoSleepPatient','Auto Sleep Patient')cq(cx,'AutoCarryFaintedPatient',
'Auto Carry Fainted Patient')cq(cx,'AutoPickupTreatmentItems',
'Auto Pickup Treatment Items')cq(cy,'AutoXRayMinigame','Auto X-Ray Minigame')cq(
cy,'AutoSurgeryTreatment','Auto Surgery Treatment')cq(cy,'AutoProcessPCResults',
'Auto Process PC Results')cq(cy,'AutoHeartMinigame','Auto Heart Minigame')cq(cy,
'AutoDumpUselessItems','Auto Dump Useless Items')local cz=co:CreateTab({Name=
'Anomalies',Icon='rbxassetid://88848642017283'})local cA=cz:CreateSubTab(
'Protection')local cB=cA:CreateSection({Name='Responses'})local cC=cA:
CreateSection({Name='Player',Side='Right'})cq(cB,'AutoExtinguish',
'Auto Extinguish')cq(cB,'TreatmentKillAnomaly','Treatment Kill Anomaly')cq(cB,
'AutoShutterAnomaly','Auto Shutter Anomaly')cq(cB,'AutoCoffeeHeadBanger',
'Auto Coffee Head Banger')cq(cC,'AnomalyESP','Anomaly ESP')cq(cC,
'InfiniteSanity','Infinite Sanity')cq(cC,'AntiJumpscare','Anti Jumpscare')local
cD=co:CreateTab({Name='Settings',Icon='rbxassetid://128822529527725'})local cE=
cD:CreateSubTab('Prompts')local cF=cE:CreateSection({Name='Prompt Settings'})
local cG=cE:CreateSection({Name='Movement',Side='Right'})cq(cF,'RemotePrompts',
'Remote Prompts')cq(cF,'ServerValidatedPrompts','Server Validated Prompts')cq(cF
,'InstantProximityPrompts','Instant Proximity Prompts')cq(cF,
'AnchorDuringPrompt','Anchor During Prompt')cq(cG,'TPToPrompts','TP To Prompts')
cq(cG,'AllowTeleportFallback','Allow Teleport Fallback')cq(cG,
'ReturnAfterPrompt','Return After Prompt')cq(cG,'Noclip','Noclip')local cH=cD:
CreateSubTab('Hub')local cI=cH:CreateSection({Name='Configuration'})local cJ=cp(
cI,'Session snapshot: not saved',44)local cK cI:AddButton({Name=
'Save session snapshot',Callback=function()cK=co:ExportConfig()cJ:SetText(
'Session snapshot saved')end})cI:AddButton({Name='Restore snapshot',Callback=
function()if not cK then cJ:SetText('Save a snapshot first')return end local cL,
cM=co:ImportConfig(cK)cJ:SetText(cL and'Session snapshot restored'or cM)end})cI:
AddButton({Name='Hide hub',Callback=function()co:SetVisible(false)end})cI:
AddButton({Name='Unload Patch Hub',Callback=function()k.Unload()end})s(co.Gui.
Destroying:Connect(function()if k.Running then k.Gui=nil k.Unload()end end))cr:
Select()cs:Select()end function k.Unload()k.Running=false pcall(cj)for cn,co in
ipairs(k.Connections)do pcall(function()co:Disconnect()end)end table.clear(k.
Connections)if k.Gui then pcall(function()k.Gui:Destroy()end)k.Gui=nil end k.
ClearESP()t('Automation unloaded')end local function cn(co)if k.FocusKind==nil
or k.FocusKind==co then return true end return os.clock()-(k.FocusAt or 0)>k.
Config.FocusHoldSeconds end local function co(cp,cq)if not cn(cp)then return
false end if cq()then k.FocusKind=cp k.FocusAt=os.clock()return true end return
false end function k.FarmStep()if not k.Config.Autofarm then task.wait(0.35)
return end if k.Config.PauseAutofarmWhileMoving then local cp=w():
FindFirstChildOfClass('Humanoid')if cp and cp.MoveDirection.Magnitude>0.05 then
task.wait(k.Config.ManualMovePauseSeconds)return end end ck()bN()if bU()then
return end if cd()then return end if co('barney',ch)then return end if b7()then
return end cm()local cp=S()if r.hasCriticalPatient()then if bL()then return end
end if r.firstReadyTreatmentRoom and r.firstReadyTreatmentRoom()then if co(
'rooms',bJ)then return end if cn('rooms')then task.wait(0.15)return end end if
U(cp)then bf()task.wait(0.2)return end if bl()and co('rooms',bJ)then return end
if bL()then return end local cq=bk()or T(cp)if cq then if co('checkin',bs)then
return end if cn('checkin')then task.wait(0.15)return end end bM()bK()co('rooms'
,bJ)end k.ConfigurePromptWatchers()local cp,cq=pcall(k.CreateGui)if not cp then
warn('[Patch Hub] ui failed:',cq)end t('Patch Hub loaded - Animal Hospital')task
.spawn(function()while k.Running do local cr,cs=pcall(k.FarmStep)if not cr then
warn('[Patch Hub]',cs)end task.wait(0.2)end end)s(f.Heartbeat:Connect(function()
if k.Config.InfiniteSanity then ck()end cl()z()end))s(f.RenderStepped:Connect(
function()k.UpdateESP()end))return k