import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(()=>{console.log(this.dismiss())}, 8000)
  }

  dismiss() {
    this.element.remove()
  }
}
