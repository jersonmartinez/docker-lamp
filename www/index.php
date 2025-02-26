<?php
require_once 'includes/config.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Docker LAMP Stack</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="assets/css/styles.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-server me-2"></i>
                Docker LAMP Stack
            </a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="https://github.com/jersonmartinez/docker-lamp" 
                       class="nav-link social-link github-link" 
                       target="_blank" 
                       rel="noopener noreferrer"
                       data-tooltip="View source code on GitHub">
                        <i class="fab fa-github"></i>
                        <span>GitHub</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="https://www.youtube.com/watch?v=v-r_12oezds" 
                       class="nav-link social-link youtube-link" 
                       target="_blank" 
                       rel="noopener noreferrer"
                       data-tooltip="Watch tutorial on YouTube">
                        <i class="fab fa-youtube"></i>
                        <span>YouTube</span>
                    </a>
                </li>
                <li class="nav-item">
                    <div class="nav-link theme-toggle" onclick="toggleTheme()" title="Toggle theme">
                        <i class="fas fa-moon"></i>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="text-center mb-5 fade-in">
                    <h1 class="display-4 mb-3">Welcome to your LAMP Stack</h1>
                    <p class="lead text-muted">Apache + MySQL + PHP on Docker</p>
                </div>

                <div class="row g-4">
                    <!-- PHP Status -->
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm status-card" data-tooltip="PHP Version installed">
                            <div class="card-body text-center">
                                <i class="fab fa-php icon-large connected"></i>
                                <h5 class="card-title">PHP</h5>
                                <p class="card-text"><?php echo htmlspecialchars($phpVersion); ?></p>
                            </div>
                        </div>
                    </div>

                    <!-- MySQL Status -->
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm status-card" data-tooltip="MySQL Connection Status">
                            <div class="card-body text-center">
                                <i class="fas fa-database icon-large <?php echo $db ? 'connected' : 'error'; ?>"></i>
                                <h5 class="card-title">MySQL</h5>
                                <p class="card-text"><?php echo $db ? 'Connected' : 'Disconnected'; ?></p>
                            </div>
                        </div>
                    </div>

                    <!-- Server Status -->
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm status-card" data-tooltip="Web Server Information">
                            <div class="card-body text-center">
                                <i class="fas fa-server icon-large connected"></i>
                                <h5 class="card-title">Server</h5>
                                <p class="card-text"><?php echo htmlspecialchars($serverInfo); ?></p>
                            </div>
                        </div>
                    </div>
                </div>

                <?php if ($db): ?>
                <div class="mt-5 fade-in">
                    <h2 class="h4 mb-4 text-center">Person Records</h2>
                    <div class="table-container">
                        <div class="table-responsive p-3">
                            <table class="table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-center" style="width: 80px">#</th>
                                        <th scope="col">Name</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                    $persons = getPersons($db);
                                    if (!empty($persons)):
                                        foreach ($persons as $person):
                                    ?>
                                        <tr class="fade-in">
                                            <td class="text-center"><?php echo htmlspecialchars($person['id']); ?></td>
                                            <td><?php echo htmlspecialchars($person['name']); ?></td>
                                        </tr>
                                    <?php 
                                        endforeach;
                                    else:
                                    ?>
                                        <tr>
                                            <td colspan="2" class="text-center py-4 text-muted">
                                                <i class="fas fa-info-circle me-2"></i>
                                                <em>No records available</em>
                                            </td>
                                        </tr>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <?php endif; ?>

                <div class="text-center mt-5 fade-in">
                    <p class="text-muted">
                        <small>
                            Developed with <i class="fas fa-heart text-danger footer-heart"></i> by 
                            <a href="https://www.linkedin.com/in/jersonmartinezsm/" 
                               class="text-decoration-none" 
                               target="_blank" 
                               rel="noopener noreferrer"
                               data-tooltip="View LinkedIn profile">
                                Jerson Martínez
                            </a>
                        </small>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Loading Spinner -->
    <div id="loading-spinner" class="loading-spinner" style="display: none;"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>