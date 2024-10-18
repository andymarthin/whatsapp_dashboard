import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="upload-image"
export default class extends Controller {
  static targets = ["input", "preview", "placeholder"];
  connect() {}

  upload(event) {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (event) => {
      const img = document.createElement("img");
      img.src = event.target.result;
      this.previewTarget.innerHTML = "";
      this.previewTarget.appendChild(img);
      this.placeholderTarget.classList.add("hidden");
    };

    reader.readAsDataURL(file);
  }
}
