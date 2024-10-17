import { Controller } from "@hotwired/stimulus";
import { Dismiss } from "flowbite";

// Connects to data-controller="alert"
export default class extends Controller {
  static targets = ["content", "trigger"];

  connect() {
    const options = {
      transition: "transition-opacity",
      duration: 300,
      timing: "ease-out",
    };
    const dismiss = new Dismiss(
      this.contentTarget,
      this.triggerTarget,
      options,
    );
    setTimeout(() => {
      dismiss.hide();
    }, 5000);
  }
}
