use bevy::prelude::*;

pub struct DebugPlugins;

cfg_select! {
    debug_assertions => {
        use bevy_inspector_egui::{bevy_egui::EguiPlugin, quick::WorldInspectorPlugin};

        impl Plugin for DebugPlugins {
            fn build(&self, app: &mut App) {
                app.add_plugins((EguiPlugin::default(), WorldInspectorPlugin::new()));
            }
        }
    }
    _ => {
        impl Plugin for DebugPlugins {
            fn build(&self, _app: &mut App) {}
        }
    }
}
