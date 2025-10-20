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

    @GetMapping("/cadastraTipo")
    public ModelAndView editarMensagemGet(@RequestParam Map<String, String> params, ModelMap model, HttpSession session) {
    	model.addAttribute("listaMensagens", curiosidadeRep.findAll());
        model.addAttribute("times", timeRep.findAll());
        
        return new ModelAndView("cadastraTipo");
    }

    @PostMapping("/cadastraTipo")
    public ModelAndView salvarMensagem(@RequestParam Map<String, String> params, ModelMap model, HttpSession session) {
        String saida = "";
        String erro = "";
    	
        String conteudo = params.get("conteudo");
        String idTime = params.get("timeId");
        String button = params.get("button");
        
        System.out.println(button);
        
        Curiosidade curiosidade = new Curiosidade();
        List<Curiosidade> curiosidades = new LinkedList<>();
        
        try {
        	if(button.equals("Filtrar")) {
        		curiosidades = curiosidadeRep.buscarPorCodigoDoTime(Long.parseLong(idTime));
        	} else if(button.equals("Salvar")) {
                curiosidade.setAdministrador(administradorRep.findByCodigo(1));
                curiosidade.setConteudo(conteudo);
                curiosidade.setTime(timeRep.findByCodigo(Long.parseLong(idTime)));
                curiosidadeRep.save(curiosidade);
                saida = "Curiosidade adicionada com sucesso!";
                curiosidades = curiosidadeRep.findAll();
        	}
        } catch (Exception e) {
        	erro = e.getMessage();
        }
        
        model.addAttribute("listaMensagens", curiosidades);
    	model.addAttribute("erro", erro);
    	model.addAttribute("saida", saida);
    	model.addAttribute("times", timeRep.findAll());
        
        return new ModelAndView("cadastraTipo");
    }
}