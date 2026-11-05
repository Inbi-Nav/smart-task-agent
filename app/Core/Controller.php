<?php
namespace App\Core;

abstract class Controller
{
    protected function view(string $view, array $data = []): void
    {
        extract($data);
        require __DIR__ . '/../Views/' . $view . '.php';
        $content = ob_get_clean();
        require __DIR__ . '/../Views/layouts/main.php';
    }

    protected function redirect(string $path): void
    {
        header('Location: ' . $path);
        exit;
    }
}