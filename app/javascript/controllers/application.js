import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Import and register all TailwindCSS Components or just the ones you need
import { Alert, Dropdown } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('dropdown', Dropdown)


// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }