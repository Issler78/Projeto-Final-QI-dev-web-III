const modal = document.getElementById("modal");
const modalTitulo = document.getElementById("modal-titulo");
const openBtn = document.getElementById("openModal");
const erro = document.getElementById("erro-message");



// funcao para abrir o modal
openBtn.addEventListener("click", () => {
    // limpa os campos independente se for para criar ou editar
    document.getElementById("turma_id").value = "";
    document.getElementById("modal-form").reset();

    modalTitulo.textContent = "Nova turma";

    if (erro) {
        erro.textContent = "";
        erro.style.display = "none";
    }

    modal.style.display = "flex";
});



// funcoes de fechar tambem resetam campos do form
document.querySelectorAll(".close").forEach(btn => {
    btn.addEventListener("click", () => {
        modal.style.display = "none";
        document.getElementById("turma_id").value = "";
        document.getElementById("modal-form").reset();
        modalTitulo.textContent = "Nova turma";

        if (erro) {
            erro.textContent = "";
            erro.style.display = "none";
        }
    });
});



// fechar ao clicar fora do modal
modal.addEventListener("click", (event) => {
    if (event.target === modal) {
        modal.style.display = "none";
        document.getElementById("turma_id").value = "";
        document.getElementById("modal-form").reset();
        modalTitulo.textContent = "Nova turma";

        if (erro) {
            erro.textContent = "";
            erro.style.display = "none";
        }
    }
});



// funcao para preencher modal para edicao de dados antes de abrir
function abrirModalEdicao(turmaId, sala, nivel, serie) {
    document.getElementById("turma_id").value = turmaId;

    document.getElementById("sala").value = sala;
    document.getElementById("nivel").value = nivel;
    document.getElementById("serie").value = serie;

    modalTitulo.textContent = "Editar turma";

    if (erro) {
        erro.textContent = "";
        erro.style.display = "none";
    }

    modal.style.display = "flex";
}