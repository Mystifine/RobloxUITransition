# UI Transition Module

This Lua module provides a reusable system for creating smooth user interface transitions in Roblox. The module supports two types of transitions: `CircleExpansion` and `FullscreenFade`. You can easily integrate it into your game to enhance the visual experience of switching between different UI elements.

---

## Features

- **Circle Expansion Transition**: A circle expands and contracts to reveal or hide UI elements.
- **Fullscreen Fade Transition**: A fade-in and fade-out effect for seamless UI transitions.
- Highly customizable duration and callbacks for efficient integration.

---

## Requirements

- Roblox Studio
- Familiarity with Lua scripting

---

## Installation

To use this module, download the model from the Roblox Creator Marketplace:
[UI Transition Model](https://create.roblox.com/store/asset/92958303626665/UITransition)

1. Click the link above to open the asset page.
2. Click "Get" to add the model to your inventory.
3. In Roblox Studio, go to the **Toolbox**, select **My Models**, and insert the `UITransition` model into your game.

---

## Usage

### Setup

1. Insert the `UITransition` model into your game.
2. Place the `transition_ui`, `circle_expansion_frame`, and `fullscreen_fade_frame` objects under the `Transition` script.

### Importing the Module

```lua
local Transition = require(game.ReplicatedStorage.Transition);
```

### Creating a Transition

Use the `Transition.new()` method to create a new transition object.

#### Parameters:
- `duration` (number): The total duration of the transition (in seconds).
- `onHidden` (function): A callback function triggered after the first half of the transition completes.
- `transition_type` (TransitionType): The type of transition (`CircleExpansion` or `FullscreenFade`).

#### Example:

```lua
local TweenService = game:GetService("TweenService");

-- Define a callback function
local function onHiddenCallback()
    print("Transition completed! UI hidden.");
end

-- Create a Circle Expansion Transition
local circleTransition = Transition.new(2, onHiddenCallback, Transition.TransitionType.CircleExpansion);

-- Play the Transition
circleTransition:Play();
```

---

## API Reference

### Transition.new

**Description:** Creates a new Transition object.

**Syntax:**
```lua
Transition.new(duration : number, onHidden : () -> nil, transition_type : TransitionType) -> Transition
```

### Transition:Play

**Description:** Starts the transition animation.

**Syntax:**
```lua
transition:Play()
```

---

## Transition Types

```lua
Transition.TransitionType = {
    CircleExpansion = 1, -- Circle expansion effect
    FullscreenFade = 2   -- Fullscreen fade effect
};
```

---

## File Structure

```
TransitionModule/
├── Transition.lua -- The main module script
├── transition_ui -- The base frame for transitions
├── circle_expansion_frame -- The frame used for circle expansion transitions
└── fullscreen_fade_frame -- The frame used for fullscreen fade transitions
```

---

## Best Practices

- Ensure that the `parent` parameter for the transition is set to a visible UI container.
- Use the `onHidden` callback to manage UI updates during the transition.
- Clone the `transition_ui`, `circle_expansion_frame`, and `fullscreen_fade_frame` objects to avoid conflicts when reusing the module.

---

## License
This module is provided under the MIT License. You are free to use, modify, and distribute it.

---

## Contributing

Feel free to fork the repository and submit pull requests to improve or extend the module’s functionality.

---

## Contact

If you have questions or encounter issues, please reach out through the GitHub repository’s issue tracker.
