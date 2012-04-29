package dto;

import java.util.Date;

public class Users {

    private int id;
    private int personalId;
    private String nickname;
    private int grade;
    private int gender;
    private Date regDate;
    private Date timeStamp;

    public Users(int id, int personalId, String nickname, int grade, int gender, Date regDate, Date timeStamp) {
        this.id = id;
        this.personalId = personalId;
        this.nickname = nickname;
        this.grade = grade;
        this.gender = gender;
        this.regDate = regDate;
        this.timeStamp = timeStamp;
    }

    public int getId() {
        return id;
    }

    public int getPersonalId() {
        return personalId;
    }

    public void setPersonalId(int personalId) {
        this.personalId = personalId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public Date getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(Date timeStamp) {
        this.timeStamp = timeStamp;
    }

}
