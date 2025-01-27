import { App, Audio, Icons, Utils, Widget } from "../../imports.js";
import Brightness from "../../services/brightness.js";
import { audioIcon } from "../../utils/audio.js";

const Slider = (args) =>
  Widget.Box({
    ...args.props ?? {},
    className: args.name,

    children: [
      Widget.Button({
        onPrimaryClick: args.icon.action ?? null,
        child: Widget.Icon({
          icon: args.icon.icon ?? "",
          setup: args.icon.setup,
        }),
      }),
      Widget.Slider({
        drawValue: false,
        hexpand: true,
        setup: args.slider.setup,
        onChange: args.slider.onChange ?? null,
      }),
    ],
  });

const vol = {
  name: "volume",
  icon: {
    action: () => {
      App.toggleWindow("system-menu");
      Utils.execAsync("pavucontrol");
    },
    setup: (self) =>
      self
        .bind("icon", Audio.speaker, "volume", audioIcon)
        .bind("icon", Audio.speaker.stream, "is-muted", audioIcon),
  },
  slider: {
    setup: (self) => self.bind("value", Audio.speaker, "volume"),
    onChange: ({ value }) => Audio.speaker.volume = value,
  },
};

const brightness = {
  name: "brightness",
  icon: {
    icon: Icons.brightness,
  },
  slider: {
    setup: (self) => self.bind("value", Brightness, "screen-value"),
    onChange: ({ value }) => Brightness.screenValue = value,
  },
};

export default Widget.Box({
  className: "sliders",
  vertical: true,

  children: [
    Slider(vol),
    Slider(brightness),
  ],
});
