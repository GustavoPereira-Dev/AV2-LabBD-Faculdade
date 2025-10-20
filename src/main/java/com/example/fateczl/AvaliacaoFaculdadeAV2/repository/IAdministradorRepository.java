package com.example.fateczl.AvaliacaoFaculdadeAV2.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Administrador;

public interface IAdministradorRepository extends JpaRepository<Administrador, Long> {

	Administrador findByCodigo(long codigo);
	
    @Procedure(name = "sp_login_admin")
	public String sp_login_admin(@Param("entrada") String login, @Param("senha") String senha);
    
}
