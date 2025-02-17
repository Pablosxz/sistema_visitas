// Script para buscar o visitante pelo CPF
document.addEventListener("DOMContentLoaded", function() {
    const cpfField = document.getElementById("visitor_cpf");
    const visitorDetails = document.getElementById("visitor_details");
    const visitorName = document.getElementById("visitor_name");
    const visitorRg = document.getElementById("visitor_rg");
    const visitorPhone = document.getElementById("visitor_phone");
    const visitorIdField = document.getElementById("visitor_id");
    const visitorActive = document.getElementById("visitor_active");
    const saveButton = document.getElementById("save_visit_button");
  
    cpfField.addEventListener("input", function() {
      const cpf = this.value.replace(/\D/g, ""); // Remove caracteres não numéricos
  
      if (cpf.length === 11) { // Verifica se o CPF tem 11 dígitos
        fetch(`/visitors/search?cpf=${cpf}`)
          .then(response => response.json())
          .then(data => {
            if (data) {
              visitorName.textContent = data.name;
              visitorRg.textContent = data.rg;
              visitorPhone.textContent = data.phone;
              visitorIdField.value = data.id;
              visitorActive.textContent = data.active ? "✅ Ativo" : "❌ Inativo";
              visitorDetails.classList.remove("d-none");
  
              saveButton.disabled = !data.active;
              if (!data.active) {
                alert("Este visitante está inativo. Reative-o antes de registrar a visita.");
              }
            } else {
              visitorName.textContent = "";
              visitorRg.textContent = "";
              visitorPhone.textContent = "";
              visitorIdField.value = "";
              visitorDetails.classList.add("d-none");
              saveButton.disabled = true;
              alert("Visitante não encontrado. Por favor, cadastre-o primeiro.");
            }
          })
          .catch(error => console.error("Erro ao buscar visitante:", error));
      }
    });
  });
  
  // Script para atualizar dinamicamente os funcionários
  document.addEventListener("DOMContentLoaded", function() {
    const sectorSelect = document.getElementById("sector_select");
    const employeeSelect = document.getElementById("employee_select");
  
    sectorSelect.addEventListener("change", function() {
      const sectorId = this.value;
  
      if (sectorId) {
        // Faz uma requisição AJAX para buscar os funcionários do setor selecionado
        fetch(`/sectors/${sectorId}/employees`)
          .then(response => response.json())
          .then(data => {
            // Limpa as opções atuais
            employeeSelect.innerHTML = '<option value="">Selecione um funcionário</option>';
  
            // Adiciona as novas opções
            data.forEach(employee => {
              const option = document.createElement("option");
              option.value = employee.id;
              option.textContent = employee.name;
              employeeSelect.appendChild(option);
            });
          })
          .catch(error => {
            console.error("Erro ao buscar funcionários:", error);
          });
      } else {
        // Se nenhum setor for selecionado, limpa a lista de funcionários
        employeeSelect.innerHTML = '<option value="">Selecione um funcionário</option>';
      }
    });
  });
  