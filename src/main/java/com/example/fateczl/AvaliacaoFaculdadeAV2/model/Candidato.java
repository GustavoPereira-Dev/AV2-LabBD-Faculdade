package com.example.fateczl.AvaliacaoFaculdadeAV2.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Candidato")
public class Candidato {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codigo", nullable = false)
    private long codigo;

    @Column(name = "nome", length = 100, nullable = false)
    private String nome;

    @Column(name = "email", length = 50, nullable = false)
    private String email;

    @Column(name = "telefone", length = 11, nullable = false)
    private String telefone;

    @Column(name = "bairro", length = 100, nullable = false)
    private String bairro;

    @Column(name = "data_cadastro", nullable = false)
    private LocalDateTime dataCadastro;

    @Column(name = "recebe_mensagem", nullable = false)
    private boolean recebeMensagem;

    // Relacionamento: Muitos candidatos são consultados/registrados por um administrador
    @ManyToOne(targetEntity = Curso.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "codigo_curso", nullable = false)
    private Curso curso;
    
    // Relacionamento: Muitos candidatos são consultados/registrados por um administrador
    @ManyToOne(targetEntity = Administrador.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "codigo_administrador", nullable = false)
    private Administrador administrador;
    
    public String getDataCadastroFormatada() {
        if (this.dataCadastro == null) {
            return "";
        }
        // Define o padrão de formatação desejado
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy 'às' HH:mm");
        return this.dataCadastro.format(formatter);
    }
}