#!/usr/bin/env python3

import discord
from discord.ext import commands
import requests
import asyncio
import os
import json
import re
from dotenv import load_dotenv

load_dotenv()

GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")
DISCORD_TOKEN = os.environ.get("DISCORD_TOKEN")
TARGET_CHANNEL_ID = 1301061309395370024
ROLE_ID = 1309487675379810346
USER_ID = 765622654387879996
USER = "Footagesus"
REPO = "WindUI"

HEADERS = {
    "Authorization": f"Bearer {GITHUB_TOKEN}",
    "Accept": "application/vnd.github+json"
}

def get_package_info():
    """Get version and main file path from package.json"""
    try:
        with open('package.json', 'r', encoding='utf-8') as f:
            package_data = json.load(f)
            version = package_data.get('version', '')
            main_file = package_data.get('main', '')
            return version, main_file
    except FileNotFoundError:
        print("⚠️  package.json not found")
        return '', ''
    except json.JSONDecodeError:
        print("⚠️  Error reading package.json")
        return '', ''

def get_changelog_content():
    """Get content from changelog.md and remove version at the beginning"""
    try:
        with open('changelog.md', 'r', encoding='utf-8') as f:
            content = f.read().strip()
            lines = content.split('\n')
            if lines and lines[0].startswith('# '):
                return '\n'.join(lines[1:]).strip()
            return content
    except FileNotFoundError:
        print("⚠️  changelog.md not found")
        return ''

def get_input(prompt, default_value=""):
    """Get input with default value"""
    if default_value:
        user_input = input(f"{prompt} [{default_value}]: ").strip()
        return user_input if user_input else default_value
    else:
        return input(f"{prompt}: ").strip()

def find_file(file_path):
    """Find file by path, with fallback to current directory"""
    if os.path.exists(file_path):
        return file_path
    filename = os.path.basename(file_path)
    if os.path.exists(filename):
        return filename
    return None

async def create_release():
    print("🚀 GitHub Release Creator CLI")
    print("=" * 40)
    
    package_version, package_main = get_package_info()
    version = get_input("Enter release version", package_version)
    
    if not version:
        print("❌ Version is required!")
        return
    
    changelog_content = get_changelog_content()
    content = get_input("Enter release description", changelog_content)
    
    if not content:
        print("❌ Release description is required!")
        return
    
    is_draft_input = get_input("Save as draft? (y/N)", "n").lower()
    is_draft = is_draft_input in ['y', 'yes']
    
    upload_file_input = get_input("Upload file? (y/N)", "n").lower()
    upload_file = upload_file_input in ['y', 'yes']
    
    uploaded_file = None
    if upload_file:
        default_file = None
        if package_main and os.path.exists(package_main):
            default_file = package_main
            print(f"📁 Auto-detected file from package.json: {package_main}")
        elif package_main:
            found_file = find_file(package_main)
            if found_file:
                default_file = found_file
                print(f"📁 Found file: {found_file}")
        
        file_path = get_input("File path", default_file if default_file else "")
        
        if file_path:
            if os.path.exists(file_path):
                uploaded_file = file_path
                print(f"✅ File found: {file_path}")
            else:
                found_file = find_file(file_path)
                if found_file:
                    uploaded_file = found_file
                    print(f"✅ File found: {found_file}")
                else:
                    print("❌ File not found!")
                    retry = get_input("Try again? (y/N)", "n").lower()
                    if retry in ['y', 'yes']:
                        return await create_release()
                    else:
                        print("⚠️  Continuing without file upload")
        else:
            print("⚠️  No file path provided, continuing without file upload")
    
    print("\n📋 Creating release:")
    print(f"   Version: {version}")
    print(f"   Repository: {USER}/{REPO}")
    print(f"   Draft: {'Yes' if is_draft else 'No'}")
    print(f"   File: {uploaded_file if uploaded_file else 'No'}")
    print(f"   Description: {content[:100]}{'...' if len(content) > 100 else ''}")
    
    confirm = get_input("\n✅ Create release? (Y/n)", "y").lower()
    if confirm in ['n', 'no']:
        print("❌ Cancelled")
        return
    
    print("⏳ Creating release...")
    
    repo_name = f"{USER}/{REPO}"
    url = f"https://api.github.com/repos/{repo_name}/releases"
    payload = {
        "tag_name": version,
        "name": version,
        "body": content,
        "draft": is_draft,
        "prerelease": False
    }
    
    try:
        response = requests.post(url, json=payload, headers=HEADERS)
        
        if response.status_code == 201:
            release = response.json()
            print(f"✅ Release created: {release['html_url']}")
            
            if uploaded_file:
                print("⏳ Uploading file...")
                upload_url = release['upload_url'].replace(
                    '{?name,label}', 
                    f'?name={os.path.basename(uploaded_file)}'
                )
                
                with open(uploaded_file, 'rb') as file_to_upload:
                    file_upload_headers = HEADERS.copy()
                    file_upload_headers['Content-Type'] = 'application/octet-stream'
                    
                    file_response = requests.post(
                        upload_url, 
                        headers=file_upload_headers, 
                        data=file_to_upload
                    )
                
                if file_response.status_code in [200, 201]:
                    print("✅ File uploaded!")
                else:
                    print(f"⚠️  File upload error: {file_response.text}")
            
            print("⏳ Sending to Discord...")
            await send_discord_notification(release, version, content, repo_name)
            
        else:
            print(f"❌ Release creation error: {response.status_code}")
            print(f"Response: {response.text}")
            
    except requests.exceptions.RequestException as e:
        print(f"❌ Network error: {e}")
    except Exception as e:
        print(f"❌ Unexpected error: {e}")

async def send_discord_notification(release, version, content, repo_name):
    """Send Discord notification"""
    try:
        intents = discord.Intents.default()
        intents.message_content = True
        bot = commands.Bot(command_prefix="!", intents=intents)
        
        @bot.event
        async def on_ready():
            try:
                target_channel = bot.get_channel(TARGET_CHANNEL_ID)
                if target_channel is None:
                    print("❌ Discord channel not found!")
                    return

                embed = discord.Embed(
                    title=f"New release: {version}",
                    description=content,
                    color=0x30ff6a,
                    url=release["html_url"]
                )
                
                icon = "https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/logo.png"
                embed.set_author(
                    name=repo_name, 
                    url=f"https://github.com/{repo_name}", 
                    icon_url=icon
                )
                
                await target_channel.send(content=f"<@&{ROLE_ID}>", embed=embed)
                print("✅ Discord notification sent!")
                
            except Exception as e:
                print(f"❌ Discord error: {e}")
            finally:
                await bot.close()
        
        await bot.start(DISCORD_TOKEN)
        
    except Exception as e:
        print(f"❌ Discord connection error: {e}")

def main():
    """Main function"""
    try:
        asyncio.run(create_release())
    except KeyboardInterrupt:
        print("\n❌ Interrupted by user")
    except Exception as e:
        print(f"❌ Critical error: {e}")

if __name__ == "__main__":
    main()