Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DD1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jun 2022 09:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiFLJAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiFLJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:00:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012549F3E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a15so3704917wrh.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MH4Lv8K62JKUOJxVHdgE/oEdWi4lVPPJtSl5KwJG+1g=;
        b=p23NZpYkNV6Mw0OmtGi312n7HxeU9JJ/KfuYg25OWavQonbuxP2PlxFs7ZNZZmpppx
         e8oH+SylS9UYulExeaAjCPDHKx7nTbs1/SxiYfEWenUQ605TBPwdT41rY6WtmUWw4NTE
         mJsDBZYyuxn9oqyK0A9GWbS6xXQ3e+sQCMySI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MH4Lv8K62JKUOJxVHdgE/oEdWi4lVPPJtSl5KwJG+1g=;
        b=O3D8XrJpvhkQbLEAy/DgLH0GOSr9s4jAY63yYIbChqrQzKdnAAK3r5MOEnfJYv3HaH
         M2oMKHoqzeswjDw5pMoRzgcJ/7eRqdGMoEIe0JwOkNHOlrCGkltIZlfp6pfHdlUkNMX7
         e/jwZUvX0ycU/Dtr0gy8F90D7+uwipW2Qpq3EcEvoMKJHhtN+0W2JnQKduj6azwLGgG6
         viAtoRyP2aqLshQ/MS33axvY+gZ+1y/sC+TW9n/Om0tqH7utQd5HIyomKZhapww33xSr
         /I4+Z2wEwhruhJtUvBJX9W2Dyu/zpKAt3KJZPc7EyFE+hK3C9fgWL4B02flGBng+/XKZ
         sQmQ==
X-Gm-Message-State: AOAM5324h4Xpqz3z1caIW6EwqKid8qc0cBo93WNDkK9FD8/1bUojc9O7
        rwdHxcWO1ZQdivsMkjmADXJABw==
X-Google-Smtp-Source: ABdhPJzPfVvDi7oTmyqgIAHJ2AcFuN31YYqfCHQZc8+YvM1Z23odoVoyM/EwdMd9H9m+5olvSCaDUQ==
X-Received: by 2002:a5d:4c49:0:b0:210:353c:1c91 with SMTP id n9-20020a5d4c49000000b00210353c1c91mr52527060wrt.159.1655024434317;
        Sun, 12 Jun 2022 02:00:34 -0700 (PDT)
Received: from localhost.localdomain ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id d34-20020a05600c4c2200b0039c5b4ab1b0sm4798603wmp.48.2022.06.12.02.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 02:00:32 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC,x86 v2 1/8] arch, x86, uaccess: Add nontemporal copy functions
Date:   Sun, 12 Jun 2022 01:57:50 -0700
Message-Id: <1655024280-23827-2-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic non-temporal wrapper to uaccess which can be overridden by
arches that support non-temporal copies.

An implementation is added for x86 which wraps an existing non-temporal
copy in the kernel.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 arch/x86/include/asm/uaccess_64.h | 6 ++++++
 include/linux/uaccess.h           | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 45697e0..ed41dba 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -65,6 +65,12 @@ extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned s
 extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 			   size_t len);
 
+static inline unsigned long
+__copy_from_user_nocache(void *dst, const void __user *src, unsigned long size)
+{
+	return (unsigned long)__copy_user_nocache(dst, src, (unsigned int) size, 0);
+}
+
 static inline int
 __copy_from_user_inatomic_nocache(void *dst, const void __user *src,
 				  unsigned size)
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 5a328cf..6612c37 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -256,6 +256,12 @@ static inline size_t probe_subpage_writeable(char __user *uaddr, size_t size)
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
 static inline __must_check unsigned long
+__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
+{
+	return __copy_from_user(to, from, n);
+}
+
+static inline __must_check unsigned long
 __copy_from_user_inatomic_nocache(void *to, const void __user *from,
 				  unsigned long n)
 {
-- 
2.7.4

