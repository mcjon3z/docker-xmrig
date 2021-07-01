# docker-xmrig

Docker implementation of MoneroOcean xmrig fork

https://github.com/MoneroOcean/xmrig


## Usage
Pull:

    docker pull mcjon3z/xmrig
    
Run:

    docker run -it --rm mcjon3z/xmrig xmrig <OPTIONS>
    
or
    
    ./xmrig.sh <OPTIONS>


## MSR kernel module mod
msr-tools package is installed in the docker image so the XMRig MSR mod will work
as long as:
- msr kernel modules are installed on the host OS (Linux Docker hosts only)
- msr kernel modules are enabled on the host OS (modprobe msr)
- docker container is run in privileged mode using the --privileged flag

It is generally not recommended to run containers in privileged mode and doing so will expose your host OS to malicious code
in the container - DO SO AT YOUR OWN RISK!!!

The xmrig-privileged.sh launcher script in this repo will run the container in privileged mode should you choose to do so.


## Donations
I hope you find this little container useful. Gratuity is not expected, but greatly appreciated!

XMR - 87oG7sE4WsaWiwnDeRusvGef3CDf9eN4HaSU7R9Wa8XPaDZNJQkiWhy19MtsBYSAP8G9EwQfQqAZFDjCb9V8yAchMjdbbfN


--------------------------------------------------------------------------------

Except as otherwise specified:

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.