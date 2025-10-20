package com.example.fateczl.AvaliacaoFaculdadeAV2;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Administrador;
import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Curiosidade;
import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Curso;
import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Time;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.IAdministradorRepository;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ICuriosidadeRepository;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ICursoRepository;
import com.example.fateczl.AvaliacaoFaculdadeAV2.repository.ITimeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

@SpringBootApplication
public class AvaliacaoFaculdadeAv2Application implements CommandLineRunner {

    private static final Logger logger = LoggerFactory.getLogger(AvaliacaoFaculdadeAv2Application.class);

    @Autowired
    private ICuriosidadeRepository curiosidadeRep;

    @Autowired
    private ICursoRepository cursoRep;
    
    @Autowired
    private ITimeRepository timeRep;

    @Autowired
    private IAdministradorRepository adminRep;

    public static void main(String[] args) {
        SpringApplication.run(AvaliacaoFaculdadeAv2Application.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        logger.info("=====================================================");
        logger.info("INICIANDO VERIFICAÇÃO DE DADOS NA BASE...");

        if(!cursoRep.findAll().isEmpty()) abastecerCursos();
        
        if (curiosidadeRep.verificaCuriosidades()) {
        	logger.info("Base de dados já populada. Nenhuma ação necessária.");
            logger.info("=====================================================");
            return;
        }

        logger.info("Base de dados vazia. Iniciando carga de dados a partir dos arquivos TXT...");

        try {
            Administrador adminPadrao = adminRep.findById(1L)
                    .orElseThrow(() -> new RuntimeException("Administrador padrão com código 1 não encontrado."));

            File arquivoTimes = ResourceUtils.getFile("classpath:txts/times.txt");
            List<String> nomesTimes = Files.readAllLines(arquivoTimes.toPath());
            
            List<Time> timesParaSalvar = new ArrayList<>();
            AtomicLong timeIdCounter = new AtomicLong(1);
            
            for (String nomeTime : nomesTimes) {
                Time time = new Time();
                time.setCodigo(timeIdCounter.getAndIncrement());
                time.setNome(nomeTime);
                timesParaSalvar.add(time);
            }
            
            List<Time> timesSalvos = timeRep.saveAll(timesParaSalvar);
            logger.info("-> {} times carregados com sucesso!", timesSalvos.size());

            List<Curiosidade> curiosidadesParaSalvar = new ArrayList<>();
            for (Time time : timesSalvos) {
                String nomeArquivoCuriosidades = time.getNome().toLowerCase().replace(" ", "") + ".txt";
                File arquivoCuriosidades = ResourceUtils.getFile("classpath:txts/" + nomeArquivoCuriosidades);
                
                List<String> conteudosCuriosidades = Files.readAllLines(arquivoCuriosidades.toPath());
                
                for (String conteudo : conteudosCuriosidades) {
                    Curiosidade curiosidade = new Curiosidade();
                    curiosidade.setConteudo(conteudo);
                    curiosidade.setTime(time);
                    curiosidade.setAdministrador(adminPadrao);
                    curiosidadesParaSalvar.add(curiosidade);
                }
                logger.info("   - Carregadas {} curiosidades para o time {}", conteudosCuriosidades.size(), time.getNome());
            }

            curiosidadeRep.saveAll(curiosidadesParaSalvar);
            logger.info("-> {} curiosidades carregadas com sucesso no total!", curiosidadesParaSalvar.size());
            
            logger.info("CARGA DE DADOS INICIAIS CONCLUÍDA!");

        } catch (Exception e) {
            logger.error("!!! ERRO CRÍTICO DURANTE A CARGA DE DADOS INICIAIS !!!");
            logger.error("Mensagem: {}", e.getMessage());
        } finally {
            logger.info("=====================================================");
        }
    }
    
    public void abastecerCursos() {
    	logger.info("TABELA CURSO SEM DADOS, ABASTECENDO-A AGORA...");
    	
    	 try {
	        String[] cursos = {"Analise e Desenvolvimento de Sistemas", "Comercio Exterior", "Desenvolvimento de Produtos Plasticos", "Desenvolvimento de Software Multiplataforma", "Gestao de Recursos Humanos", "Gestao Empressarial", "Polimeros", "Logistica", "AMS"};
	        for(int i = 0; i < cursos.length; i++) {
	          	Curso curso = new Curso();
	          	curso.setCodigo(i + 1);
	          	curso.setNome(cursos[i]);
	          	cursoRep.save(curso);
	        } 
	        logger.info("   - Carregadas {} curiosidades para o time {}", cursos.length);
    	 }  catch (Exception e) {
	            logger.error("!!! ERRO CRÍTICO DURANTE A CARGA DE DADOS INICIAIS NO CURSO !!!");
	            logger.error("Mensagem: {}", e.getMessage());
	        } finally {
	            logger.info("=====================================================");
	        }
	    
    } 
    
}