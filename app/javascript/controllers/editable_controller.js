import { Controller } from "@hotwired/stimulus"
import { turndownService } from "../lib/turndown_service"
import rangy from "rangy"
import "rangy/lib/rangy-textrange"
import { show_format_selection_menu } from "../lib/format_selection_menu"

export default class extends Controller {
  static targets = ["editable"]
  static values = { editableOnRender: Boolean }

  fragment_type = ""

  connect() {
    console.log("editable_on_render", this.editableOnRenderValue)
    this.set_fragment_type()
    setTimeout(() => {
      this.element.classList.remove("saved")
      if (this.editableOnRenderValue) this.click()
    }, 300)
  }

  click() {
    const editable = this.editableTarget
    editable.setAttribute("contenteditable", "true")
    editable.classList.add("is-editing")
    editable.focus()
  }

  blur() {
    console.log("blur")
    this.editableTarget.removeAttribute("contenteditable")
    this.editableTarget.classList.remove("is-editing")
    this.save()
  }

  keyDown(event) {
    const actions = {
      Enter: () => {
        event.preventDefault()
        this.fragment_type === "pre"
          ? this.insertTextAtCursor('\n')
          : this.fragment_type === "p"
            ? this.insertLineBreak()
            : this.editableTarget.removeAttribute("contenteditable")
      },
      Tab: () => {
        if (["pre", "p"].includes(this.fragment_type)) {
          event.preventDefault()
          this.insertTextAtCursor('  ')
        }
      }
    }
    if (actions[event.key]) actions[event.key]()
  }

  insertTextAtCursor(text) {
    const selection = window.getSelection()
    const range = selection.getRangeAt(0)
    range.deleteContents()
    const textNode = document.createTextNode(text)
    range.insertNode(textNode)
    range.setStartAfter(textNode)
    range.setEndAfter(textNode)
    selection.removeAllRanges()
    selection.addRange(range)
  }

  insertLineBreak() {
    const selection = window.getSelection()
    const range = selection.getRangeAt(0)
    const br = document.createElement('br')
    range.deleteContents()
    range.insertNode(br)
    range.setStartAfter(br)
    range.setEndAfter(br)
    selection.removeAllRanges()
    selection.addRange(range)

    const textNode = document.createTextNode('\u00A0')
    range.insertNode(textNode)
    range.setStartAfter(textNode)
    range.setEndAfter(textNode)
    selection.removeAllRanges()
    selection.addRange(range)

    textNode.nodeValue = ''
  }

  mouseDown() {
    rangy.getSelection().removeAllRanges()
  }

  mouseUp() {
    let selection = rangy.getSelection()
    if (!selection.isCollapsed) {
      rangy.getSelection().trim()
      show_format_selection_menu(this.editableTarget)
    }
  }

  paste(event) {
    event.preventDefault()
    const content = event.clipboardData?.getData('text/plain')
    if (content) {
      const selection = window.getSelection()
      const range = selection.getRangeAt(0)
      range.deleteContents()
      range.insertNode(document.createTextNode(content))
    }
  }

  set_fragment_type() {
    const typeClasses = ["h1", "h2", "h3", "p", "pre"]
    this.fragment_type = typeClasses.find(type => this.element.classList.contains(type)) || ""
  }

  save() {
    console.log("save")
    const markdown = turndownService().turndown(this.editableTarget)
    this.element.querySelector("#fragment_data").value = markdown
    this.element.querySelector("#fragment_form input[type='submit']").click()
  }
}
