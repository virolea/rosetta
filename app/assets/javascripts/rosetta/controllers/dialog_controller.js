import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dialog", "content", "title", "titleSource", "turboFrame"];

  initialize() {
    this.loadingIndicator = this.turboFrameTarget.innerHTML;
  }

  open(e) {
    e.preventDefault();
    const link = e.currentTarget;
    this.dialogTarget.showModal();
    this.turboFrameTarget.src = link.href;
  }

  safeClose(e) {
    if (this.contentTarget.contains(e.target)) return;
    this.close();
  }

  close(e) {
    this.dialogTarget.close();
    this.resetContent();
  }

  titleSourceTargetConnected(e) {
    const title = e.textContent;
    this.setTitle(title);
  }

  resetContent() {
    this.turboFrameTarget.innerHTML = this.loadingIndicator;
    this.setTitle("");
  }

  setTitle(value) {
    this.titleTarget.textContent = value;
  }
}
