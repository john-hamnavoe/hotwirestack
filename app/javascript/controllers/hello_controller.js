import { Controller } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
