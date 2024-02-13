import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="show-doctors"
export default class extends Controller {
  static targets = ["questions", "select"]
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  show() {
    console.log("yew", this.element)
    this.questionsTarget.classList.toggle("hidden")
    this.selectTarget.classList.toggle("hidden")
    }
  }
