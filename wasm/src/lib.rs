
extern crate wasm_bindgen;

use wasm_bindgen::prelude::*;
use social_tournament::double::DrawOption;
use social_tournament::table::DistributionOption;
use social_tournament::pdf::language::Language;
use social_tournament::{SocialTournament, TournamentConfig, TableConfig};

#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}


#[wasm_bindgen]
pub fn create_run_sheet_for_double(number_of_players: usize, number_of_rounds: usize, draw_option: usize, number_of_tables: usize, distribute_option: usize, language_code: String) -> Vec<u8> {
    let draw_option = match draw_option {
        0 => DrawOption::AllInAction,
        1 => DrawOption::ForceDoubleOnly,
        2 => DrawOption::ValidCompositionsOnly,
        _ => DrawOption::AllInAction
    };
    let distribute_option = match distribute_option {
        0 => DistributionOption::FillUp,
        1 => DistributionOption::Evenly,
        _ => DistributionOption::FillUp
    };

    let language = match language_code.as_str() {
        "de" => Language::DE,
        "en" => Language::EN,
        _ => Language::EN
    };

    let mut tournament = SocialTournament::new(TournamentConfig::Double {
        number_of_players,
        number_of_rounds,
        draw_option: Some(draw_option),
        table_config: TableConfig { available_tables: number_of_tables, distribution_option: Some(distribute_option) }
    });

    tournament.draw().unwrap();
    tournament.distribute().unwrap();
    tournament.create_route_cards_pdf(language).unwrap();
    tournament.pdf.unwrap_or(vec![])

}
