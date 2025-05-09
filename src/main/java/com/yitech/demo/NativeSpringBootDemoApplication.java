package com.yitech.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class NativeSpringBootDemoApplication {

	@Value("${hello:default message}")
	private String helloWorld;

	@GetMapping("/hello")
	public String hello() {
		return helloWorld;
	}

	public static void main(String[] args) {
		SpringApplication.run(NativeSpringBootDemoApplication.class, args);
	}

}