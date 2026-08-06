const modal = document.getElementById("modal");
const modalTitulo = document.getElementById("modal-titulo");
const openBtn = document.getElementById("openModal");
const erro = document.getElementById("erro-message");



// funcao para abrir o modal
openBtn.addEventListener("click", () => {
    // limpa os campos independente se for para criar ou editar
    document.getElementById("professor_id").value = "";
    document.getElementById("modal-form").reset();
    document.querySelectorAll('input[name="disciplina_id"]').forEach(cb => {
        cb.checked = false;
    });

    modalTitulo.textContent = "Novo professor";

    modal.style.display = "flex";
});



// funcoes de fechar tambem resetam campos do form
document.querySelectorAll(".close").forEach(btn => {
    btn.addEventListener("click", () => {
        modal.style.display = "none";
        document.getElementById("professor_id").value = "";
        document.getElementById("modal-form").reset();
        document.querySelectorAll('input[name="disciplina_id"]').forEach(cb => {
            cb.checked = false;
        });
        modalTitulo.textContent = "Novo professor";
        erro.style.display = "none";
    });
});

// fechar ao clicar fora do modal
modal.addEventListener("click", (event) => {
    if (event.target === modal) {
        modal.style.display = "none";
        document.getElementById("professor_id").value = "";
        document.getElementById("modal-form").reset();
            document.querySelectorAll('input[name="disciplina_id"]').forEach(cb => {
        cb.checked = false;
    });
        modalTitulo.textContent = "Novo professor";
        erro.style.display = "none";
    }
});



// funcao para preencher modal para edicao de dados antes de abrir
function abrirModalEdicao(professorId, nome, cpf, telefone, dataNascimento, disciplinasIds) {
    document.getElementById("professor_id").value = professorId;
    document.getElementById("nome").value = nome;
    document.getElementById("cpf").value = cpf;
    document.getElementById("telefone").value = telefone;
    document.getElementById("data_nascimento").value = dataNascimento;

    const checkboxes = document.querySelectorAll('input[name="disciplina_id"]');

    checkboxes.forEach(checkbox => {
        checkbox.checked = disciplinasIds.includes(Number(checkbox.value));
    });

    modalTitulo.textContent = "Editar professor";
    modal.style.display = "flex";
}



// funcao de validacao para campos
function apenasNumeros(campo, tamanhoMax) {
    campo.addEventListener("input", () => {
        campo.value = campo.value.replace(/\D/g, "").slice(0, tamanhoMax);
    });
}

apenasNumeros(document.getElementById("telefone"), 11);
apenasNumeros(document.getElementById("cpf"), 11);

