use std::io::BufReader;
use std::os::unix::net::UnixStream;
use std::env;
use std::io::prelude::*;

#[derive(Clone)]
struct Workspace {
    occupied: bool,
}

struct WorkspaceState {
    active: usize,
    workspaces: Vec<Workspace>,
}

fn update_workspaces(workspace_count: usize, workspace_state: &mut WorkspaceState) {
    let workspaces = &mut workspace_state.workspaces;
    let mut builder = String::with_capacity((29 + 21 * workspace_count).try_into().unwrap());
    builder.push_str("{\"workspaces\":[");
    for n in 1..workspace_count {
        let workspace = format!("{{\"id\":{n},\"occupied\":{}}}", workspaces[n as usize].occupied);
        builder.push_str(&workspace);
        if n < workspace_count - 1 {
            builder.push_str(",");
        }
    }
    builder.push_str("],");
    let active = format!("\"active\":{}}}", workspace_state.active);
    builder.push_str(&active);
    println!("{}", builder);
}

fn handle_event(event: &str, workspace_state: &mut WorkspaceState, workspace_count: usize) {
    let workspaces = &mut workspace_state.workspaces;
    let args: Vec<&str> = event.split(">>").collect();
    if let [left, right] = args.as_slice() {
        match *left {
            "workspace" => {
                let event_value: usize = (*right).parse().expect("Not a number");
                workspace_state.active = event_value;
                workspaces[event_value].occupied = true;
                update_workspaces(workspace_count, workspace_state);
            }
            "destroyworkspace" => {
                let event_value: usize = (*right).parse().expect("Not a number");
                workspaces[event_value].occupied = false;
                update_workspaces(workspace_count, workspace_state);
            }
            _ => {}
        }
    }
}

fn main() {
    let hyprland_instance = match env::var_os("HYPRLAND_INSTANCE_SIGNATURE") {
        Some(v) => v.into_string().unwrap(),
        None => panic!("$HYPRLAND_INSTANCE_SIGNATURE is not set")
    };

    let workspace_count: usize = env::args().nth(1).expect("No argument given").parse().expect("First argument is not a number");
    let workspaces = vec![Workspace { occupied: false, }; workspace_count];
    let mut workspace_state = WorkspaceState { active: 1, workspaces: workspaces };

    let stream = UnixStream::connect(format!("/tmp/hypr/{}/.socket2.sock", hyprland_instance))
        .expect("Failed to connect to socket");

    let mut reader = BufReader::new(stream);
    loop {
        let mut buffer = String::new();
        let size = reader.read_line(&mut buffer).expect("Failed to read from socket");
        if size == 0 {
            break;
        }

        handle_event(buffer.trim_end(), &mut workspace_state, workspace_count);
    }
}
