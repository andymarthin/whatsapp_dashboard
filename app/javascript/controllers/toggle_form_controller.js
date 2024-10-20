import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-form"
export default class extends Controller {
  static targets = ["input", "wrapper"];
  connect() {
    this.updateVisibility();
    console.log(this.inputTarget);
  }

  updateVisibility(_event) {
    const checked = this.isChecked(this.inputTarget);
    this.wrapperTarget.classList.toggle("hidden", !checked);
    this.setInputElementDisable(this.wrapperTarget, checked);
  }

  isChecked(element) {
    return element.checked;
  }
  setInputElementDisable(element, isVisible) {
    const inputElements = element.querySelectorAll("input, select, textarea");
    inputElements.forEach((input) => {
      input.toggleAttribute("disabled", !isVisible);
    });
  }
}
