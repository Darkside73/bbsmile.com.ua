# This file is used by Rack-based servers to start the application.

# Unicorn self-process killer
require 'unicorn/worker_killer'

# Max memory size (RSS) per worker
use Unicorn::WorkerKiller::Oom, (128*(1024**2)), (192*(1024**2)), 16, true

require ::File.expand_path('../config/environment',  __FILE__)
run Bbsmile::Application
