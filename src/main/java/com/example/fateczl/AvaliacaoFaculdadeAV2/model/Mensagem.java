package com.example.fateczl.AvaliacaoFaculdadeAV2.model;

import java.time.LocalDate;

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
@Table(name = "mensagem")
public class Mensagem {

	@Id
	@Column(name = "id", nullable = false)
	long codigo;
	
	@Column(name = "conteudo", nullable = false)
	String conteudo;
	
	@Column(name = "data_hora", nullable = false)
	LocalDate dataHora;
	
	
}
