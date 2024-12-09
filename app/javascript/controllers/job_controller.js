// app/javascript/controllers/job_controller.js
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="job"
export default class extends Controller {
  static targets = ["emailField", "jobSelect"];

  connect() {
    // Inicializa la visibilidad del campo email al cargar la página
    this.updateEmailField();
  }

  updateEmailField(event) {
    // Obtiene el valor seleccionado (al cargar o al cambiar)
    const selectedValue = event ? event.target.value : this.jobSelectTarget.value;

    // Muestra u oculta el campo email según el valor seleccionado
    if (selectedValue === "Job Encolado") {
      this.emailFieldTarget.classList.remove("hidden");
    } else {
      this.emailFieldTarget.classList.add("hidden");
    }
  }
}

