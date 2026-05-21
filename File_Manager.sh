#!/bin/bash


while true; do
    clear
    echo "=== File Manager ==="
    echo "a) Create File/Folder"
    echo "b) Read File Contents"
    echo "c) Edit File/Folder"
    echo "d) Delete File/Folder"
    echo "e) Exit"
    echo "====================="
    read -p "Choose an option (a-e): " choice

    case $choice in
        a)
            clear
            echo "Create New File or Folder"
            read -p "Do you want to create a file or folder? (file/folder): " type
            
            echo "Enter directory path (or press Enter for current directory): "
            read dir_path
            if [[ -z "$dir_path" ]]; then
                dir_path="."
            fi
            
            read -p "Enter file/folder name: " name
            full_path="$dir_path/$name"
            
            if [[ "$type" == "file" ]]; then
                touch "$full_path"
                echo " File created successfully: $full_path"
            elif [[ "$type" == "folder" ]]; then
                mkdir -p "$full_path"
                echo " Folder created successfully: $full_path"
            else
                echo " Invalid type. Please choose 'file' or 'folder'"
            fi
            read -p "Press Enter to continue..."
            ;;

        b)
            clear
            echo "Read File Contents"
            read -p "Enter file path: " filepath
            if [[ -f "$filepath" ]]; then
                chmod 444 "$filepath"  # Read-only for all
                echo "----------------------------------------"
                echo " Contents of $filepath:"
                echo "----------------------------------------"
                cat "$filepath"
                echo "----------------------------------------"
            else
                echo " Error: File does not exist!"
            fi
            read -p "Press Enter to continue..."
            ;;

        c)
            clear
            echo "Edit File or Folder"
            echo "Enter directory path (or press Enter for current directory): "
            read dir_path
            if [[ -z "$dir_path" ]]; then
                dir_path="."
            fi
            
            read -p "Enter file/folder name: " name
            full_path="$dir_path/$name"
            
            # CREATE FILE IF NOT FOUND (for Edit File/Folder option)
            if [[ ! -e "$full_path" ]]; then
                echo " File does not exist. Creating new file: $full_path"
                touch "$full_path"
                echo " File created successfully"
            fi
            
            if [[ -f "$full_path" ]]; then
                echo " $full_path is a FILE"
                chmod 700 "$full_path"
                echo " Permissions: Owner write access only"
                
                echo "How do you want to edit the file?"
                echo "1) Append content"
                echo "2) Overwrite content"
                echo "3) Open text editor (nano)"
                read -p "Choose (1-3): " edit_choice

                case $edit_choice in
                    1)
                        read -p "Enter content to append: " content
                        echo "$content" >> "$full_path"
                        echo " Content appended successfully"
                        ;;
                    2)
                        read -p "Enter new content: " content
                        echo "$content" > "$full_path"
                        echo " File overwritten successfully"
                        ;;
                    3)
                        nano "$full_path"
                        echo " File saved and closed"
                        ;;
                    *)
                        echo " Invalid option"
                        ;;
                esac
                
            elif [[ -d "$full_path" ]]; then
                echo " $full_path is a FOLDER"
                echo "Folder editing options:"
                echo "1) Add file to folder"
                echo "2) Add folder inside folder"
                echo "3) List folder contents"
                read -p "Choose (1-3): " folder_choice

                case $folder_choice in
                    1)
                        read -p "Enter new file name: " newfile
                        touch "$full_path/$newfile"
                        echo " File '$newfile' created in folder"
                        ;;
                    2)
                        read -p "Enter new folder name: " newfolder
                        mkdir "$full_path/$newfolder"
                        echo " Folder '$newfolder' created inside folder"
                        ;;
                    3)
                        echo " Contents of $full_path:"
                        echo "-------------------"
                        ls -la "$full_path"
                        ;;
                    *)
                        echo " Invalid option"
                        ;;
                esac
            fi
            read -p "Press Enter to continue..."
            ;;

        d)
            clear
            echo "Delete File or Folder"
            read -p "Enter directory path (or press Enter for current directory): " dir_path
            if [[ -z "$dir_path" ]]; then
                dir_path="."
            fi
            
            read -p "Enter file/folder name to delete: " name
            full_path="$dir_path/$name"
            
            if [[ -e "$full_path" ]]; then
                echo "  Found: $full_path"
                read -p "Delete $full_path? (y/N): " confirm
                
                if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                    if [[ -f "$full_path" ]]; then
                        rm "$full_path"
                        echo " File deleted successfully"
                    elif [[ -d "$full_path" ]]; then
                        rm -r "$full_path"
                        echo " Folder deleted successfully"
                    fi
                else
                    echo " Deletion cancelled"
                fi
            else
                echo " Error: $full_path does not exist!"
            fi
            read -p "Press Enter to continue..."
            ;;

        e)
            echo " Goodbye!"
            exit 0
            ;;

        *)
            echo " Invalid option! Please choose a-e"
            read -p "Press Enter to continue..."
            ;;
    esac
done
