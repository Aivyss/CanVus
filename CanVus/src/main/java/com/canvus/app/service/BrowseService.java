package com.canvus.app.service;

import com.canvus.app.dao.BrowseDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

@Slf4j
@Service
public class BrowseService {
    @Autowired
    private BrowseDAO dao;

    public int getRoomCount(String title) {
        return dao.getRoomCount(title);
    }

    public ArrayList<HashMap<String, Object>> getRoomsByTitle(String title, int startRecord, int countPerPage) {
        return dao.getRoomsByTitle(title, startRecord, countPerPage);
    }



}
