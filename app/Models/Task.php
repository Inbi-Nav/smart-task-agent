<?php

namespace App\Models;

use App\Core\Database;

class Task {
    public static function getAllByUser(int $userId): array {
        $query = Database::connection()->prepare(
            "SELECT * FROM tasks WHERE user_id = ? ORDER BY created_at DESC"
        );
        $query->execute([$userId]);
        return $query->fetchAll();
    }

    public static function getById(int $id, int $userId): ?array {
        $query = Database::connection()->prepare(
            "SELECT * FROM tasks WHERE id = ? AND user_id = ?"
        );
        $query->execute([$id, $userId]);
        return $query->fetch() ?: null;
    }

    public static function create(int $userId, string $title, string $priority): void {
        $query = Database::connection()->prepare(
            "INSERT INTO tasks (user_id, title, priority) VALUES (?, ?, ?)"
        );
        $query->execute([$userId, $title, $priority]);
    }

    public static function setStatus(int $id, int $userId, string $status): void {
        $completedAt = $status === 'done' ? date('Y-m-d H:i:s') : null;
        $query = Database::connection()->prepare(
            "UPDATE tasks SET status = ?, completed_at = ? WHERE id = ? AND user_id = ?"
        );
        $query->execute([$status, $completedAt, $id, $userId]);
    }

    public static function delete(int $id, int $userId): void {
        $query = Database::connection()->prepare(
            "DELETE FROM tasks WHERE id = ? AND user_id = ?"
        );
        $query->execute([$id, $userId]);
    }
}