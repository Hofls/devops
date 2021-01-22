package hofls.com.github.metrics;

import hofls.com.github.rest.ShopController;
import io.micrometer.core.instrument.Counter;
import io.micrometer.prometheus.PrometheusMeterRegistry;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;

@Slf4j
@Service
@RequiredArgsConstructor
public class LiveTestService {

    private final PrometheusMeterRegistry prometheusMeterRegistry;
    private final ShopController shopController;
    private Counter businessEndpointCounterTotal;
    private Counter businessEndpointCounterFailure;

    @PostConstruct
    public void init() {
        businessEndpointCounterTotal = prometheusMeterRegistry.counter("liveTest." + ShopController.BUSINESS_ENDPOINT + ".all.total");
        businessEndpointCounterFailure = prometheusMeterRegistry.counter("liveTest." + ShopController.BUSINESS_ENDPOINT + ".failure.total");
    }

    @Scheduled(initialDelayString = "${live-test.initialDelay}", fixedRateString = "${live-test.fixedRate}")
    public void liveTest() {
        try {
            shopController.findProduct();
        } catch (Exception ex) {
            log.info("liveTest Failure: " + ex.getMessage());
            businessEndpointCounterFailure.increment();
        } finally {
            businessEndpointCounterTotal.increment();
        }
    }
}
