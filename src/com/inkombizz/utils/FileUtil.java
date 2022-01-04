package com.inkombizz.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.List;
import java.util.ArrayList;

// Utilities for file copy : in your project you may use apache commons or other api

/**
 * User: mihai.panaitescu
 * Date: 16-Feb-2010
 * Time: 17:25:21
 */
public class FileUtil {

    public static void copyToDir(File source, File dest) throws IOException {
        copyToDir(source, dest, true);
    }

    public static void copyToDir(File source, File dest, boolean overwrite) throws IOException {
        File destFile = new File(dest.getAbsolutePath() + File.separator + source.getName());
        if (!overwrite && destFile.exists()) {
            throw new IOException("File '" + destFile.getName() + "' already exists!");
        }
        copy(source, destFile);
    }

    // copy all files recursively from directory source to directory dest
    // dest directory must be already created!
    public static void copyDirToDir(File source, File dest) throws IOException {
        if (!source.isDirectory() || !dest.isDirectory()) {
            return;
        }

        List<File> files = listFiles(source, null, true);
        String sourcePath = source.getAbsolutePath();
        String destPath = dest.getAbsolutePath();
        for (File file : files) {
            String filePath = file.getAbsolutePath();
            if (sourcePath.equals(filePath)) {
                continue;
            }
            String newPath = destPath + File.separator + filePath.substring(sourcePath.length());
            File destFile = new File(newPath);
            if (file.isDirectory()) {
                destFile.mkdirs();
            } else {
                copy(file, destFile);
            }
        }
    }

    public static void copy(File source, File dest) throws IOException {
        InputStream in = null;
        OutputStream out = null;
        try {
            in = new FileInputStream(source);
            out = new FileOutputStream(dest);
            byte[] buf = new byte[1024];
            int len;
            while ((len = in.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
    }

    public static List<File> listFiles(File directory, FilenameFilter filter, boolean recurse) {
        // List of files / directories
        List<File> files = new ArrayList<File>();
        // Get files / directories in the directory
        File[] entries = directory.listFiles();
        if (entries == null) {
            return files;
        }
        // Go over entries
        for (File entry : entries) {
            // If there is no filter or the filter accepts the
            // file / directory, add it to the list
            if (filter == null || filter.accept(directory, entry.getName())) {
                files.add(entry);
            }
            // If the file is a directory and the recurse flag
            // is set, recurse into the directory
            if (recurse && entry.isDirectory()) {
                files.addAll(listFiles(entry, filter, recurse));
            }
        }

        // Return collection of files
        return files;
    }
    
    public static String getExtentitonFile(File file)
	{
            String fileExtension="";
            // Get file Name first
            String fileName=file.getName();

            // If fileName do not contain "." or starts with "." then it is not a valid file
            if(fileName.contains(".") && fileName.lastIndexOf(".")!= 0)
            {
                    fileExtension=fileName.substring(fileName.lastIndexOf(".")+1);
            }

            return fileExtension;
	}
    
}
