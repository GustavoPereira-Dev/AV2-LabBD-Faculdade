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
@Table(name = "Historico")
public class Historico {

    @Id
    @Column(name = "codigo", nullable = false)
    private long codigo;

    @Column(name = "data_adicao", nullable = true)
    private LocalDateTime dataAdicao;
    
    // Relacionamento: O histórico se refere a uma curiosidade
    @ManyToOne(targetEntity = Curiosidade.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "codigo_curiosidade", nullable = true)
    private Curiosidade curiosidade;
}