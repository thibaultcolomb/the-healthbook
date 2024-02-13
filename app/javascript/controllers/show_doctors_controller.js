import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="show-doctors"
export default class extends Controller {
  static targets = ["questions", "select", "questionsbutton", "selectbutton"]
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  showquestions() {
    console.log("yew", this.element)
    this.questionsTarget.classList.toggle("hidden")
    this.selectTarget.classList.add("hidden")
    this.questionsbuttonTarget.classList.toggle("btn-select-doctors-active")
    this.selectbuttonTarget.classList.remove("btn-select-doctors-active")
    }

  showselect() {
    console.log("yew", this.element)
    this.questionsTarget.classList.add("hidden")
    this.selectTarget.classList.toggle("hidden")
    this.questionsbuttonTarget.classList.remove("btn-select-doctors-active")
    this.selectbuttonTarget.classList.toggle("btn-select-doctors-active")
    }
  }
