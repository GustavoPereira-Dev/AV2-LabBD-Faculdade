package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Candidato;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CandidatoController {

    /**
     * Exibe o dashboard principal do candidato após o login.
     * Esta rota '/home' é para onde o 'AutenticacaoController' redireciona
     * após um login de candidato bem-sucedido.
     */
    @GetMapping("/candidato")
    public ModelAndView candidatoHome(HttpSession session, ModelMap model) {
        
        // 1. GUARDA DE SEGURANÇA: Verifica se há um candidato na sessão
        Candidato candidato = (Candidato) session.getAttribute("candidato");
        if (candidato == null) {
            // Se não houver, redireciona para a página de login do candidato
            return new ModelAndView("redirect:/autenticacao");
        }

        // 2. RECUPERA DADOS DA SESSÃO
        // Tenta recuperar a última curiosidade que o candidato viu
        String ultimaCuriosidade = (String) session.getAttribute("ultimaCuriosidade");

        // 3. ENVIA DADOS PARA A VIEW
        model.addAttribute("candidato", candidato);
        if (ultimaCuriosidade != null) {
            model.addAttribute("ultimaCuriosidade", ultimaCuriosidade);
        }

        return new ModelAndView("candidato");
    }

    /**
     * Processa o logout do candidato.
     * Remove o candidato da sessão e redireciona para a página de login.
     */
    @GetMapping("/candidato/logout")
    public ModelAndView logout(HttpSession session) {
        session.removeAttribute("candidato");
        session.invalidate(); // Invalida a sessão inteira
        return new ModelAndView("redirect:/autenticacao");
    }
}