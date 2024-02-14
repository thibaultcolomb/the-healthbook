
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.dropdownItems = this.element.querySelectorAll(".dropdown-item");
  }

  selectOption(event) {
    const choice = event.currentTarget.dataset.choice;
    console.log("Selected choice:", choice);
  }
}
