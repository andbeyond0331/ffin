package com.ffin.web.qna;

import com.ffin.service.domain.Inquiry;
import com.ffin.service.domain.Report;
import com.ffin.service.domain.UploadImage;
import com.ffin.service.domain.User;
import com.ffin.service.qna.QnAService;
import com.ffin.service.user.UserService;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/qna/*")
public class QnARestController {

    @Autowired
    @Qualifier("qnAServiceImpl")
    private QnAService qnAService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    public QnARestController() {
        System.out.println("QnARestController.QnARestController");
    }


    @RequestMapping( value="json/addReport", method= RequestMethod.POST)
    @ResponseBody
    public ModelAndView addReport(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {



        System.out.println("REST  addReport   : POST");


        Report report = new Report();
        report.setReportUserId(request.getParameter("reportUserId"));
        report.setReportTargetId(request.getParameter("reportTargetId"));
        report.setReportContent(request.getParameter("reportContent"));
        report.setReportLink(request.getParameter("reportLink"));
        report.setReportType(Integer.parseInt(request.getParameter("reportType")));


        qnAService.addReport(report);

        ModelAndView modelAndView = new ModelAndView("jsonView");

        return modelAndView;
    }



    @RequestMapping(value = "json/getReport/{reportNo}", method = RequestMethod.GET)
    public ModelAndView getReport(@PathVariable int reportNo) throws Exception {

        System.out.println("QnARestController.getReport : GET ");

        ModelAndView modelAndView = new ModelAndView("jsonView");
        Report report = qnAService.getReport(reportNo);
        modelAndView.addObject("report", report);

        return modelAndView;
    }

    @RequestMapping(value = "json/updateReportProcStatus", method = RequestMethod.POST)
    @ResponseBody
    public Report updateReportProcStatus(@RequestParam("reportNo") int reportNo,
                                         @RequestParam("reportProcStatus") int reportProcStatus, @RequestParam("reportTargetId") String reportTargetId) throws Exception {

        System.out.println("QnARestController.updateReportProcStatus : POST");

        User user = new User();
        user.setUserId(reportTargetId);

        Report report = new Report();
        report.setReportNo(reportNo);
        //신고처리 - reportCount up
        if( reportProcStatus == 2){

            report.setReportProcStatus(reportProcStatus);
            qnAService.updateReportProcStatus(report);
            userService.updateReportCount(user);

            System.out.println("!!!!!!!!!!!!!!!111report = " + report);
            System.out.println("Report !!!! user = " + user);

            return qnAService.getReport(reportNo);
        }

        report.setReportProcStatus(reportProcStatus);
        qnAService.updateReportProcStatus(report);

        System.out.println("신고처리 : "+report);

        return qnAService.getReport(reportNo);
    }


    @RequestMapping(value = "json/getInquiry/{inquiryNo}", method = RequestMethod.GET)
    public ModelAndView getInquiry(@PathVariable int inquiryNo) throws Exception {

        System.out.println("QnARestController.getInquiry : GET");

        ModelAndView modelAndView = new ModelAndView("jsonView");
        Inquiry inquiry = qnAService.getInquiry(inquiryNo);
        modelAndView.addObject("inquiry", inquiry);

        return modelAndView;
    }


    @RequestMapping(value = "json/updateInquiryAns", method = RequestMethod.POST)
    @ResponseBody
    public Inquiry updateInquiryAns(@ModelAttribute Inquiry inquiry, @RequestParam("inquiryNo") int inquiryNo) throws Exception {

        System.out.println("QnARestController.updateInquiryAns : POST");

        qnAService.updateInquiryAns(inquiry);
        return qnAService.getInquiry(inquiryNo);
    }


    /* 첨부파일 업로드 & 썸네일 */
    @RequestMapping(value = "json/uploadInquiryFile", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<UploadImage>> uploadInquiryFile(MultipartFile[] uploadFile) {

        System.out.println("QnARestController.uploadInquiryFile");

        /* 이미지 파일 체크 */
        for(MultipartFile multipartFile: uploadFile) {

            File checkfile = new File(multipartFile.getOriginalFilename());
            String type = null;

            try {
                type = Files.probeContentType(checkfile.toPath());
                System.out.println("MIME TYPE : " + type);
            } catch (IOException e) {
                e.printStackTrace();
            }
            //image가 아닐 경우
            if(!type.startsWith("image")){
                List<UploadImage> list = null;
                return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
            }

        }

        String uploadFolder = "C:\\ffinPJT\\src\\main\\webapp\\resources\\image";

        /* 날짜 폴더 경로 : 하나의 dir에 파일이 몰리는 것을 방지하기 위한 폴더 나누기 */
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        String datePath = str.replace("-", File.separator);

        /* 폴더 생성 */
        File uploadPath = new File(uploadFolder, datePath);

        if(!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        /* 이미저 정보 담는 객체 */
        List<UploadImage> list = new ArrayList();

        for(MultipartFile multipartFile : uploadFile){
            System.out.println("-------------------------------");
            System.out.println("파일 이름 : "+multipartFile.getOriginalFilename());
            System.out.println("파일 타입 : "+multipartFile.getContentType());
            System.out.println("파일 크기 : "+multipartFile.getSize());

            /* 이미지 정보 객체 */
            UploadImage uploadImage = new UploadImage();

            /* 파일 이름 */
            String uploadFileName = multipartFile.getOriginalFilename();
            uploadImage.setFileName(uploadFileName);
            uploadImage.setUploadPath(datePath);

            /* uuid 적용 파일 이름 */
            String uuid = UUID.randomUUID().toString();
            uploadImage.setUuid(uuid);
            uploadFileName = uuid + "_" + uploadFileName;

            /* 파일 위치, 파일 이름을 합친 File 객체 */
            File saveFile = new File(uploadPath, uploadFileName);

            /* 파일 저장 */
            try {
                multipartFile.transferTo(saveFile);

                /* 썸네일 생성(Image IO) */
                /*File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

                BufferedImage bo_image = ImageIO.read(saveFile);

                *//* 비율 *//*
                double ratio = 3;
                *//*넓이 높이*//*
                int width = (int) (bo_image.getWidth() / ratio);
                int height = (int) (bo_image.getHeight() / ratio);
                BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);

                Graphics2D graphic = bt_image.createGraphics();

                graphic.drawImage(bo_image, 0, 0,width,height, null);

                ImageIO.write(bt_image, "jpg", thumbnailFile);*/


                /* 썸네일 생성(thumbnailaotor lib)*/
                File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

                BufferedImage bo_image = ImageIO.read(saveFile);

                //비율
                double ratio = 3;
                //넓이 높이
                int width = (int) (bo_image.getWidth() / ratio);
                int height = (int) (bo_image.getHeight() / ratio);

                Thumbnails.of(saveFile)
                        .size(width, height)
                        .toFile(thumbnailFile);

            } catch (Exception e) {
                e.printStackTrace();
            }
            list.add(uploadImage);
        }
        return new ResponseEntity<List<UploadImage>>(list, HttpStatus.OK);
    }

    /* 업로드 이미지 출력 */
    @GetMapping("json/displayImg")
    public ResponseEntity<byte[]> displayImg(String fileName){

        System.out.println("QnARestController.displayImg : GET ");

        File file = new File("C:\\ffinPJT\\src\\main\\webapp\\resources\\image\\" + fileName);

        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();
            header.add("Content-type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        }catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    /* 이미지 파일 삭제 */
    @PostMapping("json/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName){

        System.out.println("QnARestController.deleteFile : POST");
        System.out.println("Delete fileName = " + fileName);

        File file = null;

        try {
            /* 썸네일 파일 삭제 */
            file = new File("C:\\ffinPJT\\src\\main\\webapp\\resources\\image\\" + URLDecoder.decode(fileName, "UTF-8"));
            file.delete();

            /* 원본 파일 삭제 */
            String originFileName = file.getAbsolutePath().replace("s_", "");
            System.out.println("originFileName : " + originFileName);

            file = new File(originFileName);
            file.delete();

        } catch(Exception e) {

            e.printStackTrace();
            return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
        }
        return new ResponseEntity<String>("success", HttpStatus.OK);
    }


}
