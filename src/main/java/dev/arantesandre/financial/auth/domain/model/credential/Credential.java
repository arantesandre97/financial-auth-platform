package dev.arantesandre.financial.auth.domain.model.credential;

import dev.arantesandre.financial.auth.domain.model.user.UserId;

import java.util.UUID;

public class Credential {
    private final CredentialId id;
    private final UserId userId;
    private final CredentialType type;
    private final CredentialHash hash;

    public Credential(UserId userId, CredentialType type) {
        this.id = new CredentialId(UUID.randomUUID());
        this.userId = userId;
        this.type = type;
        this.hash = new CredentialHash("tbd");
    }

    public String getId() {
        return id.value().toString();
    }

    public String getUserId() {
        return userId.value().toString();
    }

    public String getType() {
        return type.toString();
    }

    public String getHash() {
        return hash.value();
    }
}
