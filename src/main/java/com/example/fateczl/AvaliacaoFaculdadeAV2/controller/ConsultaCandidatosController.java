package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ConsultaCandidatosController {

//	@Autowired
//	private ClienteDao cDao;

	@RequestMapping(name = "consultaCandidatos", value = "/consultaCandidatos", method = RequestMethod.GET)
	public ModelAndView consultaCandidatosGet(
			@RequestParam Map<String, String> 
			params, 
			ModelMap model) {
//			String acao = params.get("acao");
//			String cpf = params.get("cpf");
//
//			Cliente c = new Cliente();
//			String erro = "";
//			List<Cliente> clientes = new ArrayList<>();
//
//				try {
//					if (acao != null) {
//						c.setCpf(cpf);
//
//						if (acao.equalsIgnoreCase("excluir")) {
//							cDao.excluir(c);
//							clientes = cDao.listar();
//							c = null;
//						} else {
//							c = cDao.buscar(c);
//							clientes = null;
//						}
//					}
//				} catch (SQLException | ClassNotFoundException e) {
//					erro = e.getMessage();
//				} finally {
//					model.addAttribute("erro", erro);
//					model.addAttribute("cliente", c);
//					model.addAttribute("clientes", clientes);
//				}
			return new ModelAndView("consultaCandidatos");
	}

	@RequestMapping(name = "consultaCandidatos", value = "/consultaCandidatos", method = RequestMethod.POST)
	public ModelAndView consultaCandidatosPost(
			@RequestParam Map<String, String> params, 
			ModelMap model) {
		String saida = "";
		String erro = "";
//		List<Cliente> clientes = new ArrayList<Cliente>();
//		Cliente c = new Cliente();
//		String cmd = "";
//
//		try {
//			String cpf = params.get("cpf");
//			String nome = params.get("nome");
//			String email = params.get("email");
//			String limiteCredito = params.get("limite_credito");
//			String nascimento = params.get("nascimento");
//			cmd = params.get("botao");
//
//			if (!cmd.equalsIgnoreCase("Listar")) {
//				c.setCpf(cpf);
//			}
//			if (cmd.equalsIgnoreCase("Inserir") || cmd.equalsIgnoreCase("Atualizar")) {
//				c.setNome(nome);
//				c.setEmail(email);
//				c.setLimiteCredito(Float.parseFloat(limiteCredito));
//				c.setDtNasc(LocalDate.parse(nascimento));
//			}
//
//			if (cmd.equalsIgnoreCase("Inserir")) {
//				saida = cDao.inserir(c);
//			}
//			if (cmd.equalsIgnoreCase("Atualizar")) {
//				saida = cDao.atualizar(c);
//			}
//			if (cmd.equalsIgnoreCase("Excluir")) {
//				saida = cDao.excluir(c);
//			}
//			if (cmd.equalsIgnoreCase("Buscar")) {
//				c = cDao.buscar(c);
//			}
//			if (cmd.equalsIgnoreCase("Listar")) {
//				System.out.println("Listando");
//				clientes = cDao.listar();
//			}
//
//		} catch (SQLException | ClassNotFoundException | NumberFormatException e) {
//			saida = "";
//			erro = e.getMessage();
//			if (erro.contains("input string")) {
//				erro = "Preencha os campos corretamente";
//			}
//		} finally {
//			if (!cmd.equalsIgnoreCase("Buscar")) {
//				c = null;
//			}
//			if (!cmd.equalsIgnoreCase("Listar")) {
//				clientes = null;
//			}
//			
//			model.addAttribute("erro", erro);
//			model.addAttribute("saida", saida);
//			model.addAttribute("cliente", c);
//			model.addAttribute("clientes", clientes);
//			
//		}

		return new ModelAndView("consultaCandidatos");
	}
}