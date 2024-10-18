import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="question-form"
export default class extends Controller {
  static targets = ["footer", "body", "questionType", "button"];
  connect() {
    this.showOrHide(this.questionTypeTarget);
  }

  typeChanged(event) {
    this.showOrHide(event.target);
  }

  showOrHide(target) {
    const selected = target.value;
    let targets = [this.footerTarget];
    if (selected !== "cs") {
      targets.push(this.bodyTarget);
    }
    if (["main_menu", "cs", "previous_menu"].includes(selected)) {
      targets.forEach((target) => this.hide(target));
    } else {
      targets.forEach((target) => this.show(target));
    }

    if (selected === "list") {
      this.show(this.buttonTarget);
    } else {
      this.hide(this.buttonTarget);
    }
  }

  hide(target) {
    target.classList.add("hidden");
  }

  show(target) {
    target.classList.remove("hidden");
  }
}
