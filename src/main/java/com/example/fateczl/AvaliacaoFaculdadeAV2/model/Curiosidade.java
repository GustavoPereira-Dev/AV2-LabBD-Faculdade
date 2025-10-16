package com.example.fateczl.AvaliacaoFaculdadeAV2.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Curiosidade")
public class Curiosidade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codigo", nullable = false)
    private long codigo;

    @Column(name = "conteudo", nullable = false, columnDefinition = "varchar(max)")
    private String conteudo;

    // Relacionamento: Muitas curiosidades pertencem a um time
    @ManyToOne(targetEntity = Time.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "codigo_time", nullable = false)
    private Time time;

    // Relacionamento: Muitas curiosidades são criadas por um administrador
    @ManyToOne(targetEntity = Administrador.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "codigo_adm", nullable = false)
    private Administrador administrador;
}