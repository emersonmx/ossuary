#![cfg_attr(bevy_lint, feature(register_tool), register_tool(bevy))]
#![cfg_attr(not(feature = "dev"), windows_subsystem = "windows")]

use bevy::{asset::AssetMetaCheck, prelude::*, window::WindowResolution};

#[cfg(feature = "dev")]
mod dev_tools;

fn main() -> AppExit {
    App::new().add_plugins(AppPlugin).run()
}

const GAME_TITLE: &str = "{{ project_name }}";
const WINDOW_WIDTH: u32 = 800;
const WINDOW_HEIGHT: u32 = 600;
const CLEAR_COLOR: Color = Color::BLACK;

pub struct AppPlugin;

impl Plugin for AppPlugin {
    fn build(&self, app: &mut bevy::prelude::App) {
        app.add_plugins(
            DefaultPlugins
                .set(AssetPlugin {
                    meta_check: AssetMetaCheck::Never,
                    ..default()
                })
                .set(WindowPlugin {
                    primary_window: Some(Window {
                        title: GAME_TITLE.to_string(),
                        resolution: WindowResolution::new(WINDOW_WIDTH, WINDOW_HEIGHT),
                        ..default()
                    }),
                    ..default()
                }),
        );

        app.add_plugins((
            #[cfg(feature = "dev")]
            dev_tools::plugin,
        ));

        app.insert_resource(ClearColor(CLEAR_COLOR));

        app.add_systems(Startup, spawn_camera);
    }
}

fn spawn_camera(mut commands: Commands) {
    commands.spawn((Name::new("Camera"), Camera2d));
}
