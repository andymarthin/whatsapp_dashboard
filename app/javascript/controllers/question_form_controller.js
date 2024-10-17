import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="question-form"
export default class extends Controller {
  static targets = ["footer", "body", "answer", "questionType"];
  connect() {
    this.showOrHide(this.questionTypeTarget);
  }

  typeChanged(event) {
    this.showOrHide(event.target);
  }

  showOrHide(target) {
    const selected = target.value;
    const targets = [this.footerTarget, this.bodyTarget, this.answerTarget];
    if (["main_menu", "cs", "previous_menu"].includes(selected)) {
      targets.forEach((target) => this.hide(target));
    } else {
      targets.forEach((target) => this.show(target));
    }
  }

  hide(target) {
    target.classList.add("hidden");
  }

  show(target) {
    target.classList.remove("hidden");
  }
}
