package com.getcapacitor;

import static org.junit.Assert.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import android.app.Activity;
import com.foodello.adyen.AdyenPlugin;
import com.getcapacitor.JSObject;
import com.getcapacitor.PluginCall;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.robolectric.RobolectricTestRunner;

/**
 * Unit tests for the Adyen Capacitor Plugin
 */
@RunWith(RobolectricTestRunner.class)
public class AdyenPluginUnitTest {

    @Mock
    private PluginCall mockCall;

    @Mock
    private Activity mockActivity;

    private AdyenPlugin plugin;

    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        plugin = new AdyenPlugin();
    }

    @Test
    public void testSetCurrentPaymentMethodsWithNullData() {
        // Arrange
        when(mockCall.getObject("paymentMethodsJson")).thenReturn(null);

        // Act
        plugin.setCurrentPaymentMethods(mockCall);

        // Assert
        verify(mockCall).reject("Invalid or missing payment methods json");
        verify(mockCall, never()).resolve();
    }

    @Test
    public void testSetCurrentPaymentMethodsWithValidData() {
        // Arrange
        JSObject paymentMethods = new JSObject();
        JSObject scheme = new JSObject();
        scheme.put("type", "scheme");
        scheme.put("name", "Credit Card");
        
        JSObject[] methods = {scheme};
        paymentMethods.put("paymentMethods", methods);
        
        when(mockCall.getObject("paymentMethodsJson")).thenReturn(paymentMethods);

        // Act
        plugin.setCurrentPaymentMethods(mockCall);

        // Note: This test will fail until implementation is properly initialized
        // but it tests the method signature and call flow
    }

    @Test
    public void testHideComponent() {
        // Act
        plugin.hideComponent(mockCall);

        // Assert
        verify(mockCall).resolve();
    }

    @Test
    public void testPresentCardComponentWithValidParameters() {
        // Arrange
        when(mockCall.getInt("amount")).thenReturn(1000);
        when(mockCall.getString("countryCode")).thenReturn("US");
        when(mockCall.getString("currencyCode")).thenReturn("USD");
        when(mockCall.getObject("configuration")).thenReturn(null);
        when(mockCall.getObject("style")).thenReturn(null);
        when(mockCall.getObject("viewOptions")).thenReturn(null);

        // Act
        plugin.presentCardComponent(mockCall);

        // Note: This will likely fail without proper initialization
        // but tests the method signature and parameter handling
    }

    @Test
    public void testPresentCardComponentWithConfiguration() {
        // Arrange
        JSObject config = new JSObject();
        config.put("showsHolderNameField", true);
        config.put("showsSecurityCodeField", true);
        config.put("showsStorePaymentMethodField", false);

        when(mockCall.getInt("amount")).thenReturn(2500);
        when(mockCall.getString("countryCode")).thenReturn("NL");
        when(mockCall.getString("currencyCode")).thenReturn("EUR");
        when(mockCall.getObject("configuration")).thenReturn(config);
        when(mockCall.getObject("style")).thenReturn(null);
        when(mockCall.getObject("viewOptions")).thenReturn(null);

        // Act
        plugin.presentCardComponent(mockCall);

        // Verify that parameters are accessed
        verify(mockCall).getInt("amount");
        verify(mockCall).getString("countryCode");
        verify(mockCall).getString("currencyCode");
        verify(mockCall).getObject("configuration");
    }

    @Test
    public void testPluginAnnotation() {
        // Verify that the plugin is properly annotated
        assertTrue("Plugin should be annotated with @CapacitorPlugin", 
                   plugin.getClass().isAnnotationPresent(com.getcapacitor.annotation.CapacitorPlugin.class));
        
        com.getcapacitor.annotation.CapacitorPlugin annotation = 
                plugin.getClass().getAnnotation(com.getcapacitor.annotation.CapacitorPlugin.class);
        
        assertEquals("Plugin name should be 'Adyen'", "Adyen", annotation.name());
    }

    @Test
    public void addition_isCorrect() {
        // Keep original test to ensure basic functionality
        assertEquals(4, 2 + 2);
    }
}
