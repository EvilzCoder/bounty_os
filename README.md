# Bug Bounty OS 

Pre-installed bug bounty recon tools

## Usage

### Build Dockerfile

`docker build . -t bounty_os`

### Run Docker Image
`docker run -v ./srv/programs/:/root/programs -it bounty_os`
