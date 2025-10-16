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
@Table(name = "Administrador")
public class Administrador {

    @Id
    @Column(name = "codigo", nullable = false)
    private long codigo;

    @Column(name = "entrada", length = 20, nullable = false)
    private String entrada;

    @Column(name = "senha", length = 10, nullable = false)
    private String senha;

    // Relacionamento bidirecional: Um administrador pode criar várias curiosidades
    @OneToMany(mappedBy = "administrador", fetch = FetchType.LAZY)
    private List<Curiosidade> curiosidadesCriadas;
    
    // Relacionamento bidirecional: Um administrador pode consultar vários candidatos
    @OneToMany(mappedBy = "administrador", fetch = FetchType.LAZY)
    private List<Candidato> candidatosConsultados;
}