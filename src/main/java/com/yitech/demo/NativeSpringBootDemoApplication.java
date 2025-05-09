package com.yitech.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class NativeSpringBootDemoApplication {


	@GetMapping("/")
	public String hello() {
		return "Hello from GraalVM Native!";
	}


	public static void main(String[] args) {
		SpringApplication.run(NativeSpringBootDemoApplication.class, args);
	}

}