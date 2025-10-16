package com.example.fateczl.AvaliacaoFaculdadeAV2.model;

import java.time.LocalDateTime;
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

    @Column(name = "curso", length = 50, nullable = false)
    private String curso;

    @Column(name = "data_cadastro", nullable = false)
    private LocalDateTime dataCadastro;

    @Column(name = "recebe_mensagem", nullable = false)
    private boolean recebeMensagem;
    
    // Relacionamento: Muitos candidatos são consultados/registrados por um administrador
    @ManyToOne(targetEntity = Administrador.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "codigo_adm", nullable = false)
    private Administrador administrador;
}