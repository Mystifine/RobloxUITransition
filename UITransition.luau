local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game.ReplicatedStorage;
local Players = game.Players;

local player = Players.LocalPlayer;
local playergui = player:WaitForChild('PlayerGui');

export type Transition = {
	_duration : number,
	_onHidden : () -> nil,
	_transitionType : TransitionType,
	
	TransitionType : TransitionType,
	
	Play : (self : Transition) -> nil,
	new : (duration : number, onHidden : () -> nil, transition_type : TransitionType, parent : Instance) -> Transition
}

export type TransitionType = {
	CircleExpansion : number,
	Fade : number
}

local Transition = {};
Transition.__index = Transition;

Transition.TransitionType = {
	CircleExpansion = 1,
	FullscreenFade = 2,
}

function Transition:Play()
	local transition : Transition = self;
	
	local animation_time = transition._duration * 0.5;

	local transition_ui = script.transition_ui:Clone();
	transition_ui.DisplayOrder = 100;
	transition_ui.Parent = playergui;

	if transition._transitionType == Transition.TransitionType.CircleExpansion then
		local circle_expansion_frame = script.circle_expansion_frame:Clone();
		circle_expansion_frame.Parent = transition_ui;

		local expand = TweenService:Create(circle_expansion_frame, TweenInfo.new(animation_time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(2,0,4,0)});
		expand:Play();
		expand.Completed:Wait();
		transition._onHidden();

		local shrink = TweenService:Create(circle_expansion_frame, TweenInfo.new(animation_time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,0,0,0)});
		shrink:Play()
		shrink.Completed:Wait();
	elseif transition._transitionType == Transition.TransitionType.FullscreenFade then
		local fullscreen_fade_frame = script.fullscreen_fade_frame:Clone();
		fullscreen_fade_frame.Parent = transition_ui;
		
		local fade_in = TweenService:Create(fullscreen_fade_frame, TweenInfo.new(animation_time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0});
		fade_in:Play();
		fade_in.Completed:Wait();
		
		transition._onHidden();
		
		local fade_out = TweenService:Create(fullscreen_fade_frame, TweenInfo.new(animation_time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0});
		fade_out:Play();
		fade_out.Completed:Wait();
	end
	
	transition_ui:Destroy();
end

function Transition.new(duration : number, onHidden : () -> nil, transition_type : TransitionType)
	local transition = setmetatable({}, Transition);
	transition._duration = duration;
	transition._onHidden = onHidden;
	transition._transitionType = transition_type;
	
	return transition;
end

return Transition
