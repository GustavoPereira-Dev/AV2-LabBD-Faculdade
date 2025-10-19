package com.example.fateczl.AvaliacaoFaculdadeAV2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.hibernate.annotations.NamedNativeQuery;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Curiosidade;

public interface ICuriosidadeRepository extends JpaRepository<Curiosidade, Long> {

	@Query(value = "SELECT dbo.fn_verifica_curiosidades() AS bit")
	public boolean verificaCuriosidades();
	 
	@Procedure(name = "sp_gerenciar_sorteio_curiosidade")
	public String sp_gerenciar_sorteio_curiosidade(@Param("codigo_time") long codigo);
	 
}
