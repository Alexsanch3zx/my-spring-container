package com.example.my_spring_app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
// I added these 2 below directly fro the website provided on Moodle (swagger site)
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootApplication
// I added these 2 below directly fro the website provided on Moodle (swagger site)
@EnableSwagger2
@EnableWebMvc
public class MySpringAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(MySpringAppApplication.class, args);
	}

}
