if [ -f /usr/libexec/java_home ]; then
  export JAVA_HOME=`/usr/libexec/java_home`
  export PATH=$JAVA_HOME/bin:$PATH
fi