import { Controller } from "@hotwired/stimulus"
import Swiper from "swiper"
// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    this.swiper = new Swiper('.swiper-container', {
      spaceBetween: 30,
      freeMode: true,
    });
  }
}
