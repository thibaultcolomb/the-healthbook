import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="show-doctors"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  show_doctors() {
    console.log("yew", this.element)
  }
}
