use std::io::BufReader;
use std::os::unix::net::UnixStream;
use std::env;
use std::io::prelude::*;
use serde::{Deserialize, Serialize};
use std::process::Command;


#[derive(Clone, Copy, Serialize, Deserialize)]
struct Workspace {
    id: usize,
    windows: usize,
}

#[derive(Serialize)]
struct WorkspaceState {
    active: usize,
    workspaces: Vec<Workspace>,
}

fn handle_event(event: &str, workspace_state: &mut WorkspaceState, workspace_count: usize) {
    let args: Vec<&str> = event.split(">>").collect();
    if let [left, right] = args.as_slice() {
        match *left {
            "workspace" => {
                let event_value: usize = (*right).parse().expect("Not a number");
                workspace_state.active = event_value;
                workspace_state.workspaces = query_workspaces(workspace_count);
                println!("{}", serde_json::to_string(&workspace_state).expect("Failed to serialize struct to JSON"));
            }
            _ => {}
        }
    }
}

fn query_workspaces(workspace_count: usize) -> Vec<Workspace> {
    let output = Command::new("hyprctl").arg("workspaces").arg("-j").output().expect("hyprctl command failed");
    let result: Vec<Workspace> = serde_json::from_str(&String::from_utf8_lossy(&output.stdout)).expect("Failed to parse json");

    let mut workspaces: Vec<Workspace> = Vec::with_capacity(workspace_count);
    for n in 1..workspaces.capacity() + 1 {
        workspaces.push(Workspace { id: n, windows: 0 });
    }
    for workspace in result.iter() {
        workspaces[workspace.id - 1] = *workspace;
    }

    return workspaces;
}

fn main() {
    let hyprland_instance = match env::var_os("HYPRLAND_INSTANCE_SIGNATURE") {
        Some(v) => v.into_string().unwrap(),
        None => panic!("$HYPRLAND_INSTANCE_SIGNATURE is not set")
    };

    let workspace_count: usize = env::args().nth(1).expect("No argument given").parse().expect("First argument is not a number");
    let mut workspace_state = WorkspaceState { active: 1, workspaces: query_workspaces(workspace_count) };
    println!("{}", serde_json::to_string(&workspace_state).expect("Failed to serialize struct to JSON"));

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
