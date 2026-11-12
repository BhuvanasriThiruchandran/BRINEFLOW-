from supabase import create_client
from config.settings import Config

# Create a Supabase client
supabase = create_client(
    Config.SUPABASE_URL,
    Config.SUPABASE_KEY
)