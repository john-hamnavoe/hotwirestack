import { Dropdown } from "tailwindcss-stimulus-components"

export default class Dropdowns extends Dropdown {


  connect() {
    super.connect();
  }

  openValueChanged() {

    if (this.openValue === true && this.hasMenuItemTarget) {
      this.menuItemTargets[0].focus()
    }
  }
}