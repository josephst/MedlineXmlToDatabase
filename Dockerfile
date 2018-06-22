FROM openjdk:8

# Installs Ant
# From WebRatio (https://github.com/webratio/docker/blob/master/ant/1.10.1/Dockerfile)
ENV ANT_VERSION 1.10.3
RUN cd && \
    wget -q http://www.us.apache.org/dist//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz
ENV ANT_HOME /opt/ant

ENV PATH ${PATH}:${ANT_HOME}/bin
# END: Ant Install

# Build MedlineXMLToDatabase
COPY . /app/medlineXml
WORKDIR /app/medlineXml
RUN ant clean && ant compile && ant create_run_jar

# Load database
## Need to provide data to use
### Analyse (default): docker run -it --rm --link postgres:pg --mount type=bind,src="C:\Users\Joseph\Source\JANE\MedlineXmlToDatabase\PubmedData",target=/app/medlineXml/pubmed --name medline medlinexmltodatabase
### Parse: docker run -it --rm --link postgres:pg --mount type=bind,src="C:\Users\Joseph\Source\JANE\MedlineXmlToDatabase\PubmedData",target=/app/medlineXml/pubmed --name medline medlinexmltodatabase -parse -ini config.ini
ENTRYPOINT ["java", "-Xmx1024M", "-jar", "dist/MedlineXmlToDatabase.jar"]
CMD ["-analyse", "-ini", "config.ini"]
