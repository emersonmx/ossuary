use bevy::{input::common_conditions::input_toggle_active, prelude::*};

pub struct DebugPlugins;

cfg_select! {
    debug_assertions => {
        use bevy_inspector_egui::{bevy_egui::EguiPlugin, quick::WorldInspectorPlugin};

        impl Plugin for DebugPlugins {
            fn build(&self, app: &mut App) {
                app.add_plugins(EguiPlugin::default())
                    .add_plugins(
                        WorldInspectorPlugin::default().run_if(input_toggle_active(true, KeyCode::KeyI)),
                    )
                    .add_systems(PreUpdate, close_on_esc);
            }
        }

        fn close_on_esc(
            keyboard_input: Res<ButtonInput<KeyCode>>,
            mut app_exit_messages: MessageWriter<AppExit>,
        ) {
            if keyboard_input.just_pressed(KeyCode::Escape) {
                app_exit_messages.write(AppExit::Success);
            }
        }
    }
    _ => {
        impl Plugin for DebugPlugins {
            fn build(&self, _app: &mut App) {}
        }
    }
}
