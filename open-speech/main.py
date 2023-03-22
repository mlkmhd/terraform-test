import os
import openai
openai.organization = os.getenv("ORG_ID")
openai.api_key = os.getenv("OPENAI_API_KEY")

#resp = openai.ChatCompletion.create(
#  model="gpt-3.5-turbo",
#  messages=[
#    {"role": "user", "content": "Hello!"}
#  ]
#)
#print(resp.choices[0].message.content)

resp = openai.Edit.create(
  model="text-davinci-edit-001",
  input="how is it better to have a good relationship",
  instruction="Fix the spelling and grammar mistakes"
)
print(resp.choices[0].text)
