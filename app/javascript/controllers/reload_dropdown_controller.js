import { Dropdown } from "tailwindcss-stimulus-components"

export default class ReloadDropdown extends Dropdown {
  static targets = ["button"]
  static values = {
    frame: String,
    refreshPath: String,
    refreshFrame: String
  }

  connect() {
    super.connect();
  }

  toggle() {
    const frame = document.querySelector(`#${this.frameValue}`);
    frame.reload();
    super.toggle();

    if (!this.openValue) {
      this.refresh_target();
    }

    this.set_background();
  }

  hide(event) {
    if (this.openValue) {
      this.refresh_target();
    }
    super.hide(event);
    this.set_background();
  }

  show() {
    super.show();
    this.set_background();
  }

  close() {
    super.close();
    this.set_background();
  }

  refresh_target() {
    if (this.refreshFrameValue === "#") {
      return;
    }
    else {
      console.log("doing refresh", this.refreshFrameValue, this.refreshPathValue);
      const frame = document.querySelector(`#${this.refreshFrameValue}`);
      frame.src = this.refreshPathValue;
    }
  }

  set_background() {
    const bg_color = "bg-indigo-100";


    if (this.openValue) {
      this.buttonTarget.classList.add(bg_color);
    } else {
      this.buttonTarget.classList.remove(bg_color);
    }
  }
}