package com.practice.conference.controllers;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.practice.conference.models.Session;
import com.practice.conference.models.Speaker;
import com.practice.conference.repositories.SessionRepository;
import com.practice.conference.repositories.SpeakerRepository;

@RestController
@RequestMapping("/api/v1/speakers")
public class SpeakersController {

	@Autowired
	private SpeakerRepository speakerRepository;
	
	@Autowired
	private SessionRepository sessionRepository;

	@GetMapping
	public List<Speaker> getAllSpeakers() {
		return speakerRepository.findAll();
	}

	@GetMapping
	@RequestMapping("{id}")
	public Speaker getSpeaker(@PathVariable Long id) {
		return speakerRepository.getOne(id);
	}

	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	public Speaker createSpeaker(@Validated(Speaker.New.class) @RequestBody Speaker speaker) {
		return speakerRepository.saveAndFlush(speaker);
	}

	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public void deleteSpeaker(@PathVariable Long id) {
		Speaker existingSpeaker = speakerRepository.getOne(id);
		int size = existingSpeaker.getSessions().size();
		for (int i = 0; i < size; i++) {
			Long sessionId = existingSpeaker.getSessions().get(i).getSession_id();
			Session existingSession = sessionRepository.getOne(sessionId);
			int size1 = existingSession.getSpeakers().size();
			for (int j = 0; j < size1; j++) {
				if(existingSession.getSpeakers().get(j).getSpeaker_id().equals(id)) {
					existingSession.getSpeakers().remove(j);
					sessionRepository.saveAndFlush(existingSession);
				}
			}
		}
		speakerRepository.deleteById(id);
	}

	@RequestMapping(value = "{id}", method = RequestMethod.PUT)
	public Speaker updateSpeaker(@PathVariable Long id, @Validated(Speaker.Existing.class) @RequestBody Speaker speaker) {
		Speaker existingSpeaker = speakerRepository.getOne(id);
		BeanUtils.copyProperties(speaker, existingSpeaker, "speaker_id");
		return speakerRepository.saveAndFlush(existingSpeaker);
	}
}
