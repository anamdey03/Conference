package com.practice.conference.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.practice.conference.models.Speaker;

public interface SpeakerRepository extends JpaRepository<Speaker, Long> {

}
