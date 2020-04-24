package com.practice.conference.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.practice.conference.models.Session;

public interface SessionRepository extends JpaRepository<Session, Long> {

}
