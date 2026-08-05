const modal = document.getElementById("modal");
const modalTitulo = document.getElementById("modal-titulo");
const openBtn = document.getElementById("openModal");
const erro = document.getElementById("erro-message");



// funcao para abrir o modal
openBtn.addEventListener("click", () => {
    // limpa os campos independente se for para criar ou editar
    document.getElementById("aluno_id").value = "";
    document.getElementById("modal-form").reset();

    modalTitulo.textContent = "Novo aluno";

    modal.style.display = "flex";
});



// funcoes de fechar tambem resetam campos do form
document.querySelectorAll(".close").forEach(btn => {
    btn.addEventListener("click", () => {
        modal.style.display = "none";
        document.getElementById("aluno_id").value = "";
        document.getElementById("modal-form").reset();
        modalTitulo.textContent = "Novo aluno";
        erro.style.display = "none";
    });
});

// fechar ao clicar fora do modal
modal.addEventListener("click", (event) => {
    if (event.target === modal) {
        modal.style.display = "none";
        document.getElementById("aluno_id").value = "";
        document.getElementById("modal-form").reset();
        modalTitulo.textContent = "Novo aluno";
        erro.style.display = "none";
    }
});



// funcao para preencher modal para edicao de dados antes de abrir
function abrirModalEdicao(alunoId, nome, cpf, telefone, dataNascimento, turmaId) {
    document.getElementById("aluno_id").value = alunoId;

    document.getElementById("nome").value = nome;
    document.getElementById("cpf").value = cpf;
    document.getElementById("telefone").value = telefone;
    document.getElementById("data_nascimento").value = dataNascimento;
    document.getElementById("turma").value = turmaId;

    modalTitulo.textContent = "Editar aluno";

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

