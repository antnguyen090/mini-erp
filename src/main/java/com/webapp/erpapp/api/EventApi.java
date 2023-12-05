package com.webapp.erpapp.api;

import com.webapp.erpapp.model.request.event.EventCreateRequest;
import com.webapp.erpapp.model.request.event.EventEditRequest;
import com.webapp.erpapp.model.response.event.DashBoardResponse;
import com.webapp.erpapp.model.response.event.EventResponse;
import com.webapp.erpapp.security.Principal;
import com.webapp.erpapp.service.EventService;
import com.webapp.erpapp.service.PushSubscriptionService;
import com.webapp.erpapp.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/v1/events")
public class EventApi {

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;


    @Autowired
    PushSubscriptionService pushSubscriptionService;

    @Autowired
    private EventService eventService;
    @GetMapping()
    public ResponseEntity<?> getAllEventsByMonth(@RequestParam("month") String month) {
        List<EventResponse> responseList = eventService.getAllEventsByMonth(month);
        return new ResponseEntity<>(responseList, HttpStatus.OK);
    }

    @GetMapping("/upcoming")
    public ResponseEntity<?> getUpcomingEvents(@RequestParam("day") String day,
                                               @RequestParam(name = "page",required = false,defaultValue = "1") Integer page,
                                               @RequestParam(name = "size", required = false, defaultValue = "3") Integer size) {
        DashBoardResponse responseList = eventService.getUpcomingEvent(day,page,size);
        return new ResponseEntity<>(responseList, HttpStatus.OK);
    }

    @SendTo("/notification/createEvent")
    @PostMapping()
    public ResponseEntity<?> createEvent(@Valid @RequestBody EventCreateRequest request, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        EventResponse eventResponse = eventService.createEvent(request);
        eventResponse.setCategoryPush("Events");
        if(eventResponse != null) {
            String userId = Principal.getUserCurrent().getId();
            pushSubscriptionService.sendNotificationAll(JsonUtils.objectToJson(eventResponse), userId);
            simpMessagingTemplate.convertAndSend("/notification/createEvent", eventResponse);
        }
        return ResponseEntity.ok(eventResponse);
    }
    @PutMapping()
    public ResponseEntity<?> editEvent(@Valid @RequestBody EventEditRequest request, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return ResponseEntity.ok(eventService.editEvent(request));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEvent(@PathVariable("id") String id) {
        return ResponseEntity.ok(eventService.deleteEvent(id));
    }
    @GetMapping("/latest/{limit}")
    public ResponseEntity<?> getEventNotifications(@PathVariable("limit") Integer limit) {
        return ResponseEntity.ok(eventService.getEventNotification(limit));
    }
}
