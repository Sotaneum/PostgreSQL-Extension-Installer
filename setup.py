from setuptools import setup, find_packages
import postgresql_extension_installer
setup(name='postgresql-extension-installer',
      version=postgresql_extension_installer.__version__,
      url='https://github.com/Sotaneum/PostgreSQL-Extension-Installer',
      license='MIT',
      author='Donggun LEE',
      author_email='gnyotnu39@gmail.com',
      description='Easy SQL Extension Installer For PostgreSQL',
      packages=find_packages(exclude=['tests']),
      long_description=open('README.md').read(),
      long_description_content_type='text/markdown',
      zip_safe=False,
      setup_requires=[],
      classifiers=[
          'License :: OSI Approved :: MIT License'
      ]
)
