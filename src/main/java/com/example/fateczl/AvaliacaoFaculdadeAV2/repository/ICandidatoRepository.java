package com.example.fateczl.AvaliacaoFaculdadeAV2.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Candidato;
import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Curso;

public interface ICandidatoRepository extends JpaRepository<Candidato, Long> {

	Candidato findByNome(String nome);
	
    // Requisito: "consultar candidatos por curso escolhido"
    // SELECT * FROM Candidato WHERE curso = ?
    List<Candidato> findByCurso(Curso curso);

    // Requisito: "consultar candidatos por bairro"
    // SELECT * FROM Candidato WHERE bairro = ?
    List<Candidato> findByBairroContaining(String bairro);


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
    
	@Procedure(name = "sp_inserir_candidato")
	public String sp_inserir_candidato(@Param("nome") String nome, @Param("email") String email, @Param("telefone") String telefone,
			@Param("bairro") String bairro, @Param("curso") long curso, @Param("recebe_mensagem") boolean mensagem);
    
    @Procedure(name = "sp_login_candidato")
	public String sp_login_candidato(@Param("usuario") String usuario, @Param("email") String email);
}
