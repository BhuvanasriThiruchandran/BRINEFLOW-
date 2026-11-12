from database.supabase_client import supabase

try:
    response = supabase.table("users").select("*").execute()

    print("✅ Supabase Connected Successfully!")
    print(response.data)

except Exception as e:
    print("❌ Connection Failed")
    print(e)