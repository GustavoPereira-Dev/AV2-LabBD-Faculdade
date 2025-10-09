package com.example.fateczl.AvaliacaoFaculdadeAV2.model;

import java.time.LocalDate;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "candidato")
public class Candidato {
	
	@Id
	@Column(name = "id", nullable = false)
	long codigo;
	
	@ManyToOne(cascade = CascadeType.ALL, targetEntity = Time.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "time_codigo", nullable = false)
	Time time;
	
	@Column(name = "nome", nullable = false)
	String nome;
	
	@Column(name = "email", nullable = false)
	String email;
	
	@Column(name = "telefone", nullable = false)
	String telefone;
	
	@Column(name = "bairro", nullable = false)
	String bairro;

	@ManyToOne(cascade = CascadeType.ALL, targetEntity = Time.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "curso_codigo", nullable = false)
	Curso curso;
	
	@Column(name = "data_hora_cadastro", nullable = false)
	LocalDate cadastro;
	
	@Column(name = "receber_mensagens", nullable = false)
	boolean receberMensagens;
}

/*Aluno/Candidato - time escolhido, nome completo, e-mail, telefone celular, bairro, curso de interesse, data e hora de cadastro e receberMensagens (booleano para a concordância em receber mensagens da Fatec ZL sobre vestibular)
hora de cadastro
Curso (supondo o uso na lista de escolhas do Aluno e o caso do catálogo da Fatec ZL)
Time - Código, nome e curiosidades (com no mínimo, 15 curiosidades positivas verídicas, pois será avaliado isso)
Mensagem - id (autoincrementado supostamente, pois "o ID da mensagem deve ser gerado pela modularização que proverá o cadastro"), conteúdo, Data e hora da mensagem
 * 
 * 
 * */
 