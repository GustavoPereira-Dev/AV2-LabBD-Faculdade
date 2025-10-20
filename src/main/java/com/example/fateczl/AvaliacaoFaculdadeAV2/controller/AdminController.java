package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.IAdministradorRepository;
import jakarta.servlet.http.HttpSession;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {

    @Autowired
    private IAdministradorRepository adminRep;

    @GetMapping("/admin")
    public ModelAndView adminGet(@RequestParam Map<String, String> params, ModelMap model) {
    	String login = params.get("login");
    	model.addAttribute("admin", login);
        return new ModelAndView("admin");
    }

    @PostMapping("/admin")
    public ModelAndView adminPost(@RequestParam Map<String, String> params, ModelMap model) {
    	String saida = "";
    	String erro = "";
    	
    	String login = params.get("login");
    	String senha = params.get("senha");
    	
    	try {
            saida = adminRep.sp_login_admin(login, senha);
            
            model.addAttribute("saida", saida);
            model.addAttribute("erro", erro);
            model.addAttribute("admin", login);
            
    	} catch(Exception e) {
    		erro = e.toString();
    	}
        
        return new ModelAndView("admin");
    }

    @GetMapping("/administrador/logout")
    public ModelAndView logout(HttpSession session) {
        session.invalidate();
        return new ModelAndView("redirect:/");
    }
}