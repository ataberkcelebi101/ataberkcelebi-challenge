module challenge::hero;

use std::string::String;
//use bridge::bridge_env::ctx;

// ========= STRUCTS =========
public struct Hero has key, store {
    id: UID,
    name: String,
    image_url: String,
    power: u64,
}

public struct HeroMetadata has key, store {
    id: UID,
    timestamp: u64,
}

// ========= FUNCTIONS =========

#[allow(lint(self_transfer))]
public fun create_hero(name: String, image_url: String, power: u64, ctx: &mut TxContext) {
    let hero = Hero {
        id: object::new(ctx), // unique id 
        name: name,
        image_url: image_url,
        power: power

    };
    let hero_metadata = HeroMetadata {
        id: object::new(ctx),
        timestamp: ctx.epoch_timestamp_ms() 

    };

     transfer:: public_transfer(hero, ctx.sender());  
     transfer:: freeze_object(hero_metadata);
      
    
}


// ========= GETTER FUNCTIONS =========

public fun hero_power(hero: &Hero): u64 {
    hero.power
}

#[test_only]
public fun hero_name(hero: &Hero): String {
    hero.name
}

#[test_only]
public fun hero_image_url(hero: &Hero): String {
    hero.image_url
}

#[test_only]
public fun hero_id(hero: &Hero): ID {
    object::id(hero)
}

