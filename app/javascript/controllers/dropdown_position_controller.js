import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "menu", "container"]

  toggle() {
    // First, make the menu visible but with no positioning
    this.menuTarget.classList.remove('hidden')
    this.menuTarget.style.visibility = 'hidden'

    // Use setTimeout to allow the browser to render the menu
    setTimeout(() => {
      this.positionMenu()
      // Make the menu visible after positioning
      this.menuTarget.style.visibility = 'visible'
    }, 0)
  }

  positionMenu() {
    const buttonRect = this.buttonTarget.getBoundingClientRect()
    const menuRect = this.menuTarget.getBoundingClientRect()
    const containerRect = this.containerTarget.getBoundingClientRect()
    const viewportHeight = window.innerHeight

    // Check if there's enough space below the button
    if (buttonRect.bottom + menuRect.height > viewportHeight) {
      // Position menu above the button
      this.menuTarget.style.top = 'auto'
      this.menuTarget.style.bottom = `${containerRect.height}px`
    } else {
      // Position menu below the button
      this.menuTarget.style.top = '0'
      this.menuTarget.style.bottom = 'auto'
    }
  }
}