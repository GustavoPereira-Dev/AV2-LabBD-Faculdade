package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Candidato;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CandidatoController {

    @GetMapping("/candidato")
    public ModelAndView candidatoHome(HttpSession session, ModelMap model) {
        
        Candidato candidato = (Candidato) session.getAttribute("candidato");
        if (candidato == null) {
            return new ModelAndView("redirect:/autenticacao");
        }

        String ultimaCuriosidade = (String) session.getAttribute("ultimaCuriosidade");

        model.addAttribute("candidato", candidato);
        if (ultimaCuriosidade != null) {
            model.addAttribute("ultimaCuriosidade", ultimaCuriosidade);
        }

        return new ModelAndView("candidato");
    }

    @GetMapping("/candidato/logout")
    public ModelAndView logout(HttpSession session) {
        session.removeAttribute("candidato");
        session.invalidate();
        return new ModelAndView("redirect:/autenticacao");
    }
}