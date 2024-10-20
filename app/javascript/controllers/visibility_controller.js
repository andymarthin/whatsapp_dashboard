import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="visibility"
export default class extends Controller {
  static targets = ["element"];
  static values = {
    rules: Object,
  };

  connect() {
    this.updateElementVisibility();
  }

  updateElementVisibility(event) {
    const selectedValue = this.getSelectedValue(event);

    this.elementTargets.forEach((element) => {
      const elementId = element.dataset.elementId;
      const visibilityRule = this.rulesValue[elementId];
      if (visibilityRule) {
        const shouldBeVisible = this.checkVisibilityRule(
          visibilityRule,
          selectedValue,
        );
        this.setElementVisibility(element, shouldBeVisible);
      }
    });
  }

  getSelectedValue(event) {
    if (event) {
      return event.target.value;
    }
    const selectElement = this.element.querySelector("select");
    return selectElement ? selectElement.value : null;
  }

  checkVisibilityRule(rule, selectedValue) {
    if (typeof rule === "function") {
      return rule(selectedValue);
    }
    if (Array.isArray(rule)) {
      return rule.includes(selectedValue);
    }
    if (typeof rule === "string") {
      return rule === selectedValue;
    }
    return false;
  }

  setElementVisibility(element, isVisible) {
    element.classList.toggle("hidden", !isVisible);
  }

  // setInputElementDisable(element, isVisible) {
  //   const inputElements = element.querySelectorAll("input, select, textarea");
  //   inputElements.forEach((input) => {
  //     input.toggleAttribute("disabled", !isVisible);
  //   });
  // }
}
