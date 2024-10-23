import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-form"
export default class extends Controller {
  static targets = ["input", "wrapper", "destroy", "exclude"];
  connect() {
    this.updateVisibility();
  }

  updateVisibility(_event) {
    const checked = this.isChecked(this.inputTarget);
    this.wrapperTarget.classList.toggle("hidden", !checked);
    this.setInputElementDisable(this.wrapperTarget, checked);
    if (this.hasDestroyTarget) {
      this.destroyTarget.value = !checked;
    }
  }

  isChecked(element) {
    return element.checked;
  }
  setInputElementDisable(element, isVisible) {
    const inputElements = element.querySelectorAll("input, select, textarea");
    inputElements.forEach((input) => {
      if (this.hasDestroyTarget && this.excludeTargets.includes(input)) {
        return;
      }
      input.toggleAttribute("disabled", !isVisible);
    });
  }
}
