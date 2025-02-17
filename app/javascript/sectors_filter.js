document.addEventListener("DOMContentLoaded", function() {
    const unitSelect = document.getElementById("unit_select");
    const sectorSelect = document.getElementById("sector_select");

    // Monitora mudanças no campo "Unidade"
    unitSelect.addEventListener("change", function() {
      const unitId = this.value;

      if (unitId) {
        // Habilita o campo "Setor"
        sectorSelect.disabled = false;

        // Faz uma requisição AJAX para buscar os setores da unidade selecionada
        fetch(`/units/${unitId}/sectors`)
          .then(response => response.json())
          .then(data => {
            // Limpa as opções atuais do campo "Setor"
            sectorSelect.innerHTML = '<option value="">Todos</option>';

            // Adiciona as novas opções
            data.forEach(sector => {
              const option = document.createElement("option");
              option.value = sector.id;
              option.textContent = sector.name;
              sectorSelect.appendChild(option);
            });
          })
          .catch(error => {
            console.error("Erro ao carregar setores:", error);
          });
      } else {
        // Desabilita o campo "Setor" e limpa as opções
        sectorSelect.disabled = true;
        sectorSelect.innerHTML = '<option value="">Todos</option>';
      }
    });

    // Dispara o evento "change" ao carregar a página se uma unidade já estiver selecionada
    if (unitSelect.value) {
      unitSelect.dispatchEvent(new Event("change"));
    }
  });