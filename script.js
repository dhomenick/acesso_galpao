// ==UserScript==
// @name        Automação Visitante IN
// @namespace   http://tampermonkey.net/
// @version     1.0
// @description Automação para o site visitante.in
// @match       https://visitante.in/cal*
// @grant       none
// ==/UserScript==


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

// Função robusta de preenchimento simulado
async function preencherInputSimulado(seletor, valor) {
    const input = document.querySelector(seletor);
    if (!input) {
        console.warn(`Input "${seletor}" não encontrado.`);
        return false;
    }
    input.focus();
    
    const nativeInputValueSetter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, "value").set;
    if (nativeInputValueSetter) {
        nativeInputValueSetter.call(input, valor);
    } else {
        input.value = valor;
    }

    input.dispatchEvent(new Event('input', { bubbles: true }));
    input.dispatchEvent(new Event('change', { bubbles: true }));
    input.blur();
    console.log(`Campo preenchido com: "${valor}"`);
    return true;
}

// Fluxo automatizado completo
(async () => {
    console.log("Passo 1: Procurando pelo botão 'Iniciar'...");
    if (await clicarBotaoPorTexto("Iniciar")) {
        await new Promise(r => setTimeout(r, 1000));
        
        console.log("Passo 2: Clicando em 'Sim'...");
        await clicarBotaoPorTexto("Sim");
        await new Promise(r => setTimeout(r, 1500));
        
        console.log("Passo 3: Selecionando 'Mercado Livre'...");
        await clicarBotaoPorTexto("Mercado Livre");
        await new Promise(r => setTimeout(r, 1500));
        
        console.log("Passo 4: Selecionando 'Motorista'...");
        await clicarBotaoPorTexto("Motorista");
        await new Promise(r => setTimeout(r, 1500));
        
        console.log("Passo 5: Selecionando 'Carro'...");
        await clicarBotaoPorTexto("Carro");
        await new Promise(r => setTimeout(r, 1500));
        
        // Passo 6: Placa
        const minhaPlaca = "SUA_PLACA_AQUI"; 
        await preencherInputSimulado('input[placeholder*="placa" i], input[type="text"]', minhaPlaca);
        await new Promise(r => setTimeout(r, 1000));
        
        console.log("Passo 6: Clicando em 'Avançar' após a placa...");
        await clicarBotaoPorTexto("Avançar");
        await new Promise(r => setTimeout(r, 1500));
        
        // Passo 7: Empresa (Caso queira garantir o campo certo, tente usar um seletor mais específico se houver placeholder)
        await preencherInputSimulado('input[type="text"]', "Mercado Livre");
        await new Promise(r => setTimeout(r, 1000));
        
        console.log("Passo 8: Clicando em 'Avançar'...");
        await clicarBotaoPorTexto("Avançar");

        // Passo 9: Avançar sem ajudante
        console.log("Passo 9: avançar sem ajudante")
        await clicarBotaoPorTexto("Avançar sem ajudante");
       
    }
})();