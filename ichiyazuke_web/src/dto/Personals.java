package dto;

import java.util.Date;

public class Personals {

    private int id;
    private int personalId;
    private String category;
    private int categoryId;
    private Date timeStamp;

    public Personals(int id, int personalId, String category, int categoryId, Date timeStamp) {
        this.id         = id;
        this.personalId = personalId;
        this.category   = category;
        this.categoryId = categoryId;
        this.timeStamp  = timeStamp;
    }

    public int getPersonalId() {
        return personalId;
    }

    public void setPersonalId(int personalId) {
        this.personalId = personalId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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
