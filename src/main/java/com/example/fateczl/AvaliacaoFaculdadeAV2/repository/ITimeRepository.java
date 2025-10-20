package com.example.fateczl.AvaliacaoFaculdadeAV2.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.fateczl.AvaliacaoFaculdadeAV2.model.Time;

public interface ITimeRepository extends JpaRepository<Time, Long> {

	Time findByCodigo(long codigo);
	
}
