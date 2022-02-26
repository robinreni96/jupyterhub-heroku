from jupyterhub.spawner import SimpleLocalProcessSpawner

# setting a dummy user admin for now
c.JupyterHub.authenticator_class = "dummy"
c.DummyAuthenticator.password = "admin"

# using simplelocalspawner for now
c.JupyterHub.spawner_class = SimpleLocalProcessSpawner
c.Spawner.cmd = ['jupyter-labhub']

# for creating new users
c.LocalAuthenticator.add_user_cmd = ['python3','/app/analysis/create-user.py','USERNAME']
c.LocalAuthenticator.create_system_users = True