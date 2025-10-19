package com.example.fateczl.AvaliacaoFaculdadeAV2.model;

import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "times")
public class Time {

    @Id
    @Column(name = "codigo", nullable = false)
    private long codigo;

    @Column(name = "nome", length = 15, nullable = false)
    private String nome;

    // Relacionamento bidirecional: Um time tem várias curiosidades
    @OneToMany(mappedBy = "time", fetch = FetchType.LAZY)
    private List<Curiosidade> curiosidades;
}