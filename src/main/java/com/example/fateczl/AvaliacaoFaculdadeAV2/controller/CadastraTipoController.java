package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.*;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Controller
public class CadastraTipoController {

    @Autowired private ICuriosidadeRepository curiosidadeRep;
    @Autowired private ITimeRepository timeRep;
    @Autowired private IAdministradorRepository administradorRep;

    @GetMapping("admin/cadastraTipo")
    public ModelAndView mensagensGet(ModelMap model, HttpSession session) {
        if (session.getAttribute("admin") == null) { return new ModelAndView("redirect:/login"); }

        model.addAttribute("listaMensagens", curiosidadeRep.findAll());
        model.addAttribute("times", timeRep.findAll());
        model.addAttribute("mensagem", new Curiosidade());
        return new ModelAndView("cadastraTipo");
    }

    @GetMapping("/cadastraTipo")
    public ModelAndView editarMensagemGet(@RequestParam Map<String, String> params, ModelMap model, HttpSession session) {
    	
    	String id = params.get("id");
    	String time = params.get("timeId");
    	String filtrar = params.get("filtrar");
    	
    	List<Curiosidade> curiosidades = new LinkedList<>();
    	

    	curiosidades = curiosidadeRep.findAll();
    	
        //if (session.getAttribute("admin") == null) { return new ModelAndView("redirect:/login"); }
        
    	model.addAttribute("listaMensagens", curiosidadeRep.findAll());

    	
    	
        model.addAttribute("times", timeRep.findAll());
        //curiosidadeRep.findById(id).ifPresent(c -> model.addAttribute("mensagem", c));
        
        return new ModelAndView("cadastraTipo");
    }

    @PostMapping("/cadastraTipo")
    public ModelAndView salvarMensagem(@RequestParam Map<String, String> params, ModelMap model, HttpSession session) {
        //if (session.getAttribute("admin") == null) { return new ModelAndView("redirect:/login"); }
        String saida = "";
        String erro = "";
    	
        String conteudo = params.get("conteudo");
        String idTime = params.get("timeId");
        
        Curiosidade curiosidade = new Curiosidade();
        
        curiosidade.setAdministrador(administradorRep.getById(1l));
        curiosidade.setConteudo(conteudo);
        curiosidade.setTime(timeRep.getById(Long.parseLong(idTime)));
        
        
        try {
            curiosidadeRep.save(curiosidade);
            saida = "Curiosidade adicionada com sucesso!";
        } catch (Exception e) {
        	erro = e.getMessage();
            // ... Tratamento de erro ...
        }
        
        System.out.println(saida + " " + erro);
    	model.addAttribute("erro", erro);
    	model.addAttribute("saida", saida);
        
        return new ModelAndView("cadastraTipo");
    }
}