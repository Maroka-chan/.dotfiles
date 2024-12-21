import { App, Astal, Gtk, Gdk, astalify, Widget } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"
import Hyprland from "gi://AstalHyprland"
import { setlocale } from "gettext"
import Gdk30 from "gi://Gdk"

const hyprland = Hyprland.get_default()


//const GtkRevealer = astalify(Gtk.Revealer)
//
//
//
//<revealer reveal_child={true} transition_duration={250} transition_type={Gtk.RevealerTransitionType.SLIDE_RIGHT}>
//</revealer>

export default function Bar() {
    return <window
        name="bar"
        className="Bar"
        visible={false}
        monitor={bind(hyprland, "focused_monitor").as(mon => mon.id)}
        margin_left={20}
        margin_top={20}
        margin_bottom={20}
        anchor={Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.BOTTOM}
        application={App}>
        <centerbox vertical={true} >
            <box />
            <box vertical={true}>
              {bind(hyprland, "focused_monitor")
                .as(mon => hyprland.workspaces.filter(ws => ws.get_monitor().id == mon.id))
                .as(ws => ws.sort((a,b) => (a.id < b.id) ? -1 : 1).map(w => {
                  const id = ((w.id-1) % ws.length) + 1
                  return <button on_clicked={() => w.focus()} css={bind(hyprland, "focused_workspace").as(m => m.id == w.id ? "background: white;" : "")}>
                    <label label={id.toString(10)} />
                  </button>
                }))
              }
            </box>
            <box valign={Gtk.Align.END}>
              <button
                  className="TimeButton"
                  on_clicked={() => App.toggle_window("calendar")}
                  halign={Gtk.Align.CENTER} >
                  <Time />
              </button>
            </box>
        </centerbox>
    </window>
}

function Time({ format = "%H\n%M" }) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        className="Time"
        onDestroy={() => time.drop()}
        label={time()}
    />
}
