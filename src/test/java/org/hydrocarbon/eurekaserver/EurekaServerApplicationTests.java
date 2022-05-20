package org.hydrocarbon.eurekaserver;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class EurekaServerApplicationTests {

    @Value("${spring.application.name}")
    private String applicationName;

    @Test
    void contextLoads() {
        Assertions.assertEquals("EurekaServer", applicationName);
    }
}
