package com.jesse.dpp.rcp.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.enums.ResponseStatus;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.service.ISystemTypeService;
import com.jesse.dpp.rcp.session.SessionContext;
import com.jesse.dpp.rcp.utils.Utility;
import com.jesse.dpp.rcp.vo.SystemTypeVo;
import com.github.pagehelper.PageInfo;

@Controller
public class SystemTypeController {

    private static Log log = LogFactory.getLog(SystemTypeController.class);
    
    @Value("#{configProperties['test_system_id']}")
    private String testSystemId;
    
    // 允许上传的格式
    private static final String[] IMAGE_TYPE = new String[] { ".bmp", ".jpg", ".jpeg", ".gif", ".png" };
    
    private static final long imgSize = 100L;

    @Autowired
    private ISystemTypeService iSystemTypeService;

    @RequestMapping(value = "getListSystemType", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getListSystemType(@RequestParam(value = "limit", defaultValue = "10") Integer limit, @RequestParam(value = "offset", defaultValue = "0") Integer offset) {
        try {
            log.info("getListSystemType start......");
            int currentpage = offset / limit;
            currentpage += 1;
            PageInfo<SystemTypeVo> info = iSystemTypeService.selectListByPagination(currentpage, limit);
            Map<String, Object> obj = new HashMap<String, Object>();
            obj.put("total", info.getTotal());
            obj.put("rows", info.getList());
            return obj;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "querySystemTypeList")
    @ResponseBody
    public List<SystemTypeVo> getListSystemType() {
    	List<SystemTypeVo> list = new ArrayList<SystemTypeVo>();
        try {
            list = iSystemTypeService.selectActiveList(Constant.RECORD_ACTIVE);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return list;
    }

    @RequestMapping(value = "listSystemType", method = RequestMethod.GET)
    private ModelAndView listSystemType() {
        log.info("listSystemType............");
        ModelAndView mv = new ModelAndView("listSystemType");
        try {
            List<SystemTypeVo> systemTypeList = iSystemTypeService.selectList();

            mv.addObject("systemTypeList", systemTypeList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mv;
    }

    @RequestMapping(value = "addSystemType", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> addSystemType(SystemType systemType, HttpServletRequest request) {
        Map<String, Object> obj = new HashMap<String, Object>();
        String result = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        try {
            Integer creatorId = 0;
            Account opAccount = SessionContext.getAccount();
            if (null != opAccount) {
                creatorId = opAccount.getId();
            }
            String path = request.getContextPath();
            String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
            String ipAddress = Utility.getIpAddr(request);
            int count = iSystemTypeService.addSystemType(systemType, creatorId, basePath, ipAddress, testSystemId);
            if (count == 1) {
                result = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        obj.put("status", result);
        return obj;
    }

    @RequestMapping(value = "toEditSystemTypePage", method = RequestMethod.GET)
    private ModelAndView toEditSystemTypePage(String id) {
        log.info("toEditSystemTypePage............");
        ModelAndView mv = new ModelAndView("editSystemType");
        try {
            if ("" != id && null != id) {
                SystemType systemType = iSystemTypeService.selectByPrimaryKey(id);
                mv.addObject("systemType", systemType);
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mv;
    }
    
    @RequestMapping(value = "toAddSystemTypePage", method = RequestMethod.GET)
    private ModelAndView toAddSystemTypePage() {
        log.info("toAddSystemTypePage............");
        ModelAndView mv = new ModelAndView("addSystemType");
        return mv;
    }

    @RequestMapping(value = "editSystemType", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> editSystemType(SystemType systemType, HttpSession session) {
        Map<String, Object> obj = new HashMap<String, Object>();
        String result = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        try {
            Integer updaterId = 0;
            Account opAccount = SessionContext.getAccount();
            if (null != opAccount) {
                updaterId = opAccount.getId();
            }
            int count = iSystemTypeService.updateSystemType(systemType, updaterId);
            if (count == 1) {
                result = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        obj.put("status", result);
        return obj;
    }

    @RequestMapping(value = "changeStatus", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> changeStatus(String id, HttpSession session) {
        Map<String, Object> obj = new HashMap<String, Object>();
        String result = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        try {
            Integer updaterId = 0;
            Account opAccount = SessionContext.getAccount();
            if (null != opAccount) {
                updaterId = opAccount.getId();
            }
            int count = iSystemTypeService.changeStatus(id, opAccount.getSystemId(), updaterId);
            if (count == 1) {
                result = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        obj.put("status", result);
        return obj;
    }

    @RequestMapping(value = "showSystemTypeDetail", method = RequestMethod.GET)
    private ModelAndView showSystemTypeDetail(String id) {
        log.info("showSystemTypeDetail............");
        ModelAndView mv = new ModelAndView("showSystemTypeDetail");
        try {
            if ("" != id && null != id) {
                SystemTypeVo systemType = iSystemTypeService.selectSystemTypeVoById(id);
                mv.addObject("systemType", systemType);
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mv;
    }
    
    /**
     * 接入系统名称校验
     * @param systemName
     * @param request
     * @param response
     */
    @RequestMapping(value = "systemType/checkSystemNameValid", method = RequestMethod.POST)
    public void checkSystemNameValid(String systemName, String id, HttpServletRequest request, HttpServletResponse response) {
        try {
        	log.info("systemType/checkSystemNameValid start......");
            response.setContentType("text/html;charset=UTF-8");
            systemName = systemName.trim();
            boolean result = false;
            if (StringUtils.isNotBlank(systemName)) {
                result = iSystemTypeService.checkSystemNameValid(systemName, id);
            }
            response.getWriter().print(result);
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }
    
    @RequestMapping(value = "systemType/checkSystemCodeValid", method = RequestMethod.POST)
    public void checkSystemCode(String systemCode, String id, HttpServletRequest request, HttpServletResponse response) {
    	try {
			log.info("systemType/checkSystemCodeValid start......");
			response.setContentType("text/html;charset=UTF-8");
			systemCode = systemCode.trim();
			boolean result = false;
			if (StringUtils.isNotBlank(systemCode)) {
				result = iSystemTypeService.checkSystemCodeValid(systemCode, id);
			}
			response.getWriter().print(result);
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
    }
    
    @RequestMapping(value = "systemType/checkCompanyDomainValid", method = RequestMethod.POST)
    public void checkCompanyDomain(String companyDomain, String id, HttpServletRequest request, HttpServletResponse response) {
    	try {
			log.info("systemType/checkCompanyDomainValid start......");
			response.setContentType("text/html;charset=UTF-8");
			companyDomain = companyDomain.trim();
			boolean result = false;
			if (StringUtils.isNotBlank(companyDomain)) {
				result = iSystemTypeService.checkCompanyDomainValid(companyDomain, id);
			}
			response.getWriter().print(result);
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
    }
    
    @RequestMapping(value = "systemType/checkPhoneNumberValid", method = RequestMethod.POST)
    public void checkPhoneNumber(String phoneNumber, String id, HttpServletRequest request, HttpServletResponse response) {
    	try {
			log.info("systemType/checkPhoneNumberValid start......");
			response.setContentType("text/html;charset=UTF-8");
			phoneNumber = phoneNumber.trim();
			boolean result = false;
			if (StringUtils.isNotBlank(phoneNumber)) {
				result = iSystemTypeService.checkPhoneNumberValid(phoneNumber, id);
			}
			response.getWriter().print(result);
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
    }
    
    @RequestMapping(value = "systemType/checkEmailValid", method = RequestMethod.POST)
    public void checkEmail(String email, String id, HttpServletRequest request, HttpServletResponse response) {
    	try {
			log.info("systemType/checkEmailValid start......");
			response.setContentType("text/html;charset=UTF-8");
			email = email.trim();
			boolean result = false;
			if (StringUtils.isNotBlank(email)) {
				result = iSystemTypeService.checkEmailValid(email, id);
			}
			response.getWriter().print(result);
		} catch (IOException e) {
			log.error(e.getMessage(), e);
		}
    }
    
    /**
     * 上传平台系统log图片
     * @author dyq-t176  
     * @date 创建时间：2017年11月7日  下午12:02:00
     * @description
     * @param logImg
     * @return
     */
    @RequestMapping(value = "uploadSystemTypeLogimg", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadSystemTypeLogimg(@RequestParam("logoImg") MultipartFile logoImg) {
        log.info("uploadSystemTypeLogimg start......");
        Map<String, Object> obj = new HashMap<String, Object>();
        String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        int rows = 0;
        try {
            Account account = SessionContext.getAccount();
            if (null != account) {
                long size = logoImg.getSize();
                if (size / 1024 > imgSize) {
                    obj.put("sizeError", "sizeError");
                    return obj;
                }
                // 校验图片格式
                boolean isLegal = false;
                for (String type : IMAGE_TYPE) {
                    if (StringUtils.endsWithIgnoreCase(logoImg.getOriginalFilename(), type)) {
                        isLegal = true;
                        break;
                    }
                }
                if (isLegal) {
                    InputStream is = logoImg.getInputStream();
                    BufferedImage image = ImageIO.read(is);
                    if (null != image) {
                        byte[] logoBytes = logoImg.getBytes();
                        SystemType systemType = new SystemType();
                        systemType.setId(account.getSystemId());
                        systemType.setLogoImg(logoBytes);
                        rows = iSystemTypeService.updateByPrimaryKeySelective(systemType);
                        is.close();
                    }
                }
                if (rows > 0) {
                    status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        obj.put("status", status);
        return obj;
    }
    
    @RequestMapping(value = "getLogoimg", method = RequestMethod.GET)
    public void getLogoimg(HttpServletRequest request, HttpServletResponse response) {
        log.info("getLogoimg start......");
        OutputStream outputStream = null;
        InputStream stream = null;
        try {
            outputStream = response.getOutputStream();
            Account account = SessionContext.getAccount();
            if (null != account) {
                SystemType systemType = iSystemTypeService.selectByPrimaryKey(account.getSystemId());
                if (null != systemType) {
                    byte[] logoimgByte = systemType.getLogoImg();
                    if (null != logoimgByte && logoimgByte.length > 0) {
                        stream = new ByteArrayInputStream(logoimgByte);
                        int len = 0;
                        byte[] buf = new byte[1024];
                        while ((len = stream.read(buf, 0, 1024)) != -1) {
                            outputStream.write(buf, 0, len);
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            if (null != outputStream) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    log.error(e.getMessage(), e);
                }
            }
            if (null != stream) {
                try {
                    stream.close();
                } catch (IOException e) {
                    log.error(e.getMessage(), e);
                }
            }
        }
    }
}
