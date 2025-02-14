// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'select2';
import 'select2/dist/css/select2.css';

// app/javascript/packs/application.js (ou em um arquivo JavaScript específico)

document.addEventListener("DOMContentLoaded", function() {
    // Inicializa o Select2 para o campo de visitantes
    $('#visit_visitor_id').select2({
      placeholder: "Selecione um visitante",
      allowClear: true
    });
  
    // Inicializa o Select2 para o campo de funcionários
    $('#visit_employee_id').select2({
      placeholder: "Selecione um funcionário",
      allowClear: true
    });
  });