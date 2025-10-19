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

    /**
     * Exibe a página principal do admin.
     * O JSP 'admin.jsp' decidirá se mostra o login ou o dashboard.
     */
    @GetMapping("/admin")
    public ModelAndView adminHome() {
        return new ModelAndView("admin");
    }

    /**
     * Processa a tentativa de login do ADMINISTRADOR.
     * O formulário na admin.jsp deve ter action="autenticarAdmin".
     */
    @PostMapping("/admin")
    public ModelAndView autenticarAdmin(@RequestParam Map<String, String> params, ModelMap model) {
    	String saida = "";
    	String erro = "";
    	
    	String login = params.get("login");
    	String senha = params.get("senha");
    	
    	System.out.println(login + " " + senha);
    	
        saida = adminRep.sp_login_admin(login, senha);

//        if (adminOpt != null) {
//            session.setAttribute("admin", adminOpt);
//            return new ModelAndView("redirect:/admin");
//        } else {
//            return new ModelAndView("redirect:/admin?error=true");
//        }
        
        model.addAttribute("saida", saida);
        model.addAttribute("erro", erro);
        model.addAttribute("admin", login);
        
        return new ModelAndView("admin");
    }

    /**
     * Faz o logout do ADMINISTRADOR.
     */
    @GetMapping("/admintsas")
    public ModelAndView logout(HttpSession session) {
        session.invalidate();
        return new ModelAndView("redirect:/");
    }
}