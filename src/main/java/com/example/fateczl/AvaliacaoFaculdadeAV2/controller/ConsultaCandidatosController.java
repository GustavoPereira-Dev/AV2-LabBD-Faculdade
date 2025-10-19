package com.example.fateczl.AvaliacaoFaculdadeAV2.controller;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Candidato;
import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Curso;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ICandidatoRepository;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ICursoRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
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

@Controller
public class ConsultaCandidatosController {

    @Autowired private ICandidatoRepository candidatoRep;
    @Autowired private ICursoRepository cursoRep;

    @GetMapping("consultaCandidatos")
    public ModelAndView consultaCandidatos(@RequestParam Map<String, String> params, ModelMap model, HttpSession session) {
    	List<Curso> cursos = new LinkedList<>();
    	
    	cursos = cursoRep.findAll();
    	
    	/*    // Requisito: "consultar candidatos por curso escolhido"
    // SELECT * FROM Candidato WHERE curso = ?
    List<Candidato> findByCurso(Curso curso);

    // Requisito: "consultar candidatos por bairro"
    // SELECT * FROM Candidato WHERE bairro = ?
    List<Candidato> findByBairro(String bairro);


    // Requisito: "consultar todos os candidatos com ordenação por curso escolhido"
    @Query("SELECT c FROM Candidato c ORDER BY c.curso ASC")
    List<Candidato> findAllOrderByCurso();

    // Requisito: "consultar todos os candidatos com ordenação por bairro que reside"
    @Query("SELECT c FROM Candidato c ORDER BY c.bairro ASC")
    List<Candidato> findAllOrderByBairro();


    // Requisito: "consultar os 10 primeiros cadastrados"
    // Ideal para quando precisamos de recursos que não são padrão no JPQL.
    @Query(value = "SELECT TOP 10 * FROM Candidato ORDER BY data_cadastro ASC", nativeQuery = true)
    List<Candidato> findTop10PrimeirosCadastrados();

    // Requisito: "consultar os 10 últimos cadastrados"
    @Query(value = "SELECT TOP 10 * FROM Candidato ORDER BY data_cadastro DESC", nativeQuery = true)
    List<Candidato> findTop10UltimosCadastrados();
    	 * 
    	 * 
    	 * */
    	String filtro = params.get("filtro");
    	String tipo = params.get("tipo");
    	
        //if (session.getAttribute("admin") == null) {
        //    return new ModelAndView("redirect:/login");
        //}

        List<Candidato> candidatos = new ArrayList<>();
        String tituloResultado = "Nenhuma consulta realizada";

        System.out.println("tipo: " + tipo);
        if (tipo != null) {
            switch (tipo) {
	            case "todosPorCurso":
	                candidatos = candidatoRep.findAllOrderByCurso();
	                tituloResultado = "Candidatos ordenados por curso";
	                break;
	            case "todosPorBairro":
	                candidatos = candidatoRep.findAllOrderByBairro();
	                tituloResultado = "Candidatos ordenados por bairro";
	                break;
                case "curso":
                	Curso curso = new Curso();
                	curso.setCodigo(Long.parseLong(filtro));
                    candidatos = candidatoRep.findByCurso(curso);
                    tituloResultado = "Candidatos do curso: ";
                    break;
                case "bairro":
                    candidatos = candidatoRep.findByBairro(filtro);
                    tituloResultado = "Candidatos do bairro: " + filtro;
                    break;
                case "primeiros10":
                    candidatos = candidatoRep.findTop10PrimeirosCadastrados();
                    tituloResultado = "10 primeiros candidatos";
                    break;
                case "ultimos10":
                    candidatos = candidatoRep.findTop10UltimosCadastrados();
                    tituloResultado = "10 ultimos candidatos";
                    break;
            }
        }
        
        	
        model.addAttribute("cursos", cursoRep.findAll());
        model.addAttribute("candidatos", candidatos);
        model.addAttribute("tituloResultado", tituloResultado);
        
        return new ModelAndView("consultaCandidatos");
    }
    
    @PostMapping("consultaCandidatos")
    public ModelAndView consultaCandidatosPost(@RequestParam Map<String, String> params, ModelMap model, HttpSession session) {
    	
    	
    	
    	return new ModelAndView("consultaCandidatos");
    }
}