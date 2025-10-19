package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Candidato;
import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Curso;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ICandidatoRepository;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ICursoRepository;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class AutenticacaoController {

    @Autowired
    private ICandidatoRepository candidatoRep;
    @Autowired
    private ICursoRepository cursoRep;
    
    /**
     * Exibe a página de autenticação do candidato.
     * O seu JSP 'autenticacao.jsp' parece ter um formulário de cadastro e um de login.
     * Este método simplesmente exibe essa página.
     */
    @GetMapping("/autenticacao")
    public ModelAndView autenticacaoGet(@RequestParam Map<String, String> params, HttpSession session) {
    	List<Curso> cursos = new LinkedList<>();
    	
    	cursos = cursoRep.findAll();
    	
    	session.setAttribute("cursos",cursos);
        return new ModelAndView("autenticacao");
    }

    /**
     * Processa a tentativa de login do CANDIDATO.
     * O formulário de login na autenticacao.jsp deve ter action="autenticarCandidato".
     */
    @PostMapping("/autenticacao")
    public ModelAndView autenticarCandidato(@RequestParam Map<String, String> params, ModelMap model, HttpSession session) {
        // Supondo que o login do candidato é por email e senha
    	String saida = "";
    	String erro = "";
    	String url = "";
    	
    	String usuario = params.get("usuario");
    	String email = params.get("email");
    	
    	String auth = params.get("auth");
    	
    	String consentimento = params.get("consentimento");
    	
    	System.out.println(consentimento);
    	
    	Candidato candidato = new Candidato();
    	
    	try {
        	if(auth.equals("cadastro")) {
        		String nome = params.get("nome");
        		String telefone = params.get("telefone");
            	String bairro = params.get("bairro");
            	String cursoId = params.get("cursoId");
            	boolean aceite = consentimento.equals("on") ? true : false;
            	
            	saida = candidatoRep.sp_inserir_candidato(nome, email, telefone, bairro, Long.parseLong(cursoId), aceite);
            	usuario = nome;
        	} else if(auth.equals("login")) {
        		saida = candidatoRep.sp_login_candidato(usuario, email);
        	}
        	candidato = candidatoRep.findByNome(usuario);
        	

        	url = "candidato";
    	} catch(Exception e) {
    		url = "autenticacao";
    		erro = e.toString();
    	}
    	
    	model.addAttribute("erro", erro);
    	model.addAttribute("saida", saida);
    	model.addAttribute("candidato", candidato);

        return new ModelAndView(url);
    }

}