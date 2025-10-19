package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Time;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ITimeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;

@Controller
public class EscolhaController {

    @Autowired
    private ITimeRepository timeRep;

    @GetMapping("/escolha")
    public ModelAndView escolhaTime(ModelMap model) {
        List<Time> times = timeRep.findAll();
        model.addAttribute("times", times);
        return new ModelAndView("escolha");
    }
}