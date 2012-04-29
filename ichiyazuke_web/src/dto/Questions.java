package dto;

import java.util.Date;

public class Questions {

    private int id;
    private int grade;
    private String category;
    private int level;
    private String title;
    private String contents;
    private String choise1;
    private String choise2;
    private String choise3;
    private String choise4;
    private String answer;
    private String explanation;
    private int count;
    private Date regDate;
    private Date timeStamp;

    public Questions(int id, int grade, String category, int level,
            String title, String contents, String choise1, String choise2,
            String choise3, String choise4, String answer, String explanation,
            int count, Date regDate, Date timeStamp) {
        this.id = id;
        this.grade = grade;
        this.category = category;
        this.level = level;
        this.title = title;
        this.contents = contents;
        this.choise1 = choise1;
        this.choise2 = choise2;
        this.choise3 = choise3;
        this.choise4 = choise4;
        this.answer = answer;
        this.explanation = explanation;
        this.count = count;
        this.regDate = regDate;
        this.timeStamp = timeStamp;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getChoise1() {
        return choise1;
    }

    public void setChoise1(String choise1) {
        this.choise1 = choise1;
    }

    public String getChoise2() {
        return choise2;
    }

    public void setChoise2(String choise2) {
        this.choise2 = choise2;
    }

    public String getChoise3() {
        return choise3;
    }

    public void setChoise3(String choise3) {
        this.choise3 = choise3;
    }

    public String getChoise4() {
        return choise4;
    }

    public void setChoise4(String choise4) {
        this.choise4 = choise4;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
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

    public int getId() {
        return id;
    }

}
