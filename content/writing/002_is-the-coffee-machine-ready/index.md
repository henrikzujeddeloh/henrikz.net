+++
type = 'page'
layout = 'post'
date = '2025-12-11T14:36:14+01:00'
title = 'Is the Coffee Machine Ready?'
slug = 'is-the-coffee-machine-ready'
lastmod = '2025-12-11T14:36:14+01:00'
draft = false
tags = ['smart home']
description = 'A simple Home Assistant automation I made to indicate when the coffee machine is actually ready.'
publishDate = '2025-12-22'
whatChanged = 'spelling'
+++
Anyone with a portafilter espresso machine knows that temperature is one of the most important parameters to get right for a good cup of coffee. My Lelit Victoria has a handy display that shows the current temperature as well as a PID to ensure the target temperature is held as accurately as possible. Even with these features, I find that there is a huge difference in taste depending on how long I wait after the machine indicates it has reached the desired temperature. I started suspecting that the machine actually takes much longer to heat up than the display indicates.

![Coffee machine heating up](heating.gif "40%")

To test my theory, I decided to plug the coffee machine into a power meter and see how the power draw varies during the heating process.

![Power draw during heating of espresso machine](power.avif "90%")

This graph shows the PID in action really well! First, there is a very high power draw, over 1000 watts, for a few minutes to do the initial heating. Then, the power drops to around zero for about a minute, probably to avoid overshooting the target temperature. Around this point, the display shows "OK", indicating that the machine is "ready". However, the power increases before going back to about zero for a few times before settling at a steady 50 to 60 watts.

From this power draw behavior, I could conclude that the machine slowly approaches the target temperature by turning the heating unit on and off, as is expected with a PID controller. I assume, then, that the _actual_ target temperature is reached when the power draw is in a steady state, which is about 10 minutes _after_ the machine has indicated it is ready!

This got me thinking of an algorithm or rule to determine from the power draw when the coffee machine is _actually_ at its target temperature. After analyzing the power draw of a few heating cycles on different days, I noticed that the steady state is preceded by power draws either above about 100 or at 1.7 watts. I assume the 1.7 watts is the "idle" power draw of the machine when it is not heating. To capture the steady state, I just look for the time when the power draw is between 1.7 (make it 2) and 100 watts for a few minutes.

Now I just needed an indicator to activate when this state is reached. Handily enough, the power meter itself has a small green LED on it! I edited the ESPHome configuration of the power meter to expose the LED as a light to Home Assistant. It's truly amazing how simple [ESPHome](https://esphome.io/) makes it to customize ESP32-based devices.

I then created an automation that triggers when the coffee machine is turned on (power draw is over 800 watts). The LED is turned off in case it is already on, which should not be the case. Then, the automation waits for one of two things to happen. Either the coffee machine is turned off and the power drops to zero, at which point the automation is aborted. Otherwise it waits until the power draw is between 2 and 100 watts for 5 minutes. Another automation turns off the LED if the power drops to zero.

![Home Assistant automation](automation.avif "80%")

In practice, this automation works perfectly! Now, whenever the LED of the power meter turns on, I know the machine is ready to use. Additionally, the LED also indicates when the machine is ready to use again after having made a coffee. The power spikes above 800 watts after pulling a shot, turning off the LED. The LED then turns on again according to the same rule when it is ready for the next coffee. Meanwhile, the display shows the same temperature the entire time.

![LED indicating the coffee machine has reached target temperature](LED.avif "50%")

I can now enjoy more consistent coffee, thanks to this very simple automation. Not only that, but I also got to visualize and learn about how my coffee machine actually heats to the target temperature using its PID controller.
