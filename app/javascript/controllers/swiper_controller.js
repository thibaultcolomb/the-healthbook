import { Controller } from "@hotwired/stimulus"
import Swiper from "swiper"
// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log("hi")
    this.swiper = new Swiper('.swiper-container', {
    });
  }
}
