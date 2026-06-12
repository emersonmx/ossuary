use bevy::{prelude::*, window::WindowResolution};
use debug_plugins::DebugPlugins;

mod debug_plugins;

fn main() {
    App::new()
        .insert_resource(ClearColor(Color::BLACK))
        .add_plugins(DefaultPlugins.set(WindowPlugin {
            primary_window: Some(Window {
                title: "{{ project_name }}".to_string(),
                resolution: WindowResolution::new(800, 600),
                ..default()
            }),
            ..default()
        }))
        .add_plugins(DebugPlugins)
        .add_systems(Startup, setup)
        .add_systems(PreUpdate, close_on_esc)
        .run();
}

fn setup(mut commands: Commands) {
    commands.spawn(Camera2d);
}

fn close_on_esc(
    keyboard_input: Res<ButtonInput<KeyCode>>,
    mut app_exit_messages: MessageWriter<AppExit>,
) {
    if keyboard_input.just_pressed(KeyCode::Escape) {
        app_exit_messages.write(AppExit::Success);
    }
}
