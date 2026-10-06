package com.payment;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class PaymentAppTest {

    @Test
    void testVersion() {
        assertEquals(
            "Payment Application Version 2.7",
            PaymentApp.getVersion()
        );
    }
}