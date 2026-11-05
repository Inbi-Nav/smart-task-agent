<?php

namespace App\Core;

class Router
{
    private array $routes = [];

    public function get(string $path, array $handler): void {
        $this->add('GET', $path, $handler);
    }

    public function post(string $path, array $handler): void {
        $this->add('POST', $path, $handler);
    }

    private function add(string $method, string $path, array $handler): void {
        $this->routes[] = [$method, $path, $handler];
    }

        public function dispatch(string $method, string $uri): void {

        $path = parse_url($uri, PHP_URL_PATH);
        if (isset($this->routes[$method][$path])) {
            [$class, $action] = $this->routes[$method][$path];
            (new $class())->$action();
            return;
        }
        http_response_code(404);
        echo "404 Page Not Found";
    }
}