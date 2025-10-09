package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MensagemController {

	@RequestMapping(name = "mensagem", value = "/mensagem", method = RequestMethod.GET)
	public ModelAndView MensagemGet(ModelMap model) {
		return new ModelAndView("mensagem");
	}

}
