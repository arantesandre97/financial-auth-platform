package dev.arantesandre.financial.auth.domain.model.user;

import dev.arantesandre.financial.auth.domain.exception.InvalidEmailException;

import java.util.regex.MatchResult;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public record Email(String value) {
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    private static final Pattern emailValidator = Pattern.compile(EMAIL_REGEX);

    public Email {
        if (!emailValidator.matcher(value).matches())
            throw new InvalidEmailException();
    }
}
