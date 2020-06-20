package hofls.com.github;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class MathUtilsTest {

    @Test
    void testSum() {
        int result = MathUtils.sum(23, 55);
        Assertions.assertEquals(78, result);
    }
}

//Generated with love by TestMe :) Please report issues and submit feature requests at: http://weirddev.com/forum#!/testme