package dev.arantesandre.financial_auth_platform;

import dev.arantesandre.financial.FinancialAuthPlatformApplication;
import org.springframework.boot.SpringApplication;

public class TestFinancialAuthPlatformApplication {

	public static void main(String[] args) {
		SpringApplication.from(FinancialAuthPlatformApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
