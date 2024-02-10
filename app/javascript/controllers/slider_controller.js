// app/javascript/controllers/slider_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["content"];

  initialize() {
    this.startX = 0;
    this.currentX = 0;
    this.dragging = false;

    this.contentTarget.addEventListener("touchstart", this.handleTouchStart.bind(this), false);
    this.contentTarget.addEventListener("touchmove", this.handleTouchMove.bind(this), false);
    this.contentTarget.addEventListener("touchend", this.handleTouchEnd.bind(this), false);
  }

  handleTouchStart(event) {
    this.startX = event.touches[0].clientX;
    this.dragging = true;
  }

  handleTouchMove(event) {
    if (!this.dragging) return;

    this.currentX = event.touches[0].clientX;
    let deltaX = this.currentX - this.startX;

    let currentPosition = parseInt(this.contentTarget.style.left) || 0;
    let newPosition = currentPosition + deltaX;

    this.contentTarget.style.left = `${newPosition}px`;

    this.startX = this.currentX;
  }

  handleTouchEnd(event) {
    this.dragging = false;
  }
}
