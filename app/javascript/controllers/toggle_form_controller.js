import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-form"
export default class extends Controller {
  static targets = ["input", "wrapper"];
  connect() {
    this.updateVisibility();
  }

  updateVisibility(_event) {
    const checked = this.isChecked(this.inputTarget);
    this.wrapperTarget.classList.toggle("hidden", !checked);
  }

  isChecked(element) {
    return element.checked;
  }
}
