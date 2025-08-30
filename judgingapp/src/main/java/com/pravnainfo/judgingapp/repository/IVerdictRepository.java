package com.pravnainfo.judgingapp.repository;

import com.pravnainfo.judgingapp.entity.Verdict;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IVerdictRepository extends JpaRepository<Verdict, String> {
}