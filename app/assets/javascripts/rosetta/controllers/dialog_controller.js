import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dialog", "title", "titleSource", "content"];

  open(e) {
    e.preventDefault();
    const link = e.currentTarget;
    this.dialogTarget.showModal();
    this.loadingContent = this.contentTarget.innerHTML;
    this.contentTarget.src = link.href;
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
    this.contentTarget.innerHTML = this.loadingContent;
    this.setTitle("");
  }

  setTitle(value) {
    this.titleTarget.textContent = value;
  }
}
