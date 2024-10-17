import { Controller } from "@hotwired/stimulus";
import { Modal } from "flowbite";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["content"];
  connect() {
    this.modal = new Modal(this.contentTarget, {
      placement: "center",
      closable: true,
    });
    this.toggle();
  }
  disconnect() {
    this.modal.hide();
  }

  close() {
    this.modal.hide();
  }

  open() {
    this.modal.show();
  }

  toggle() {
    this.modal.toggle();
  }
}
