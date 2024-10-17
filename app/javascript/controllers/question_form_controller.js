import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="question-form"
export default class extends Controller {
  static targets = ["title", "description", "questionType"];
  connect() {
    this.showOrHide(this.questionTypeTarget);
  }

  typeChange(event) {
    this.showOrHide(event.target);
  }

  showOrHide(target) {
    const selected = target.value;
    if (["list", "list_buttons"].includes(selected)) {
      this.show(this.titleTarget);
      this.show(this.descriptionTarget);
    } else {
      this.hide(this.titleTarget);
      this.hide(this.descriptionTarget);
    }
  }

  hide(target) {
    target.classList.add("hidden");
  }

  show(target) {
    target.classList.remove("hidden");
  }
}
