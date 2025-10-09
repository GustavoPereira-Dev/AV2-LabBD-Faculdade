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
@Table(name = "candidato")
public class Time {
	
	@Id
	@Column(name = "id", nullable = false)
	long codigo;
	
	@Column(name = "nome", nullable = false)
	String nome;
	
	@Column(name = "curiosidades", nullable = false)
	String curiosidades;
}

/**
 *Time - Código, nome e curiosidades (com no mínimo, 15 curiosidades positivas verídicas, pois será avaliado isso)
Mensagem - id (autoincrementado supostamente, pois "o ID da mensagem deve ser gerado pela modularização que proverá o cadastro"), conteúdo, Data e hora da mensagem 
 * 
 * */
 