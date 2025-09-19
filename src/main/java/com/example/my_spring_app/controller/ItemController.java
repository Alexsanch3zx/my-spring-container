package com.example.my_spring_app.controller;

import com.example.my_spring_app.model.Item;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/api/items")
public class ItemController {

    private final Map<Long, Item> store = new ConcurrentHashMap<>();
    private final AtomicLong seq = new AtomicLong(1);

    @GetMapping
    public List<Item> list() {
        return new ArrayList<>(store.values());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Item> get(@PathVariable Long id) {
        Item item = store.get(id);
        return (item == null) ? ResponseEntity.notFound().build() : ResponseEntity.ok(item);
    }

    @PostMapping
    public ResponseEntity<Item> create(@RequestBody Item payload) {
        long id = seq.getAndIncrement();
        Item created = new Item(id, payload.getName(), payload.getDescription());
        store.put(id, created);
        return ResponseEntity.created(URI.create("/api/items/" + id)).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Item> update(@PathVariable Long id, @RequestBody Item payload) {
        if (!store.containsKey(id)) return ResponseEntity.notFound().build();
        Item updated = new Item(id, payload.getName(), payload.getDescription());
        store.put(id, updated);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        return (store.remove(id) == null) ? ResponseEntity.notFound().build() : ResponseEntity.noContent().build();
    }
}
