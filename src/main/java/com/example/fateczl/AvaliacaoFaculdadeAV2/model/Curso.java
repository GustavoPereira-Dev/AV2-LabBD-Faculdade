package com.example.fateczl.AvaliacaoFaculdadeAV2.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "curso")
public class Curso {
	
	@Id
	@Column(name = "id", nullable = false)
	long codigo;
	
	@Column(name = "nome", nullable = false)
	String nome;
	
	@Column(name = "turno", nullable = false)
	String turno;
	
}
