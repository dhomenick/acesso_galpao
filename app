// Função genérica para esperar e clicar no botão pelo texto
async function clicarBotaoPorTexto(textoDesejado, tempoLimiteMs = 10000) {
    const inicio = Date.now();
    
    while (Date.now() - inicio < tempoLimiteMs) {
        const elementos = document.querySelectorAll('button, a, input[type="button"], input[type="submit"], div, span');
        
        for (let el of elementos) {
            const texto = el.innerText ? el.innerText.trim() : '';
            if (texto.toLowerCase() === textoDesejado.toLowerCase()) {
                if (el.offsetParent !== null) {
                    el.click();
                    console.log(`Botão "${textoDesejado}" clicado com sucesso.`);
                    return true;
                }
            }
        }
        await new Promise(resolve => setTimeout(resolve, 200));
    }
    
    console.warn(`Botão com o texto "${textoDesejado}" não foi encontrado.`);
    return false;
}

// Função para simular a digitação de texto em frameworks modernos
function preencherInputSimulado(seletor, valor) {
    const input = document.querySelector(seletor);
    if (!input) {
        console.warn(`Input "${seletor}" não encontrado.`);
        return false;
    }
    input.focus();
    input.value = valor;
    input.dispatchEvent(new Event('input', { bubbles: true }));
    input.dispatchEvent(new Event('change', { bubbles: true }));
    console.log(`Campo preenchido com: "${valor}"`);
    return true;
}

// Fluxo automatizado completo até a tela de informações adicionais:
(async () => {
    console.log("Passo 1: Procurando pelo botão 'Iniciar'...");
    const clicouIniciar = await clicarBotaoPorTexto("Iniciar");
    
    if (clicouIniciar) {
        console.log("Aguardando o pop-up de check-in anterior aparecer...");
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        console.log("Passo 2: Respondendo ao pop-up (clicando em 'Sim')...");
        await clicarBotaoPorTexto("Sim");
        
        console.log("Aguardando a tela de seleção de destino carregar...");
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        console.log("Passo 3: Selecionando o destino 'Mercado Livre'...");
        await clicarBotaoPorTexto("Mercado Livre");
        
        console.log("Aguardando a tela de perfil carregar...");
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        console.log("Passo 4: Selecionando o perfil 'Motorista'...");
        await clicarBotaoPorTexto("Motorista");
        
        console.log("Aguardando a tela de forma de entrada carregar...");
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        console.log("Passo 5: Selecionando 'Carro'...");
        await clicarBotaoPorTexto("Carro");
        
        console.log("Aguardando a tela de dados do veículo carregar...");
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        // Placa configurada para preenchimento automático
        const minhaPlaca = "XXXXXX"; 
        const inputPlaca = document.querySelector('input[placeholder*="placa"], input[type="text"]');
        if (inputPlaca) {
            preencherInputSimulado('input[placeholder*="placa"], input[type="text"]', minhaPlaca);
            await new Promise(resolve => setTimeout(resolve, 1000));
        }
        
        console.log("Passo 6: Clicando em 'Avançar' após a placa...");
        await clicarBotaoPorTexto("Avançar");
        
        console.log("Aguardando a tela de informações adicionais carregar...");
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        // Passo 7: Preenchendo a empresa que representa
        const inputsTexto = document.querySelectorAll('input[type="text"]');
        if (inputsTexto.length > 0) {
            // Geralmente o primeiro input desta tela é o da empresa
            preencherInputSimulado('input[type="text"]', "Mercado livre");
            await new Promise(resolve => setTimeout(resolve, 1000));
        }
        
        console.log("Passo 8: Clicando em 'Avançar' na tela de informações adicionais...");
        await clicarBotaoPorTexto("Avançar");
    }
})();