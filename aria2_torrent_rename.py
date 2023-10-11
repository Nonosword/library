import os
import re

def get_display_name(torrent_file):
    try:
        with open(torrent_file, 'rb') as f:
            data = f.read()
            match = re.search(b'name(\d+):', data)
            if match:
                name_length = int(match.group(1))
                display_name = data[match.end():match.end() + name_length].decode('utf-8')
                return display_name
    except Exception as e:
        print(f"Error reading torrent file: {e}")
        return None

def rename_torrent_files_in_folder(folder_path):
    for root, _, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.torrent'):
                torrent_file = os.path.join(root, file)
                display_name = get_display_name(torrent_file)
                if display_name:
                    new_name = os.path.join(root, display_name + '.torrent')
                    os.rename(torrent_file, new_name)
                    print(f"Renamed '{torrent_file}' to '{new_name}'")

def rename_torrent_files_in_folder(folder_path):
    for root, _, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.torrent'):
                torrent_file = os.path.join(root, file)
                display_name = get_display_name(torrent_file)
                if display_name:
                    new_name = os.path.join(root, display_name + '.torrent')
                    os.rename(torrent_file, new_name)
                    print(f"Renamed '{torrent_file}' to '{new_name}'")

if __name__ == "__main__":
    folder_path = "path\\to\\folder"
    rename_torrent_files_in_folder(folder_path)
