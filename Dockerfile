# 베이스 이미지 +이미지 별칭
#FROM adoptopenjdk/openjdk11 AS TEMP_BUILD_IMAGE  
#COPY build.gradle .
#COPY settings.gradle .
#COPY gradlew .
#COPY gradle gradle
# RUN ./gradlew build || return 0 
# 웹 어플리케이션 소스 복사 
#COPY src src
#RUN chmod +x ./gradlew
#RUN ./gradlew build

# 베이스 이미지 
FROM adoptopenjdk/openjdk11
# ENV ARTIFACT_NAME=kiki.jar
#ENV APP_HOME=/usr/app/
# temp 이미지에서 build/libs/*.jar파일을 app.jar로 복사
#RUN ls -al build/libs
COPY build/libs/kiki.jar app.jar 
 
# 컨테이너 8080 port 노출
EXPOSE 8080 
CMD ["java","-jar","/app.jar"]