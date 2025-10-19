package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Time;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ICuriosidadeRepository;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ITimeRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CuriosidadeController {

    @Autowired
    private ICuriosidadeRepository curiosidadeRep;

    @Autowired
    private ITimeRepository timeRep;

    @GetMapping("/curiosidade")
    public ModelAndView curiosidadeGet(@RequestParam("timeId") Long timeId, ModelMap model, HttpSession session) {
        String erro = "";
        try {
        	String conteudoCuriosidade = curiosidadeRep.sp_gerenciar_sorteio_curiosidade(timeId);
        	System.out.println(conteudoCuriosidade + " Conteudo");
            if (conteudoCuriosidade == null || conteudoCuriosidade.contains("Nenhuma curiosidade")) {
                throw new Exception("Não foi possível obter uma curiosidade.");
            }
            Time time = timeRep.findById(timeId).orElse(new Time());
            
            System.out.println(conteudoCuriosidade + " asasdads " + time.getNome());
            model.addAttribute("conteudoCuriosidade", conteudoCuriosidade);
            model.addAttribute("timeNome", time.getNome());
            session.setAttribute("ultimaCuriosidade", conteudoCuriosidade);
        } catch (Exception e) {
            erro = e.getMessage();
            System.out.println(erro);
        }
        model.addAttribute("erro", erro);
        return new ModelAndView("curiosidade");
    }
}