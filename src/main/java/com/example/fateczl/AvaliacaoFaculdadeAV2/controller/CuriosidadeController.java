package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CuriosidadeController {

	@RequestMapping(name = "curiosidade", value = "/curiosidade", method = RequestMethod.GET)
	public ModelAndView curiosidadeGet(ModelMap model) {
		return new ModelAndView("curiosidade");
	}

}
