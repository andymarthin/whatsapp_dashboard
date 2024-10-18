import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

import CharacterCounter from "@stimulus-components/character-counter";
application.register("character-counter", CharacterCounter);

export { application };
