import { Media } from "./Media.js"

const hyprland = await Service.import('hyprland')

const time = Variable('', {
    poll: [1000, () => {
      return new Date()
        .toLocaleTimeString("da-DK", { hour: "2-digit", minute: "2-digit" })
        .replace(".", "\n");
    }],
})

const radio_track = Variable('', {
  listen: App.configDir + '/radio_handler.sh'
})

const focusedTitle = Widget.Label({
    label: hyprland.active.client.bind('title'),
    visible: hyprland.active.client.bind('address')
        .as(addr => !!addr),
})

const dispatch = ws => hyprland.messageAsync(`dispatch split-workspace ${ws}`);

const Workspaces = () => Widget.EventBox({
    child: Widget.CenterBox({
      vertical: true,
      centerWidget: Widget.Box({
        vertical: true,
        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
          //attribute: i,
          //label: `${i}`,
          onClicked: () => dispatch(i),
          child: Widget.Label(`${i}`),
          //hexpand: false,
          css: hyprland.bind("active").as(active => `background-color: black; border: none; margin: 2px; ${active.workspace.id == i + active.monitor.id * 10 ? 'color: red;' : ''}`)
        })),
      }),
    }),
})

var current_stream = "https://listen.moe/stream";
var radio_playing = Variable(false);
var reveal_radio = Variable(false);
export const reveal_bar = Variable(false);
globalThis.reveal_bar = reveal_bar;

const isVertical = (monitor) => [1, 3].includes(monitor.transform);

const height = Variable(0); 
const activeMonitorID = hyprland.bind("active").as(active => {
  const id = active.monitor.id;
  const monitor = hyprland.getMonitor(id);
  height.setValue(isVertical(monitor) ? monitor.width : monitor.height);
  return id;
});

//const activeMonitorID = hyprland.bind("active").as(active => active.monitor.id);
//const activeMonitor = Utils.derive([activeMonitorID], (activeMonitorID) => { return hyprland.getMonitor(activeMonitorID) });

const Bar = () => Widget.Window({
    css: 'border-radius: 0; background-color: transparent;',
    name: 'bar',
    monitor: activeMonitorID,
    exclusivity: 'ignore',
    anchor: ['right'],
    keymode: "on-demand",
    layer: "overlay",
    child: Widget.Box({
      css: height.bind().as(height => `padding: 1px; min-height: ${height}px;`),
      vertical: true,
      homogeneous: true,
      child: Widget.Revealer({
        revealChild: reveal_bar.bind(),
        transitionDuration: 100,
        transition: 'slide_left',
        child: Widget.Box({
          css: 'margin-right: 20px; padding-bottom: 20px; background-color: black;',
          vertical: true,
          homogeneous: true,
          children: [
            Widget.Button({
              child: Widget.Label({label: "󰐹"}),
              onClicked: () => reveal_radio.value = !reveal_radio.value
            }),
            Workspaces(),
            Widget.Button({
              child: Widget.Label({label: "s"}),
              onClicked: () => Utils.execAsync(['bash', '-c', `pgrep -x hyprsunset && pkill hyprsunset || hyprsunset -t 5000`])
            }),
            Widget.Label({label: time.bind(), css: ''})
          ],
        }),
      }),
    }),
})

const Radio = () => Widget.Window({
    name: 'radio',
    anchor: ['right', 'top'],
    child: Widget.Box({
      vertical: true,
      homogeneous: true,
      child: Widget.Revealer({
        revealChild: reveal_radio.bind(),
        transitionDuration: 1000,
        transition: 'slide_left',
        child: Widget.Box({
          vertical: true,
          homogeneous: true,
          children: [
            Widget.Label({label: radio_track.bind()}),
            Widget.Button({
              child: Widget.Label({label: radio_playing.bind().as(b => b ? "󰏤" : "󰐊")}),
              onClicked: () => {
                if (!radio_playing.value) {
                  Utils.execAsync(['bash', '-c', `echo "play ${current_stream}" >/tmp/ags/radio/pipe`])
                } else {
                  Utils.execAsync(['bash', '-c', `echo "stop" >/tmp/ags/radio/pipe`])
                }
                radio_playing.value = !radio_playing.value
              }
            }),
          ],
          css: 'min-width: 500px;'
        })
      }),
      css: 'padding: 1px;'
    }),
    css: 'border-radius: 0;'
})

App.config({
    style: "./style.css",
    windows: [
        Bar(), Radio()
    ]
})
