import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import { put } from '@rails/request.js'

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    group: String,
    idPrefix: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      group: this.groupValue,
    })
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl

    if (!sortableUpdateUrl) {
      this.set_positions()
    }
    else {
      var sortableColumnId = event.to.dataset.sortableColumnId

      put(sortableUpdateUrl, {
        body: JSON.stringify({ row_position: event.newIndex + 1, column_id: sortableColumnId })
      })
    }
  }

  intialise_positions(event) {
    this.set_positions()
  }

  set_positions() {
    var order = this.sortable.toArray();
    order.forEach((value, index) => {
      var sortablePositionElement = document.getElementById(this.idPrefixValue + value + "_position")

      sortablePositionElement.value = index + 1

      console.log(sortablePositionElement)
    });
  }
}