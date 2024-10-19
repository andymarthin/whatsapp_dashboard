import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="upload-image"
export default class extends Controller {
  static targets = ["input", "preview"];
  connect() {}

  preview(event) {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (event) => {
      const img = document.createElement("img");
      img.src = event.target.result;
      img.className = "max-h-48 rounded-lg mx-auto";
      img.setAttribute("data-action", "click->upload-image#chooseFile");
      this.previewTarget.innerHTML = "";
      this.previewTarget.appendChild(img);
      this.previewTarget.classList.remove(
        "border-dashed",
        "border-2",
        "border-gray-400",
      );

      this.placeholderTarget.classList.add("hidden");
    };

    reader.readAsDataURL(file);
  }

  chooseFile(event) {
    event.stopPropagation();
    this.inputTarget.click();
  }
}
