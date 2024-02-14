import { Application} from "@hotwired/stimulus"
// import { ShowDoctorsController } from "./show_doctors_controller.js"


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Stimulus.register("show-doctors", ShowDoctorsController)

export { application }
import ReportTypeController from "../controllers/report_type_controller"
Stimulus.register("report-type", ReportTypeController)
