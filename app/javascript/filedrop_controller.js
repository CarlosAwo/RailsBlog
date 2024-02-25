import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['dropZone', 'inputFile']
  connect() {
    this.element.textContent = "Hello World!"
  }
}
