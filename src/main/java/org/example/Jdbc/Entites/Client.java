package org.example.Jdbc.Entites;

public class Client {
    private String name;
    private String address;
    private String website;
    private double credit_limit;

    public Client(String name, String address, String website, double credit_limit) {
        this.name = name;
        this.address = address;
        this.website = website;
        this.credit_limit = credit_limit;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public double getCredit_limit() {
        return credit_limit;
    }

    public void setCredit_limit(double credit_limit) {
        this.credit_limit = credit_limit;
    }
}
