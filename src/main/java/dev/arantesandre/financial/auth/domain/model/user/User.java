package dev.arantesandre.financial.auth.domain.model.user;

import java.util.UUID;

public class User {
    private final UserId id;
    private Email email;
    private UserStatus status;

    public User(String email) {
        this.id = new UserId(UUID.randomUUID());
        this.email = new Email(email);
        this.status = UserStatus.ACTIVE;
    }

    public void updateEmail(String email) {
        this.email = new Email(email);
    }

    public void suspend() {
        this.status = UserStatus.SUSPENDED;
    }

    public void remove() {
        this.status = UserStatus.DELETED;
    }

    public String getId() {
        return id.value().toString();
    }

    public String getEmail() {
        return email.value();
    }

    public String getStatus() {
        return status.toString();
    }
}
