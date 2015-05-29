#!/bin/sh

# (c) 2015 Taco Bot Productions

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

usage() {
	echo "-= Mr Mime: Extension-based mime type generator=-"
	echo ""
	echo "Usage: mrmime -n name -p pattern -c comment"
	echo "  Name: Mime name, eg: 'text'"
	echo "  Pattern: Mime pattern, eg: '*.txt'"
	echo "  Comment: Mime comment, eg: 'Plain text file'"
	1>&2; exit 1;
}

while getopts ":n:p:c:" o; do
    case "${o}" in
        n)
            n=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;
        c)
			c=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${n}" ] || [ -z "${p}" ] || [ -z "${c}" ]; then
	usage
fi

echo "Writing information to temporary file..."

echo '<?xml version="1.0"?>' > mrmime.xml
echo '<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">' >> mrmime.xml
echo "    <mime-type type=\"application/mrmine-${n}\">" >> mrmime.xml
echo "        <comment>${c}</comment>" >> mrmime.xml
echo "        <glob pattern=\"${p}\"/>" >> mrmime.xml
echo "    </mime-type>"  >> mrmime.xml
echo "</mime-info>" >> mrmime.xml

echo "Installing mime type to ~/.local/share/mime/application/mrmime-${n}.xml..."

xdg-mime install --novendor mrmime.xml
rm mrmime.xml

echo "Mime type installed to ~/.local/share/mime/application/mrmime-${n}.xml!"
