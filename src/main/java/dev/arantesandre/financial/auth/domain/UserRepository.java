package dev.arantesandre.financial.auth.domain;

import dev.arantesandre.financial.auth.domain.model.user.UserStatus;

public interface UserRepository {
    public void createUser(String email);
}
